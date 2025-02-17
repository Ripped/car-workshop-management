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
    public class PartWorkOrderController : BaseCrudController<PartWorkOrder, PartWorkOrderSearch, PartWorkOrderInsertUpdate, PartWorkOrderInsertUpdate>
    {
        public PartWorkOrderController(IMapper mapper, IPartWorkOrderRepository partWorkOrderRepository) : base(mapper, partWorkOrderRepository) { }
    }
}
