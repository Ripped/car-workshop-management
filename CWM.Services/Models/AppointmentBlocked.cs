using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Models
{
    [Table("AppointmentBlocked")]

    public class AppointmentBlocked
    {
        public int Id { get; set; }

        public DateTime BlockedDate { get; set; }


        public virtual ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    }
}
