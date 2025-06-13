using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models.Searches
{
    public class UserRoleSearch : BaseSearch
    {
        public string? UserUsername { get; set; }
        public bool IncludeUser { get; set; }
    }
}
