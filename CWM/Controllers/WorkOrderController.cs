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
    public class WorkOrderController : BaseCrudController<WorkOrder, WorkOrderSearch, WorkOrderInsertUpdate, WorkOrderInsertUpdate>
    {
        public WorkOrderController(IMapper mapper, IWorkOrderRepository workOrderRepository) : base(mapper, workOrderRepository) { }
    }
}
