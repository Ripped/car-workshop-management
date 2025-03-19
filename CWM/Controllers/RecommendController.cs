using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Interfaces.Services;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using Microsoft.AspNetCore.Mvc;

namespace CWM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RecommendController: ControllerBase
    {
        private readonly IRecommendService Q_recommendService;

        public RecommendController(IRecommendService recommendService_)
        {
            Q_recommendService = recommendService_;
        }

        [HttpGet("/RecommendParts/{id}")]
        public List<Core.Models.Part> RecommendProizvodi(int id)
        {
            return Q_recommendService.RecommendProizvodi(id);
        }
    }
}
