using CWM.Database.Models;
using CWM.Database.Seed;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database
{
    public class CWMContext : DbContext
    {

        public DbSet<Appointment> Appointments { get; set; }
        public DbSet<AppointmentType> AppointmentTypes { get; set; }
        public DbSet<AppointmentBlocked> AppointmentBlocked { get; set; }
        public DbSet<City> Cities { get; set; }
        public DbSet<Country> Countries { get; set; }
        public DbSet<Part> Parts { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserRole> UserRoles { get; set; }
        public DbSet<Vehicle> Vehicles { get; set; }
        public DbSet<VehicleServiceHistory> VehicleServiceHistory { get; set; }
        public DbSet<WorkOrder> WorkOrders { get; set; }
        public DbSet<Employee> Employees { get; set; }
        public DbSet<PartWorkOrder> PartWorkOrder { get; set; }
        public DbSet<UserRating> UserRatings { get; set; }

        public CWMContext() { }

        public CWMContext(DbContextOptions<CWMContext> options) : base(options) { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
                optionsBuilder.UseSqlServer("Server=localhost; Database=190011; Trusted_Connection=True; Encrypt=False; User ID=sa; Password=QWElkj132!;");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(CWMContext).Assembly);

            modelBuilder.Entity<Appointment>().SeedData();
            modelBuilder.Entity<AppointmentBlocked>().SeedData();
            modelBuilder.Entity<AppointmentType>().SeedData();
            modelBuilder.Entity<City>().SeedData();
            modelBuilder.Entity<Country>().SeedData();
            modelBuilder.Entity<Part>().SeedData();
            modelBuilder.Entity<User>().SeedData();
            modelBuilder.Entity<UserRole>().SeedData();
            modelBuilder.Entity<Vehicle>().SeedData();
            modelBuilder.Entity<VehicleServiceHistory>().SeedData();
            modelBuilder.Entity<WorkOrder>().SeedData();
            modelBuilder.Entity<Employee>().SeedData();
            modelBuilder.Entity<PartWorkOrder>().SeedData();
            modelBuilder.Entity<UserRating>().SeedData();
        }
    }
}
