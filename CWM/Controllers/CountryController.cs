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
    public class CountryController : BaseCrudController<Country, CountrySearch, CountryInsertUpdate, CountryInsertUpdate>
    {
        public CountryController(IMapper mapper, ICountryRepository countryRepository) : base(mapper, countryRepository) { }
    }
}
