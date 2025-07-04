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
    public class ExpensesController(IMapper mapper, IExpensesRepository expensesRepository) : BaseCrudController<Expenses, ExpensesSearch, ExpensesInsertUpdate, ExpensesInsertUpdate>(mapper, expensesRepository)
    {
        private readonly IExpensesRepository ExpensesRepository = expensesRepository;

        [Authorize(Roles = "Admin")]
        [HttpGet("GetFinanceReport")]
        public async Task<Core.Models.ReportExpensesTotal> GetFinanceReport([FromQuery] ReportWorkOrderSearch search)
            => await ExpensesRepository.GetFinanceReport(search);
    }
}
