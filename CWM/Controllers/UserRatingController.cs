using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using CWM.Models;
using Microsoft.AspNetCore.Mvc;

namespace CWM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserRatingController : BaseCrudController<UserRating, UserRatingSearch, UserRatingInsertUpdate, UserRatingInsertUpdate>
    {
        public UserRatingController(IMapper mapper, IUserRatingRepository userRatingRepository) : base(mapper, userRatingRepository) { }
    }
}
