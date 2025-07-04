using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using CWM.Database.Repositories;
using CWM.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CWM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WorkOrderController(IMapper mapper, IWorkOrderRepository workOrderRepository) : BaseCrudController<Core.Models.WorkOrder, WorkOrderSearch, WorkOrderInsertUpdate, WorkOrderInsertUpdate>(mapper, workOrderRepository)
    {
        private readonly IWorkOrderRepository WorkOrderRepository = workOrderRepository;

        [Authorize(Roles = "Admin")]
        [HttpGet("GetServiceReport")]
        public async Task<ReportWorkOrder> GetServiceReport([FromQuery] ReportWorkOrderSearch search)
            =>  await WorkOrderRepository.GetServiceReport(search);

        [Authorize(Roles = "Admin")]
        [HttpGet("GetOrderReport")]
        public async Task<ReportWorkOrder> GetOrderReport([FromQuery] ReportWorkOrderSearch search)
            => await WorkOrderRepository.GetOrderReport(search);
    }
}
