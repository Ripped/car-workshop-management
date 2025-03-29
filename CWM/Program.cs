using CWM;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Interfaces.Services;
using CWM.Core.Models.Configurations;
using CWM.Core.Models.Enums;
using CWM.Database;
using CWM.Database.Extensions;
using CWM.Database.Repositories;
using CWM.Extensions;
using CWM.RabbitMQ;
using CWM.Recommender;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Razor.TagHelpers;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
var builder = WebApplication.CreateBuilder(args);
/*var stripeSecretKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY");
var stripePublishableKey = Environment.GetEnvironmentVariable("STRIPE_PUBLISHABLE_KEY");*/

builder.Services.Configure<StripeSettings>(builder.Configuration.GetSection("Stripe"));

builder.Services.Configure<RabbitMQConfiguration>(builder.Configuration.GetSection("RabbitMQ"));
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
builder.Services.AddTransient<IEmployeeRepository, EmployeeRepository>();
builder.Services.AddTransient<IPartWorkOrderRepository, PartWorkOrderRepository>();
builder.Services.AddScoped<IUserRatingRepository, UserRatingRepository>();
builder.Services.AddScoped<IEmailService, EmailService>();
builder.Services.AddScoped<IRecommendService, RecommendService>();
builder.Services.AddScoped<IPaymentService, PaymentRepository>();

builder.Services.AddAutoMapper(typeof(CityRepository));
builder.Services.AddAutoMapper();

builder.UseSerilog();

//builder.Services.AddScopedRepositories();

/*builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

if (!string.IsNullOrEmpty(stripeSecretKey) && !string.IsNullOrEmpty(stripePublishableKey))
{
    builder.Services.Configure<StripeSettings>(options =>
    {
        options.SecretKey = stripeSecretKey;
        options.PublishableKey = stripePublishableKey;
    });
}
else
{
    builder.Services.Configure<StripeSettings>(builder.Configuration.GetSection("Stripe"));
}*/

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
