using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models.Searches;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Repositories
{
    public class UserRoleRepository : BaseRepository<UserRole, Core.Models.UserRole, UserRoleSearch>, IUserRoleRepository
    {
        public UserRoleRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }

        public override async Task<Core.Models.UserRole> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .UserRoles
                    .Include(x => x.User)
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.UserRole>(entity);
            }

            return new Core.Models.UserRole();
        }
        protected override IQueryable<UserRole> AddInclude(IQueryable<UserRole> query, UserRoleSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.UserUsername))
                query = query.Where(x => x.User!.Username.ToLower().Contains(search.UserUsername.ToLower()));

            if (search.IncludeUser)
                query = query.Include(x => x.User);

            return query;
        }
    }
}
