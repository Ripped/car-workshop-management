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
    public class EmployeeRepository : BaseRepository<Employee, Core.Models.Employee, EmployeeSearch>, IEmployeeRepository
    {
        public EmployeeRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        public override async Task<Core.Models.Employee> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .Employees
                    .Include(x => x.City)
                    .Include(x => x.Citizenship)
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.Employee>(entity);
            }

            return new Core.Models.Employee();
        }
        protected override IQueryable<Employee> AddInclude(IQueryable<Employee> query, EmployeeSearch? search = null)
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
    }
}
