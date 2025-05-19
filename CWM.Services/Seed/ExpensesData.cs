using CWM.Core.Models.Enums;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace CWM.Database.Seed
{
    public static class ExpensesData
    {
        public static void SeedData(this EntityTypeBuilder<Expenses> entity)
        {
            entity.HasData(
                new Expenses
                {
                    Id = 1,
                    Description = "",
                    EmployeeId = 1,
                    Date = new DateTime(2023, 4, 5),
                    TotalAmount = 200,
                    ExpensesType = ExpensesType.Edukacija
                },
                new Expenses
                {
                    Id = 2,
                    Description = "",
                    EmployeeId = 2,
                    Date = new DateTime(2023, 4, 5),
                    TotalAmount = 270,
                    ExpensesType = ExpensesType.Edukacija
                },
                new Expenses
                {
                    Id = 3,
                    Description = "",
                    EmployeeId = 3,
                    Date = new DateTime(2022, 4, 5),
                    TotalAmount = 250,
                    ExpensesType = ExpensesType.Edukacija
                },
                new Expenses
                {
                    Id = 4,
                    Description = "",
                    EmployeeId = 4,
                    Date = new DateTime(2024, 1, 5),
                    TotalAmount = 500,
                    ExpensesType = ExpensesType.Edukacija
                },
                new Expenses
                {
                    Id = 5,
                    Description = "",
                    EmployeeId = 5,
                    Date = new DateTime(2023, 2, 6),
                    TotalAmount = 100,
                    ExpensesType = ExpensesType.Edukacija
                },
                new Expenses
                {
                    Id = 6,
                    Description = "",
                    EmployeeId = 6,
                    Date = new DateTime(2023, 7, 2),
                    TotalAmount = 300,
                    ExpensesType = ExpensesType.Edukacija
                },
                new Expenses
                {
                    Id = 7,
                    Description = "",
                    EmployeeId = 1,
                    Date = new DateTime(2023, 4, 5),
                    TotalAmount = 200,
                    ExpensesType = ExpensesType.Plata
                },
                new Expenses
                {
                    Id = 8,
                    Description = "",
                    EmployeeId = 1,
                    Date = new DateTime(2023, 4, 5),
                    TotalAmount = 200,
                    ExpensesType = ExpensesType.Edukacija
                },
                new Expenses
                {
                    Id = 9,
                    Description = "",
                    EmployeeId = 2,
                    Date = new DateTime(2023, 4, 5),
                    TotalAmount = 200,
                    ExpensesType = ExpensesType.Plata
                },
                new Expenses
                {
                    Id = 10,
                    Description = "",
                    EmployeeId = 3,
                    Date = new DateTime(2023, 4, 5),
                    TotalAmount = 200,
                    ExpensesType = ExpensesType.Edukacija
                },
                new Expenses
                {
                    Id = 11,
                    Description = "",
                    EmployeeId = 4,
                    Date = new DateTime(2023, 4, 5),
                    TotalAmount = 200,
                    ExpensesType = ExpensesType.Edukacija
                },
                new Expenses
                {
                    Id = 12,
                    Description = "",
                    EmployeeId = 5,
                    Date = new DateTime(2023, 4, 5),
                    TotalAmount = 200,
                    ExpensesType = ExpensesType.Edukacija
                }
            );
        }
    }
}
