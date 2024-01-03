using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models.Searches;
using CWM.Database.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Repositories
{
    public class CountryRepository : BaseRepository<Country, Core.Models.Country, CountrySearch>, ICountryRepository
    {
        public CountryRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        protected override IQueryable<Country> AddInclude(IQueryable<Country> query, CountrySearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.Name))
                query = query.Where(x => x.Name.ToLower().Contains(search.Name.ToLower()));

            return query;
        }
    }
}
