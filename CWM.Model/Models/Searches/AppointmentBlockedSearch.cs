using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models.Searches
{
    public class AppointmentBlockedSearch : BaseSearch
    {
        public DateTime? BlockedDate { get; set; }
    }
}
