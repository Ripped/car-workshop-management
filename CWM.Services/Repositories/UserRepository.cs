using AutoMapper;
using CWM.Core.Helpers;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models.Searches;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore;

namespace CWM.Database.Repositories
{
    public class UserRepository : BaseRepository<User, Core.Models.User, UserSearch>, IUserRepository
    {
        public UserRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        public override async Task<Core.Models.User> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .Appointments
                    .Include(x => x.AppointmentType)
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.User>(entity);
            }

            return new Core.Models.User();
        }
        protected override IQueryable<User> AddInclude(IQueryable<User> query, UserSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.Name))
                query = query.Where(x =>
                    x.FirstName.ToLower().Contains(search.Name.ToLower()) ||
                    x.LastName.ToLower().Contains(search.Name.ToLower()) ||
                    x.Email.ToLower().Contains(search.Name.ToLower())
                );

            if (search.IncludeCity)
                query = query.Include(x => x.City);

            if (search.IncludeCountry)
                query = query.Include(x => x.Citizenship);

            return query;
        }

        public async Task<Core.Models.User> Login(string email, string password)
        {
            var user = await Context
                .Users
                .Include(x => x.Roles)
                .FirstOrDefaultAsync(x =>
                    x.Email == email &&
                    x.Password == EncryptionHelpers.Hash(password)
                );

            return Mapper.Map<Core.Models.User>(user);
        }
    }
}
