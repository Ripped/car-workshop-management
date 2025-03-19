using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Interfaces.Services
{
    public interface IRecommendService
    {
        void TrainModel(int id);
        List<Core.Models.Part> RecommendProizvodi(int id);
    }
}
