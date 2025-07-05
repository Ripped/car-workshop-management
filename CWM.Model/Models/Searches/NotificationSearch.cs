using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models.Searches
{
    public class NotificationSearch : BaseSearch
    {
        public string? Name { get; set; }
        public int? UserId { get; set; }
        public bool IncludeUser { get; set; }
    }
}
