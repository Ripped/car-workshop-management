using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class PagedResult<T>
    {
        public List<T> Result { get; set; } = new();

        public int TotalCount { get; set; }

        public int TotalPages => (int)Math.Ceiling((double)TotalCount / PageSize);

        public int Page { get; set; } = 1;

        public int PageSize { get; set; } = 10;
    }
}
