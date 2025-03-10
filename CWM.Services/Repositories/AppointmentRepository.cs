using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.SqlServer.Query.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using static System.Formats.Asn1.AsnWriter;
using Appointment = CWM.Database.Models.Appointment;

namespace CWM.Database.Repositories
{
    public class AppointmentRepository : BaseRepository<Appointment, Core.Models.Appointment, AppointmentSearch>, IAppointmentRepository
    {
        public AppointmentRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
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

        /*public async override Task<Appointment> InsertAsync(Appointment model)
        {
            var entity = Mapper.Map<Appointment>(model);

            var addedEntity = await Context
                .Set<Appointment>()
                .AddAsync(entity);

            await Context.SaveChangesAsync();

            AppointmentNotifier reservationNotifier = new AppointmentNotifier()
            {
                Id = model.Id,
                Description = model.Description,
                StartDate = model.StartDate,
                EndDate = model.EndDate,
                Vehicle = model.Vehicle?.Chassis.ToString(),
                User = model.User?.ToString()
            };

            return Mapper.Map<Appointment>(addedEntity.Entity);
        }*/

        /*public async override Task<Appointment> InsertAsync(Appointment insert)
        {
            var korisnik = await _korisniciService.GetById(insert.KorisnikId);

            if (korisnik == null)
                return null;

            var usluga = await _uslugaService.GetById(insert.UslugaId);

            if (usluga == null)
                return null;

            var uposlenik = await _uposlenikService.GetById(insert.UposlenikId);

            if (uposlenik == null)
                return null;

            bool isUposlenikDostupan = await IsUposlenikDostupan(uposlenik.UposlenikId, insert.Datum, insert.Vrijeme);

            if (!isUposlenikDostupan)
                throw new UserException("Odabrani uposlenik " + uposlenik.Ime + uposlenik.Prezime + " nije dostupan.Molimo odaberite drugog uposlenika ili drugi termin.");

            var rezervacija = new Appointment()
            {
                d
                Datum = insert.Datum,
                Vrijeme = insert.Vrijeme,
                Status = insert.Status,
                KorisnikId = korisnik.KorisniciId,
                UposlenikId = uposlenik.UposlenikId,
                UslugaId = usluga.UslugaId
            };

            await _dbContext.Rezervacija.AddAsync(rezervacija);

            await _dbContext.SaveChangesAsync();

            Model.ReservationNotifier reservationNotifier = new ReservationNotifier()
            {
                Id = rezervacija.RezervacijaId,
                UposlenikIme = uposlenik.Ime,
                UposlenikPrezime = uposlenik.Prezime,
                UslugaNaziv = usluga.Naziv,
                KorisnikIme = korisnik.Ime,
                CijenaUsluge = usluga.Cijena,
                Email = korisnik.Email,
                Datum = rezervacija.Datum,
                Vrijeme = rezervacija.Vrijeme
            };

            _messageProducer.SendingObject(reservationNotifier);

            return _mapper.Map<Model.Rezervacija>(rezervacija);
        }*/
    }
}
