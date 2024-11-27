using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System.Reflection;

namespace CWM.Database.Extensions
{
    public static class ServiceExtensions
    {
        public static void AddDbContext(this IServiceCollection services, string connectionString) =>
        services.AddDbContext<DbContext>(options =>
            options.UseSqlServer(connectionString)
                   .UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking)
        );

        public static void DatabaseMigrate(this IServiceProvider service)
        {
            using var scope = service.CreateScope();
            var context = scope.ServiceProvider.GetRequiredService<CWMContext>();

            if (!context.Database.CanConnect())
                context.Database.Migrate();
        }
    }
}
