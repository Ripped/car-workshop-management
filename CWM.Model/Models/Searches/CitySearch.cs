using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models.Searches
{
    public class CitySearch : BaseSearch
    {
        public string? Name { get; set; }

        public bool IncludeCountry { get; set; }
    }
}
