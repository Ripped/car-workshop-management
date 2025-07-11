﻿using AutoMapper;
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
            .ForMember(x => x.User, opt => opt.Ignore())
            .ForMember(x => x.AppointmentTypeId, opt => opt.MapFrom((src, dest) => src.AppointmentType?.Id))
            .ForMember(x => x.AppointmentType, opt => opt.Ignore())
            .ForMember(x => x.VehicleId, opt => opt.MapFrom((src, dest) => src.Vehicle?.Id))
            .ForMember(x => x.Vehicle, opt => opt.Ignore());

            CreateMap<AppointmentType, Core.Models.AppointmentType>()
            .ReverseMap();

            CreateMap<AppointmentBlocked, Core.Models.AppointmentBlocked>()
            .ReverseMap();

            CreateMap<Part, Core.Models.Part>()
            .ReverseMap();

            CreateMap<PartWorkOrder, Core.Models.PartWorkOrder>().ReverseMap();
            CreateMap<Core.Models.PartWorkOrder, PartWorkOrder>()
                .ForMember(x => x.VehicleId, opt => opt.MapFrom((src, dest) => src.Vehicle?.Id))
            .ForMember(x => x.Vehicle, opt => opt.Ignore())
            .ForMember(x => x.PartId, opt => opt.MapFrom((src, dest) => src.Part?.Id))
            .ForMember(x => x.Part, opt => opt.Ignore())
            .ForMember(x => x.WorkOrderId, opt => opt.MapFrom((src, dest) => src.WorkOrder?.Id))
            .ForMember(x => x.WorkOrder, opt => opt.Ignore());

            CreateMap<UserRating, Core.Models.UserRating>().ReverseMap();
            CreateMap<Core.Models.UserRating, UserRating>()
                .ForMember(x => x.UserId, opt => opt.MapFrom((src, dest) => src.User?.Id))
            .ForMember(x => x.User, opt => opt.Ignore())
            .ForMember(x => x.PartId, opt => opt.MapFrom((src, dest) => src.Part?.Id))
            .ForMember(x => x.Part, opt => opt.Ignore());

            CreateMap<VehicleServiceHistory, Core.Models.VehicleServiceHistory>();
            CreateMap<Core.Models.VehicleServiceHistory, VehicleServiceHistory>()
            .ForMember(x => x.VehicleId, opt => opt.MapFrom((src, dest) => src.Vehicle?.Id))
            .ForMember(x => x.Vehicle, opt => opt.Ignore())
            .ForMember(x => x.EmployeeId, opt => opt.MapFrom((src, dest) => src.Employee?.Id))
            .ForMember(x => x.Employee, opt => opt.Ignore())
            .ForMember(x => x.UserId, opt => opt.MapFrom((src, dest) => src.User?.Id))
            .ForMember(x => x.User, opt => opt.Ignore());

            CreateMap<Vehicle, Core.Models.Vehicle>();
            CreateMap<Core.Models.Vehicle, Vehicle>()
            .ForMember(x => x.UserId, opt => opt.MapFrom((src, dest) => src.User?.Id))
            .ForMember(x => x.User, opt => opt.Ignore());

            CreateMap<WorkOrder, Core.Models.WorkOrder>();
            CreateMap<Core.Models.WorkOrder, WorkOrder>()
            .ForMember(x => x.VehicleId, opt => opt.MapFrom((src, dest) => src.Vehicle?.Id))
            .ForMember(x => x.Vehicle, opt => opt.Ignore())
            .ForMember(x => x.UserId, opt => opt.MapFrom((src, dest) => src.User?.Id))
            .ForMember(x => x.User, opt => opt.Ignore())
            .ForMember(x => x.AppointmentId, opt => opt.MapFrom((src, dest) => src.Appointment?.Id))
            .ForMember(x => x.Appointment, opt => opt.Ignore())
            .ForMember(x => x.EmployeeId, opt => opt.MapFrom((src, dest) => src.Employee?.Id))
            .ForMember(x => x.Employee, opt => opt.Ignore());

            CreateMap<User, Core.Models.User>()
            .ForMember(x => x.Roles, opt => opt.MapFrom(y => y.Roles.Select(z => z.Role)));
            CreateMap<Core.Models.User, User>()
            .ForMember(x => x.CitizenshipId, opt => opt.MapFrom((src, dest) => src.Citizenship?.Id))
            .ForMember(x => x.Citizenship, opt => opt.Ignore())
            .ForMember(x => x.CityId, opt => opt.MapFrom((src, dest) => src.City?.Id))
            .ForMember(x => x.City, opt => opt.Ignore());

            CreateMap<UserRole, Core.Models.UserRole>();
            CreateMap<Core.Models.UserRole, UserRole>()
                .ForMember(x => x.UserId, opt => opt.MapFrom(y => y.User.Id))
                .ForMember(x => x.User, opt => opt.Ignore());

            CreateMap<Employee, Core.Models.Employee>();
            CreateMap<Core.Models.Employee, Employee>()
            .ForMember(x => x.CitizenshipId, opt => opt.MapFrom((src, dest) => src.Citizenship?.Id))
            .ForMember(x => x.Citizenship, opt => opt.Ignore())
            .ForMember(x => x.CityId, opt => opt.MapFrom((src, dest) => src.City?.Id))
            .ForMember(x => x.City, opt => opt.Ignore());

            CreateMap<Expenses, Core.Models.Expenses>();
            CreateMap<Core.Models.Expenses, Expenses>()
            .ForMember(x => x.EmployeeId, opt => opt.MapFrom((src, dest) => src.Employee?.Id))
            .ForMember(x => x.Employee, opt => opt.Ignore());

            CreateMap<Notification, Core.Models.Notification>();
            CreateMap<Core.Models.Notification, Notification>()
            .ForMember(x => x.UserId, opt => opt.MapFrom((src, dest) => src.User?.Id))
            .ForMember(x => x.User, opt => opt.Ignore());
        }
    }
}
