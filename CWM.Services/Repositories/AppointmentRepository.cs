using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Configurations;
using CWM.Core.Models.Searches;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using RabbitMQ.Client;
using System.Runtime.InteropServices;
using System.Text;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
using Appointment = CWM.Database.Models.Appointment;

namespace CWM.Database.Repositories
{
    public class AppointmentRepository : BaseRepository<Appointment, Core.Models.Appointment, AppointmentSearch>, IAppointmentRepository
    {
        private readonly IModel _channel;
        private readonly RabbitMQConfiguration RabbitMQConfiguration;
        public AppointmentRepository(CWMContext context, IMapper mapper, IOptions<RabbitMQConfiguration> rabbitMQConfiguration) : base(context, mapper) {
        RabbitMQConfiguration = rabbitMQConfiguration.Value;
        var factory = new ConnectionFactory
            {
            HostName = RabbitMQConfiguration.Host,
            UserName = RabbitMQConfiguration.User,
            Password = RabbitMQConfiguration.Password,
            Port = RabbitMQConfiguration.Port,

        };
            var connection = factory.CreateConnection();
            _channel = connection.CreateModel();
            _channel.QueueDeclare(queue: "reservationQueue",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);
        }
        public override async Task<Core.Models.Appointment> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .Appointments
                    .Include(x => x.AppointmentType)
                    .Include(x => x.User)
                    .Include(x => x.Vehicle)
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.Appointment>(entity);
            }

            return new Core.Models.Appointment();
        }
        protected override IQueryable<Appointment> AddInclude(IQueryable<Appointment> query, AppointmentSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.ServiceName))
                query = query.Where(x => x.Description.ToLower().Contains(search.ServiceName.ToLower()));

            if (!string.IsNullOrWhiteSpace(search.AppointmentId))
                query = query.Where(x => x.Id.ToString().ToLower().Contains(search.AppointmentId.ToLower()));

            if (search.UserId > 0)
                query = query.Where(x => x.User!.Id == search.UserId);

            if (search.IncludeAppointmentType)
                query = query.Include(x => x.AppointmentType);


            return query;
        }

        public async Task<Core.Models.Appointment> Update(int id, Core.Models.Appointment model)
        {
            var user = await Context.Users.SingleOrDefaultAsync(x => x.Id == model.User!.Id);
            var vehicle = await Context.Vehicles.SingleOrDefaultAsync(x=> x.Id == model.Vehicle!.Id);

            AppointmentNotifier notifier = new AppointmentNotifier
            {
                Description = model.Description,
                StartDate = model.StartDate,
                EndDate = model.EndDate,
                Vehicle = vehicle!.Chassis.ToString(),
                UserName = $"{user!.FirstName}" + " " + $"{user!.LastName}",
                Email = user!.Email
            };

            if (model.AppointmentType!.Id == 2) { notifier.IsApproved = true; }
            else if (model.AppointmentType!.Id == 3) { notifier.IsApproved = false; }

            var emailmessage = $"";

            if (notifier.IsApproved)
            {
                emailmessage = $"Poštovani/a, {notifier.UserName} {notifier.Email} " +
                $"\n\nVaša rezervacija je uspješno potvrđena!" +
                $"\nDatum: {notifier.StartDate.ToShortDateString()} " +
                $"\nBroj sasije: {notifier.Vehicle} " +
                $"\n\nMolimo Vas dođite na vrijeme na vaš termin. Ako se desi da ne možete doći, molimo vas da nas obavijestite što prije ili otkažete svoj termin." +
                $"\n\nHvala vam na povjerenju i radujemo se što ćemo vam pružiti izvrsno iskustvo u našem servisu!";
            }
            else
            {
                emailmessage = $"Poštovani/a, {notifier.UserName} {notifier.Email}" +
                $"\n\nVaša rezervacija je odbijena! {notifier.Email}" + 
                $"\n\nMolimo vas rezervisite novi termin ili se javite na broj telefona za rezervaciju." +
                $"\n\nHvala vam na povjerenju i radujemo se vasem javljanju za novi termin!";
            }

            var body = Encoding.UTF8.GetBytes(emailmessage);
            _channel.BasicPublish(exchange: string.Empty,
                                  routingKey: "reservationQueue",
                                  basicProperties: null,
                                  body: body);
            
            await UpdateAsync(Mapper.Map<Core.Models.Appointment>(model, opt => opt.AfterMap((src, dest) => dest.Id = id)));

            return Mapper.Map<Core.Models.Appointment>(model);
        }
    }
}
