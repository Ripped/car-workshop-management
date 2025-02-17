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
            .ForMember(x => x.AppointmentType, opt => opt.MapFrom(y => new AppointmentType { Id = y.AppointmentTypeId ?? 0 }))
            .ForMember(x => x.Vehicle, opt => opt.MapFrom(y => new Vehicle { Id = y.VehicleId ?? 0 }));

            CreateMap<AppointmentTypeInsertUpdate, AppointmentType>();

            CreateMap<AppointmentBlockedInsertUpdate, AppointmentBlocked>();

            CreateMap<PartInsertUpdate, Part>();

            CreateMap<PartWorkOrderInsertUpdate, PartWorkOrder>()
            .ForMember(x => x.Vehicle, opt => opt.MapFrom(y => new Vehicle { Id = y.VehicleId ?? 0 }))
            .ForMember(x => x.Part, opt => opt.MapFrom(y => new Part { Id = y.PartId ?? 0 }))
            .ForMember(x => x.WorkOrder, opt => opt.MapFrom(y => new WorkOrder { Id = y.WorkOrderId ?? 0 }));

            CreateMap<VehicleServiceHistoryInsertUpdate, VehicleServiceHistory>()
            .ForMember(x => x.Vehicle, opt => opt.MapFrom(y => new Vehicle { Id = y.VehicleId ?? 0 }))
            .ForMember(x => x.Employee, opt => opt.MapFrom(y => new Employee { Id = y.EmployeeId ?? 0 }))
            .ForMember(x => x.User, opt => opt.MapFrom(y => new User { Id = y.UserId ?? 0 }));

            CreateMap<VehicleInsertUpdate, Vehicle>()
            .ForMember(x => x.User, opt => opt.MapFrom(y => new User { Id = y.UserId ?? 0 }));

            CreateMap<WorkOrderInsertUpdate, WorkOrder>()
            .ForMember(x => x.Vehicle, opt => opt.MapFrom(y => y.VehicleId == null ? null : new Vehicle { Id = y.VehicleId ?? 0 }))
            .ForMember(x => x.User, opt => opt.MapFrom(y => y.UserId == null ? null : new User { Id = y.UserId ?? 0 }))
            .ForMember(x => x.Appointment, opt => opt.MapFrom(y => y.AppointmentId == null ? null : new Appointment { Id = y.AppointmentId ?? 0 }))
            .ForMember(x => x.Employee, opt => opt.MapFrom(y => y.EmployeeId == null ? null : new Employee { Id = y.EmployeeId ?? 0 }));

            CreateMap<UserInsertUpdate, User>()
            .ForMember(x => x.Citizenship, opt => opt.MapFrom(y => y.CountryId == null ? null : new Country { Id = y.CountryId ?? 0 }))
            .ForMember(x => x.City, opt => opt.MapFrom(y => y.CityId == null ? null : new City { Id = y.CityId ?? 0 }));

            CreateMap<EmployeeInsertUpdate, Employee>()
            .ForMember(x => x.Citizenship, opt => opt.MapFrom(y => y.CountryId == null ? null : new Country { Id = y.CountryId ?? 0 }))
            .ForMember(x => x.City, opt => opt.MapFrom(y => y.CityId == null ? null : new City { Id = y.CityId ?? 0 }));
        }
    }
}
