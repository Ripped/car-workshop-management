using CWM.Core.Models;
using CWM.Core.Models.Searches;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Interfaces.Repositories
{
    public interface IPartWorkOrderRepository : IBaseRepository<PartWorkOrder, PartWorkOrderSearch>
    {
    }
}
