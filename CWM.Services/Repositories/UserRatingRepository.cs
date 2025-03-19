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
    public class UserRatingRepository : BaseRepository<UserRating, Core.Models.UserRating, UserRatingSearch>, IUserRatingRepository
    {
        public UserRatingRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }

        public override async Task<Core.Models.UserRating> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .PartWorkOrder
                    .Include(x => x.Part)
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.UserRating>(entity);
            }

            return new Core.Models.UserRating();
        }
    }
}
