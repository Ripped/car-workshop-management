using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Services.Database
{
    public class CWMContext : DbContext
    {
        public CWMContext(DbContextOptions<CWMContext> options) : base(options) { }
    }
}
