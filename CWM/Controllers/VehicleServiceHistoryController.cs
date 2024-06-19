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
    public class VehicleServiceHistoryController : BaseCrudController<VehicleServiceHistory, VehicleServiceHistorySearch, VehicleServiceHistoryInsertUpdate, VehicleServiceHistoryInsertUpdate>
    {
        public VehicleServiceHistoryController(IMapper mapper, IVehicleServiceHistoryRepository vehicleServiceHistoryRepository) : base(mapper, vehicleServiceHistoryRepository) { }
    }
}
