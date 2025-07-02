using CWM.SMTP;
using CWM.SMTP.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

builder.Services.Configure<RabbitMQConfiguration>(builder.Configuration.GetSection("RabbitMQ"));
builder.Services.Configure<EmailConfiguration>(builder.Configuration.GetSection("Email"));

builder.Services.AddSingleton<IEmailConsumer, EmailConsumer>();
builder.Services.AddSingleton<IEmailService, EmailService>();


// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


var app = builder.Build();

app.Services.GetRequiredService<IEmailConsumer>();
app.Services.GetRequiredService<IEmailService>();
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
