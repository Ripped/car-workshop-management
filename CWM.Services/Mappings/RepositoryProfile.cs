using AutoMapper;
using CWM.Database.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Mappings
{
    public class RepositoryProfile : Profile
    {
        public RepositoryProfile() 
        {
            CreateMap<City, Core.Models.City>();
            CreateMap<Core.Models.City, City>()
                .ForMember(x => x.CountryId, opt => opt.MapFrom(y => y.Country.Id))
                .ForMember(x => x.Country, opt => opt.Ignore());

            CreateMap<Country, Core.Models.Country>()
            .ReverseMap();

            CreateMap<Appointment, Core.Models.Appointment>();
            CreateMap<Core.Models.Appointment, Appointment>()
            .ForMember(x => x.UserId, opt => opt.MapFrom((src, dest) => src.User?.Id))
            .ForMember(x => x.User, opt => opt.Ignore());
        }
    }
}
