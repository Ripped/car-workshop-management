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
    public class PartController : BaseCrudController<Part, PartSearch, PartInsertUpdate, PartInsertUpdate>
    {
        public PartController(IMapper mapper, IPartRepository partRepository) : base(mapper, partRepository) { }
    }
}
