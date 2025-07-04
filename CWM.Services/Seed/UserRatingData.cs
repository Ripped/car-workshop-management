using CWM.Database.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Seed
{
    public static class UserRatingData { 
        public static void SeedData(this EntityTypeBuilder<UserRating> entity)
    {
        entity.HasData(
            new UserRating
            {
                Id = 1,
                ProductRating = 4,
                UserId = 1,
                PartId = 1,
            },
            new UserRating
            {
                Id = 2,
                ProductRating = 2,
                UserId = 1,
                PartId = 6,
            },
            new UserRating
            {
                Id = 3,
                ProductRating = 5,
                UserId = 1,
                PartId = 2,
            },
            new UserRating
            {
                Id = 4,
                ProductRating = 1,
                UserId = 1,
                PartId = 3,
            },
            new UserRating
            {
                Id = 5,
                ProductRating = 5,
                UserId = 1,
                PartId = 5,
            },
            new UserRating
            {
                Id = 6,
                ProductRating = 2,
                UserId = 1,
                PartId = 4,
            },
            new UserRating
            {
                Id = 7,
                ProductRating = 4,
                UserId = 3,
                PartId = 10,
            },
            new UserRating
            {
                Id = 8,
                ProductRating = 3,
                UserId = 3,
                PartId = 2,
            },
            new UserRating
            {
                Id = 9,
                ProductRating = 1,
                UserId = 3,
                PartId = 9,
            },
            new UserRating
            {
                Id = 10,
                ProductRating = 4,
                UserId = 3,
                PartId = 11,
            },
            new UserRating
            {
                Id = 11,
                ProductRating = 5,
                UserId = 3,
                PartId = 12,
            }
        );
    }
    }
}
