using CWM.Database.Mappings;
using CWM.Mappings;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;


public static class ServiceExtensions
{
    

    public static void AddAutoMapper(this IServiceCollection serviceCollection)
    {
        serviceCollection.AddAutoMapper(typeof(ApiProfile));
        serviceCollection.AddAutoMapper(typeof(RepositoryProfile));
    }
}

