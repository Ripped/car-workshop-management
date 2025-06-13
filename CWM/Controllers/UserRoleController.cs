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
    public class UserRoleController : BaseCrudController<UserRole, UserRoleSearch, UserRoleInsertUpdate, UserRoleInsertUpdate>
    {
        public UserRoleController(IMapper mapper, IUserRoleRepository userRoleRepository) : base(mapper, userRoleRepository) { }
    }
}
