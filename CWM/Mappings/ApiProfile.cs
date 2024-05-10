using AutoMapper;
using CWM.Core.Models;
using CWM.Models;

namespace CWM.Mappings
{
    public class ApiProfile : Profile
    {
        public ApiProfile()
        {
            CreateMap<CityInsertUpdate, City>()
            .ForMember(x => x.Country, opt => opt.MapFrom(y => new Country { Id = y.CountryId ?? 0 }))
            .ForMember(x => x.ZipCode, opt => opt.MapFrom(y => y.ZipCode ?? ""));

            CreateMap<CountryInsertUpdate, Country>();

            CreateMap<AppointmentInsertUpdate, Appointment>()
            .ForMember(x => x.User, opt => opt.MapFrom(y => new User { Id = y.UserId ?? 0 }))
            .ForMember(x => x.AppointmentType, opt => opt.MapFrom(y => new AppointmentType { Id = y.AppointmentTypeId ?? 0 }));

            CreateMap<AppointmentTypeInsertUpdate, AppointmentType>();

            CreateMap<AppointmentBlockedInsertUpdate, AppointmentBlocked>();

            CreateMap<PartInsertUpdate, Part>();

        }
    }
}
