using CWM.Controllers;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Database;
using CWM.Database.Repositories;
using CWM.Models;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<ICityRepository, CityRepository>();
builder.Services.AddTransient<ICountryRepository, CountryRepository>();
builder.Services.AddTransient<IAppointmentRepository, AppointmentRepository>();
builder.Services.AddTransient<IPartRepository, PartRepository>();
builder.Services.AddTransient<IAppointmentTypeRepository, AppointmentTypeRepository>();
builder.Services.AddTransient<IAppointmentBlockedRepository, AppointmentBlockedRepository>();

builder.Services.AddAutoMapper(typeof(CityRepository));
builder.Services.AddAutoMapper(typeof(Program));


builder.Services.AddControllersWithViews();
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<CWMContext>(options => options.UseSqlServer(connectionString));


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseCors(x => x.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());

app.UseHttpsRedirection();

//app.UseAuthorization();

app.MapControllers();

app.Run();
