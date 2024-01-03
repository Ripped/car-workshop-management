using CWM.Core.Models;
using CWM.Core.Models.Searches;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Interfaces.Repositories
{
    public interface IBaseRepository<T, TSearch>
        where T : class
        where TSearch : BaseSearch
    {
        Task<T> GetAsync(int id);
        Task<PagedResult<T>> GetAllAsync(TSearch? search = null);
        Task<T> InsertAsync(T model);
        Task InsertRangeAsync(IEnumerable<T> models);
        Task<T> UpdateAsync(T model);
        Task UpdateRangeAsync(IEnumerable<T> models);
        Task<bool> DeleteAsync(int id);
        Task DeleteRangeAsync(IEnumerable<T> models);
    }
}
