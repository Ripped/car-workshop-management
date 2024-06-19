using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CWM.Database.Migrations
{
    /// <inheritdoc />
    public partial class addremovedate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_VehicleServiceHistory_VehicleId",
                table: "VehicleServiceHistory");

            migrationBuilder.DropColumn(
                name: "OrderDate",
                table: "WorkOrders");

            migrationBuilder.DropColumn(
                name: "VehicleServiceHistoryId",
                table: "Vehicles");

            migrationBuilder.CreateIndex(
                name: "IX_VehicleServiceHistory_VehicleId",
                table: "VehicleServiceHistory",
                column: "VehicleId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_VehicleServiceHistory_VehicleId",
                table: "VehicleServiceHistory");

            migrationBuilder.AddColumn<DateTime>(
                name: "OrderDate",
                table: "WorkOrders",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<int>(
                name: "VehicleServiceHistoryId",
                table: "Vehicles",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_VehicleServiceHistory_VehicleId",
                table: "VehicleServiceHistory",
                column: "VehicleId",
                unique: true);
        }
    }
}
