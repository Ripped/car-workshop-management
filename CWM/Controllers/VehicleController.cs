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
    public class VehicleController : BaseCrudController<Vehicle, VehicleSearch, VehicleInsertUpdate, VehicleInsertUpdate>
    {
        public VehicleController(IMapper mapper, IVehicleRepository vehicleRepository) : base(mapper, vehicleRepository) { }
    }
}
