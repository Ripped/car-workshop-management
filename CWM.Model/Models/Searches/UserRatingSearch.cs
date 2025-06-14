using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models.Searches
{
    public class UserRatingSearch : BaseSearch
    {
        public int? PartId { get; set; }
        public bool IncludePart { get; set; }
        public bool IncludeUser { get; set; }
    }
}
