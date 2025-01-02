using CWM;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models.Enums;
using CWM.Database;
using CWM.Database.Extensions;
using CWM.Database.Repositories;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<ICityRepository, CityRepository>();
builder.Services.AddTransient<IUserRepository, UserRepository>();
builder.Services.AddTransient<ICountryRepository, CountryRepository>();
builder.Services.AddTransient<IAppointmentRepository, AppointmentRepository>();
builder.Services.AddTransient<IPartRepository, PartRepository>();
builder.Services.AddTransient<IAppointmentTypeRepository, AppointmentTypeRepository>();
builder.Services.AddTransient<IAppointmentBlockedRepository, AppointmentBlockedRepository>();
builder.Services.AddTransient<IWorkOrderRepository, WorkOrderRepository>();
builder.Services.AddTransient<IVehicleServiceHistoryRepository, VehicleServiceHistoryRepository>();
builder.Services.AddTransient<IVehicleRepository, VehicleRepository>();

builder.Services.AddAutoMapper(typeof(CityRepository));
builder.Services.AddAutoMapper();

//builder.Services.AddScopedRepositories();

builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

builder.Services.AddMemoryCache();

builder.Services.AddControllersWithViews();
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
            },
            new string[]{}
    } });

});

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<CWMContext>(options => options.UseSqlServer(connectionString));


var app = builder.Build();

app.Services.DatabaseMigrate();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseCors(x => x.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
