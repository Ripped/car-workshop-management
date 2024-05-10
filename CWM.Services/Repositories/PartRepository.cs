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
    public class PartRepository : BaseRepository<Part, Core.Models.Part, PartSearch>, IPartRepository
    {
        public PartRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }

        protected override IQueryable<Part> AddInclude(IQueryable<Part> query, PartSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.Name))
                query = query.Where(x => x.SerialNumber.ToLower().Contains(search.Name.ToLower()));

            return query;
        }
    }
}
