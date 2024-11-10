using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using CWM.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CWM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : BaseCrudController<User, UserSearch, UserInsertUpdate, UserInsertUpdate>
    {
        private readonly IUserRepository _userRepository;
        public UserController(IMapper mapper, IUserRepository userRepository) : base(mapper, userRepository) {
            _userRepository = userRepository;
        }

        [AllowAnonymous]
        [HttpGet("/Login")]
        public async Task<Core.Models.User> Login([FromQuery] UserLogin request)
        {
            return await _userRepository.Login(request.Username, request.Password);
        }
    }
}
