using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace CWM.Database.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AppointmentBlocked",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BlockedDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AppointmentBlocked", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "AppointmentTypes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Color = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AppointmentTypes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Countries",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Countries", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Parts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SerialNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Manufacturer = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PartName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Image = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    Price = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Parts", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Cities",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ZipCode = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CountryId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cities", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Cities_Countries_CountryId",
                        column: x => x.CountryId,
                        principalTable: "Countries",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Employees",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Mobile = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    BirthDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Username = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Adress = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CityId = table.Column<int>(type: "int", nullable: true),
                    CitizenshipId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Employees", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Employees_Cities_CityId",
                        column: x => x.CityId,
                        principalTable: "Cities",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Employees_Countries_CitizenshipId",
                        column: x => x.CitizenshipId,
                        principalTable: "Countries",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Gender = table.Column<int>(type: "int", nullable: false),
                    BirthDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreateDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CityId = table.Column<int>(type: "int", nullable: true),
                    CitizenshipId = table.Column<int>(type: "int", nullable: true),
                    Image = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Username = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Password = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Mobile = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    OfficePhone = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Users_Cities_CityId",
                        column: x => x.CityId,
                        principalTable: "Cities",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Users_Countries_CitizenshipId",
                        column: x => x.CitizenshipId,
                        principalTable: "Countries",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "UserRatings",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductRating = table.Column<double>(type: "float", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: true),
                    PartId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserRatings", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserRatings_Parts_PartId",
                        column: x => x.PartId,
                        principalTable: "Parts",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_UserRatings_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "UserRoles",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    Role = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserRoles", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserRoles_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Vehicles",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Chassis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Brand = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Model = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CubicCapacity = table.Column<int>(type: "int", nullable: false),
                    Kilowatts = table.Column<int>(type: "int", nullable: false),
                    Transmision = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ProductionDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Fuel = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Vehicles", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Vehicles_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Appointments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    StartDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EndDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    AppointmentTypeId = table.Column<int>(type: "int", nullable: true),
                    UserId = table.Column<int>(type: "int", nullable: true),
                    VehicleId = table.Column<int>(type: "int", nullable: true),
                    EmployeeId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Appointments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Appointments_AppointmentTypes_AppointmentTypeId",
                        column: x => x.AppointmentTypeId,
                        principalTable: "AppointmentTypes",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Appointments_Employees_EmployeeId",
                        column: x => x.EmployeeId,
                        principalTable: "Employees",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Appointments_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Appointments_Vehicles_VehicleId",
                        column: x => x.VehicleId,
                        principalTable: "Vehicles",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "VehicleServiceHistory",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ServiceDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ServiceType = table.Column<int>(type: "int", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Sugestions = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    VehicleId = table.Column<int>(type: "int", nullable: true),
                    UserId = table.Column<int>(type: "int", nullable: true),
                    EmployeeId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VehicleServiceHistory", x => x.Id);
                    table.ForeignKey(
                        name: "FK_VehicleServiceHistory_Employees_EmployeeId",
                        column: x => x.EmployeeId,
                        principalTable: "Employees",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_VehicleServiceHistory_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_VehicleServiceHistory_Vehicles_VehicleId",
                        column: x => x.VehicleId,
                        principalTable: "Vehicles",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "AppointmentAppointmentBlocked",
                columns: table => new
                {
                    AppointmentBlockedId = table.Column<int>(type: "int", nullable: false),
                    AppointmentsId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AppointmentAppointmentBlocked", x => new { x.AppointmentBlockedId, x.AppointmentsId });
                    table.ForeignKey(
                        name: "FK_AppointmentAppointmentBlocked_AppointmentBlocked_AppointmentBlockedId",
                        column: x => x.AppointmentBlockedId,
                        principalTable: "AppointmentBlocked",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AppointmentAppointmentBlocked_Appointments_AppointmentsId",
                        column: x => x.AppointmentsId,
                        principalTable: "Appointments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "WorkOrders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OrderNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    StartTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EndTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    GarageBox = table.Column<int>(type: "int", nullable: false),
                    ServicePerformed = table.Column<int>(type: "int", nullable: false),
                    Concerne = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Sugestions = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AppointmentId = table.Column<int>(type: "int", nullable: true),
                    VehicleId = table.Column<int>(type: "int", nullable: true),
                    UserId = table.Column<int>(type: "int", nullable: true),
                    EmployeeId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_WorkOrders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_WorkOrders_Appointments_AppointmentId",
                        column: x => x.AppointmentId,
                        principalTable: "Appointments",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_WorkOrders_Employees_EmployeeId",
                        column: x => x.EmployeeId,
                        principalTable: "Employees",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_WorkOrders_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_WorkOrders_Vehicles_VehicleId",
                        column: x => x.VehicleId,
                        principalTable: "Vehicles",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "PartWorkOrder",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ServiceDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    VehicleId = table.Column<int>(type: "int", nullable: true),
                    PartId = table.Column<int>(type: "int", nullable: true),
                    WorkOrderId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PartWorkOrder", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PartWorkOrder_Parts_PartId",
                        column: x => x.PartId,
                        principalTable: "Parts",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_PartWorkOrder_Vehicles_VehicleId",
                        column: x => x.VehicleId,
                        principalTable: "Vehicles",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_PartWorkOrder_WorkOrders_WorkOrderId",
                        column: x => x.WorkOrderId,
                        principalTable: "WorkOrders",
                        principalColumn: "Id");
                });

            migrationBuilder.InsertData(
                table: "AppointmentBlocked",
                columns: new[] { "Id", "BlockedDate" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 11, 21, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, new DateTime(2024, 11, 22, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 3, new DateTime(2024, 11, 23, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 4, new DateTime(2024, 11, 24, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 5, new DateTime(2024, 11, 25, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 6, new DateTime(2024, 11, 26, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "AppointmentTypes",
                columns: new[] { "Id", "Color", "Name" },
                values: new object[,]
                {
                    { 1, "#cc7e0a", "PENDING" },
                    { 2, "##1bb809", "APPROVED" },
                    { 3, "#fc0303", "NOT APPROVED" }
                });

            migrationBuilder.InsertData(
                table: "Countries",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Bosna i Hercegovina" },
                    { 2, "Crna Gora" },
                    { 3, "Hrvatska" },
                    { 4, "Makedonija" },
                    { 5, "Slovenija" },
                    { 6, "Srbija" }
                });

            migrationBuilder.InsertData(
                table: "Parts",
                columns: new[] { "Id", "Description", "Image", "Manufacturer", "PartName", "Price", "SerialNumber" },
                values: new object[,]
                {
                    { 1, "Kompresor klime", null, "BOSCH", "Kompresor klime", 39m, "RT245GFSW26GFS" },
                    { 2, "Kompresor klime", null, "BOSCH", "Kompresor klime", 39m, "RT245GFSW26GFS" },
                    { 3, "Kompresor klime", null, "BOSCH", "Kompresor klime", 39m, "RT245GFSW26GFS" },
                    { 4, "Kompresor klime", null, "BOSCH", "Kompresor klime", 39m, "RT245GFSW26GFS" },
                    { 5, "Kompresor klime", null, "BOSCH", "Kompresor klime", 39m, "RT245GFSW26GFS" },
                    { 6, "Kompresor klime", null, "BOSCH", "Kompresor klime", 39m, "RT245GFSW26GFS" },
                    { 8, "Lezaj tocka", null, "BOSCH", "Lezaj tocka", 39m, "RH245GFSU26GFS" },
                    { 9, "Filter klime", null, "BOSCH", "Filter klime", 39m, "RT295TFSW76ZFS" },
                    { 10, "Senzor pritiska", null, "BOSCH", "Senzor pritiska", 39m, "RW238TFSW76GFS" },
                    { 11, "Disk plocice", null, "Ferodo", "Disk plocice", 39m, "RT135TFSW74GFS" },
                    { 12, "Disk plocice", null, "Trusting", "Disk plocice", 39m, "RT235HFSW76GES" },
                    { 13, "Diskovi zadnji", null, "SWD", "Diskovi zadnji", 39m, "RT255TFRW76GFS" }
                });

            migrationBuilder.InsertData(
                table: "Cities",
                columns: new[] { "Id", "CountryId", "Name", "ZipCode" },
                values: new object[,]
                {
                    { 1, 6, "Mostar", "" },
                    { 2, 1, "Jablanica", "88420" },
                    { 3, 1, "Gračanica", "88400" },
                    { 4, 5, "Tuzla", "" },
                    { 5, 1, "Srebrenik", "88000" },
                    { 6, 2, "Živinice", "" }
                });

            migrationBuilder.InsertData(
                table: "Employees",
                columns: new[] { "Id", "Adress", "BirthDate", "CitizenshipId", "CityId", "Email", "FirstName", "LastName", "Mobile", "Username" },
                values: new object[,]
                {
                    { 1, "", new DateTime(2001, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 5, "karić@gmail.com", "Damir", "Kahvic", "062342376", "dario" },
                    { 2, "", new DateTime(2001, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 5, "babić@gmail.com", "Selmir", "Babić", "062342376", "selmir" },
                    { 3, "", new DateTime(2001, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 5, "tufo@gmail.com", "Omer", "Tufo", "062342376", "omer" },
                    { 4, "", new DateTime(2001, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 5, "karić@gmail.com", "Emir", "Oleg", "062342376", "employee" },
                    { 5, "", new DateTime(2001, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 5, "karić@gmail.com", "Faris", "Mahic", "062342376", "employee" },
                    { 6, "", new DateTime(2001, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 5, "karić@gmail.com", "Aleksandar", "Muftic", "062342376", "" }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "BirthDate", "CitizenshipId", "CityId", "CreateDate", "Email", "FirstName", "Gender", "Image", "LastName", "Mobile", "OfficePhone", "Password", "Username" },
                values: new object[,]
                {
                    { 1, new DateTime(2001, 4, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 1, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6641), "sendić@gmail.com", "Amir", 0, null, "Sendić", "062342376", "38734549", "Admin", "Admin" },
                    { 2, new DateTime(2000, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 2, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6693), "stufo@gmail.com", "Samra", 1, null, "Tufo", "062342376", "38734549", "Admin", "employee" },
                    { 3, new DateTime(1990, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 3, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6702), "tufo@gmail.com", "Omer", 0, null, "Tufo", "062342376", "38734549", "Admin", "omer" },
                    { 4, new DateTime(1975, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, 4, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6706), "kremić@gmail.com", "Merima", 1, null, "Kremić", "062342376", "38734549", "Admin", "merima" },
                    { 5, new DateTime(2001, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 5, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6709), "karić@gmail.com", "Damir", 0, null, "Kahvic", "062342376", "38734549", "Admin", "dario" },
                    { 6, new DateTime(1994, 6, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, 6, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6712), "babić@gmail.com", "Selmir", 1, null, "Babić", "062342376", "38734549", "Admin", "selmir" }
                });

            migrationBuilder.InsertData(
                table: "UserRatings",
                columns: new[] { "Id", "PartId", "ProductRating", "UserId" },
                values: new object[,]
                {
                    { 1, 1, 4.0, 1 },
                    { 2, 6, 2.0, 1 },
                    { 3, 2, 5.0, 1 },
                    { 4, 3, 1.0, 1 },
                    { 5, 5, 5.0, 1 },
                    { 6, 4, 2.0, 1 },
                    { 7, 1, 4.0, 1 },
                    { 8, 1, 4.0, 1 },
                    { 9, 1, 4.0, 1 },
                    { 10, 1, 4.0, 1 },
                    { 11, 1, 4.0, 1 }
                });

            migrationBuilder.InsertData(
                table: "UserRoles",
                columns: new[] { "Id", "Role", "UserId" },
                values: new object[,]
                {
                    { 1, 0, 1 },
                    { 2, 1, 1 },
                    { 3, 2, 1 },
                    { 4, 1, 2 },
                    { 5, 2, 3 },
                    { 6, 2, 4 }
                });

            migrationBuilder.InsertData(
                table: "Vehicles",
                columns: new[] { "Id", "Brand", "Chassis", "CubicCapacity", "Fuel", "Kilowatts", "Model", "ProductionDate", "Transmision", "UserId" },
                values: new object[,]
                {
                    { 1, "Volkswagen", "WVWZZZ6NZ1Y125494", 1392, "Gasoline", 55, "Polo", new DateTime(2000, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Manual", 1 },
                    { 2, "Volkswagen", "WVWZZZ6NZ1Y125494", 1392, "Gasoline", 55, "Polo", new DateTime(2000, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Manual", 1 },
                    { 3, "Volkswagen", "WVWZZZ6NZ1Y125494", 1392, "Gasoline", 55, "Polo", new DateTime(2000, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Manual", 1 },
                    { 4, "Volkswagen", "WVWZZZ6NZ1Y125494", 1392, "Gasoline", 55, "Polo", new DateTime(2000, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Manual", 1 },
                    { 5, "Volkswagen", "WVWZZZ6NZ1Y125494", 1392, "Gasoline", 55, "Polo", new DateTime(2000, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Manual", 1 },
                    { 6, "Volkswagen", "WVWZZZ6NZ1Y125494", 1392, "Gasoline", 55, "Polo", new DateTime(2000, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Manual", 1 }
                });

            migrationBuilder.InsertData(
                table: "Appointments",
                columns: new[] { "Id", "AppointmentTypeId", "Description", "EmployeeId", "EndDate", "StartDate", "UserId", "VehicleId" },
                values: new object[,]
                {
                    { 1, 1, "Pregled auta, mali servis i cudna buka na velikim brzinama", null, new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 2, 2, "Pregled auta, mali servis i cudna buka na velikim brzinama", null, new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 2 },
                    { 3, 3, "Pregled auta, mali servis i cudna buka na velikim brzinama", null, new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 3 },
                    { 4, 1, "Pregled auta, mali servis i cudna buka na velikim brzinama", null, new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, 4 },
                    { 5, 2, "Pregled auta, mali servis i cudna buka na velikim brzinama", null, new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 5 },
                    { 6, 3, "Pregled auta, mali servis i cudna buka na velikim brzinama", null, new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, 1 }
                });

            migrationBuilder.InsertData(
                table: "VehicleServiceHistory",
                columns: new[] { "Id", "Description", "EmployeeId", "ServiceDate", "ServiceType", "Sugestions", "UserId", "VehicleId" },
                values: new object[,]
                {
                    { 1, "", 1, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6829), 1, "", 1, 1 },
                    { 2, "", 2, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6835), 0, "", 2, 2 },
                    { 3, "", 3, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6838), 4, "", 3, 3 },
                    { 4, "", 4, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6840), 5, "", 4, 4 },
                    { 5, "", 5, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6843), 1, "", 5, 5 },
                    { 6, "", 6, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6845), 0, "", 6, 6 }
                });

            migrationBuilder.InsertData(
                table: "WorkOrders",
                columns: new[] { "Id", "AppointmentId", "Concerne", "Description", "EmployeeId", "EndTime", "GarageBox", "OrderNumber", "ServicePerformed", "StartTime", "Sugestions", "UserId", "VehicleId" },
                values: new object[,]
                {
                    { 1, 1, "Paljenje auta", "Potrebno duze vrijeme da upali kada je auto zagrijano", 1, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6876), 0, "SGTA252ASF276", 1, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6874), "Provjeriti dizne i alnaser", 1, 1 },
                    { 2, 2, "Paljenje auta", "Potrebno duze vrijeme da upali kada je auto zagrijano", 2, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6882), 0, "SGTA252ASF276", 0, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6881), "Provjeriti dizne i alnaser", 2, 2 },
                    { 3, 3, "Paljenje auta", "Potrebno duze vrijeme da upali kada je auto zagrijano", 3, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6887), 0, "SGTA252ASF276", 4, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6885), "Provjeriti dizne i alnaser", 3, 3 },
                    { 4, 4, "Paljenje auta", "Potrebno duze vrijeme da upali kada je auto zagrijano", 4, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6891), 0, "SGTA252ASF276", 3, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6889), "Provjeriti dizne i alnaser", 4, 4 },
                    { 5, 5, "Paljenje auta", "Potrebno duze vrijeme da upali kada je auto zagrijano", 5, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6895), 0, "SGTA252ASF276", 5, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6894), "Provjeriti dizne i alnaser", 5, 5 },
                    { 6, 6, "Paljenje auta", "Potrebno duze vrijeme da upali kada je auto zagrijano", 6, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6899), 0, "SGTA252ASF276", 1, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6897), "Provjeriti dizne i alnaser", 6, 6 }
                });

            migrationBuilder.InsertData(
                table: "PartWorkOrder",
                columns: new[] { "Id", "PartId", "ServiceDate", "VehicleId", "WorkOrderId" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6960), 1, 1 },
                    { 2, 2, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6965), 2, 2 },
                    { 3, 3, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6967), 3, 3 },
                    { 4, 4, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6969), 4, 4 },
                    { 5, 5, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6971), 5, 5 },
                    { 6, 6, new DateTime(2025, 3, 18, 19, 52, 35, 808, DateTimeKind.Local).AddTicks(6973), 6, 6 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_AppointmentAppointmentBlocked_AppointmentsId",
                table: "AppointmentAppointmentBlocked",
                column: "AppointmentsId");

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_AppointmentTypeId",
                table: "Appointments",
                column: "AppointmentTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_EmployeeId",
                table: "Appointments",
                column: "EmployeeId");

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_UserId",
                table: "Appointments",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Appointments_VehicleId",
                table: "Appointments",
                column: "VehicleId");

            migrationBuilder.CreateIndex(
                name: "IX_Cities_CountryId",
                table: "Cities",
                column: "CountryId");

            migrationBuilder.CreateIndex(
                name: "IX_Employees_CitizenshipId",
                table: "Employees",
                column: "CitizenshipId");

            migrationBuilder.CreateIndex(
                name: "IX_Employees_CityId",
                table: "Employees",
                column: "CityId");

            migrationBuilder.CreateIndex(
                name: "IX_PartWorkOrder_PartId",
                table: "PartWorkOrder",
                column: "PartId");

            migrationBuilder.CreateIndex(
                name: "IX_PartWorkOrder_VehicleId",
                table: "PartWorkOrder",
                column: "VehicleId");

            migrationBuilder.CreateIndex(
                name: "IX_PartWorkOrder_WorkOrderId",
                table: "PartWorkOrder",
                column: "WorkOrderId");

            migrationBuilder.CreateIndex(
                name: "IX_UserRatings_PartId",
                table: "UserRatings",
                column: "PartId");

            migrationBuilder.CreateIndex(
                name: "IX_UserRatings_UserId",
                table: "UserRatings",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_UserRoles_UserId",
                table: "UserRoles",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_CitizenshipId",
                table: "Users",
                column: "CitizenshipId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_CityId",
                table: "Users",
                column: "CityId");

            migrationBuilder.CreateIndex(
                name: "IX_Vehicles_UserId",
                table: "Vehicles",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_VehicleServiceHistory_EmployeeId",
                table: "VehicleServiceHistory",
                column: "EmployeeId");

            migrationBuilder.CreateIndex(
                name: "IX_VehicleServiceHistory_UserId",
                table: "VehicleServiceHistory",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_VehicleServiceHistory_VehicleId",
                table: "VehicleServiceHistory",
                column: "VehicleId");

            migrationBuilder.CreateIndex(
                name: "IX_WorkOrders_AppointmentId",
                table: "WorkOrders",
                column: "AppointmentId");

            migrationBuilder.CreateIndex(
                name: "IX_WorkOrders_EmployeeId",
                table: "WorkOrders",
                column: "EmployeeId");

            migrationBuilder.CreateIndex(
                name: "IX_WorkOrders_UserId",
                table: "WorkOrders",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_WorkOrders_VehicleId",
                table: "WorkOrders",
                column: "VehicleId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AppointmentAppointmentBlocked");

            migrationBuilder.DropTable(
                name: "PartWorkOrder");

            migrationBuilder.DropTable(
                name: "UserRatings");

            migrationBuilder.DropTable(
                name: "UserRoles");

            migrationBuilder.DropTable(
                name: "VehicleServiceHistory");

            migrationBuilder.DropTable(
                name: "AppointmentBlocked");

            migrationBuilder.DropTable(
                name: "WorkOrders");

            migrationBuilder.DropTable(
                name: "Parts");

            migrationBuilder.DropTable(
                name: "Appointments");

            migrationBuilder.DropTable(
                name: "AppointmentTypes");

            migrationBuilder.DropTable(
                name: "Employees");

            migrationBuilder.DropTable(
                name: "Vehicles");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Cities");

            migrationBuilder.DropTable(
                name: "Countries");
        }
    }
}
