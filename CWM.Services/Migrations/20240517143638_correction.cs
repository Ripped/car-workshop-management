using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CWM.Database.Migrations
{
    /// <inheritdoc />
    public partial class correction : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_WorkOrders_VehicleServiceHistory_VehicleServieHistoryId",
                table: "WorkOrders");

            migrationBuilder.RenameColumn(
                name: "VehicleServieHistoryId",
                table: "WorkOrders",
                newName: "VehicleServiceHistoryId");

            migrationBuilder.RenameIndex(
                name: "IX_WorkOrders_VehicleServieHistoryId",
                table: "WorkOrders",
                newName: "IX_WorkOrders_VehicleServiceHistoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_WorkOrders_VehicleServiceHistory_VehicleServiceHistoryId",
                table: "WorkOrders",
                column: "VehicleServiceHistoryId",
                principalTable: "VehicleServiceHistory",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_WorkOrders_VehicleServiceHistory_VehicleServiceHistoryId",
                table: "WorkOrders");

            migrationBuilder.RenameColumn(
                name: "VehicleServiceHistoryId",
                table: "WorkOrders",
                newName: "VehicleServieHistoryId");

            migrationBuilder.RenameIndex(
                name: "IX_WorkOrders_VehicleServiceHistoryId",
                table: "WorkOrders",
                newName: "IX_WorkOrders_VehicleServieHistoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_WorkOrders_VehicleServiceHistory_VehicleServieHistoryId",
                table: "WorkOrders",
                column: "VehicleServieHistoryId",
                principalTable: "VehicleServiceHistory",
                principalColumn: "Id");
        }
    }
}
