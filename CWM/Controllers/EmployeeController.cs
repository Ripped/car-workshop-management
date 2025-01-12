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
    public class EmployeeController : BaseCrudController<Employee, EmployeeSearch, EmployeeInsertUpdate, EmployeeInsertUpdate>
    {
        private readonly IEmployeeRepository _employeeRepository;
        public EmployeeController(IMapper mapper, IEmployeeRepository employeeRepository) : base(mapper, employeeRepository)
        {
            _employeeRepository = employeeRepository;
        }
    }
}
