using CWM.Core.Interfaces.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Text;

namespace CWM.IdentityServer.Controllers;

[ApiController]
[Route("[action]")]
public class AuthController(
    IConfiguration configuration,
    IUserRepository userRepository)
    : ControllerBase
{
    private readonly IConfiguration Configuration = configuration;
    private readonly IUserRepository UserRepository = userRepository;

    [HttpGet]
    public async Task<string> Login(string email, string password)
    {
        var user = await UserRepository.Login(email, password);

        if (user is null)
        {
            Response.StatusCode = (int)HttpStatusCode.Unauthorized;
            return String.Empty;
        }

        var secretKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration.GetValue<string>("JWTSecret")!));

        var signingCredentials = new SigningCredentials(secretKey, SecurityAlgorithms.HmacSha256);

        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Sid, user.Id.ToString()),
            new Claim(ClaimTypes.NameIdentifier, user.Email),
            new Claim(ClaimTypes.Name, user.FirstName + ' ' + user.LastName),
            new Claim(ClaimTypes.Email, user.Email)
        };

        user.Roles.ForEach(x => claims.Add(new Claim(ClaimTypes.Role, x.ToString())));

        var token = new JwtSecurityToken(
            issuer: null,
            audience: null,
            claims: claims,
            expires: DateTime.Now.AddHours(1),
            signingCredentials: signingCredentials
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
