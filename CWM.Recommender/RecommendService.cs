using AutoMapper;
using CWM.Core.Interfaces.Services;
using CWM.Database;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.ML;
using Microsoft.ML.Data;
using System.Data;
using System.Linq;

namespace CWM.Recommender
{
    public class RecommendService : IRecommendService
    {
        private readonly CWMContext context;
        private readonly IMapper mapper;

        static MLContext? mlContext = null;
        static object isLocked = new object();
        IDataView? transformedData = null;
        private PredictionEngine<Item, ItemVector>? predictionEnigne = null;

        public RecommendService(CWMContext _context, IMapper _mapper)
        {
            context = _context;
            mapper = _mapper;
        }

        public void TrainModel(int id)
        {
            lock (isLocked)
            {
                mlContext = new MLContext();

                var data = context.UserRatings.Include(x => x.Part).Where(x => x.UserId == id).OrderByDescending(y => y.ProductRating);

                var items = new List<Item>();

                foreach (var part in data)
                {
                    items.Add(new Item()
                    {
                        Id = (int)part.PartId,
                        Price = (float)part.Part.Price,
                        Image = part.Part.Image,
                        SerialNumber = part.Part.SerialNumber,
                        Description = part.Part.Description,
                        PartName = part.Part.PartName,
                        Manufacturer = part.Part.Manufacturer,
                    });
                }

                var itemData = mlContext.Data.LoadFromEnumerable(items);

                var textPipeline = mlContext.Transforms.Text.FeaturizeText("Features", nameof(Item.Description));

                transformedData = textPipeline.Fit(itemData).Transform(itemData);
                
                var preprocesedData = textPipeline.Fit(itemData);

                predictionEnigne = mlContext.Model.CreatePredictionEngine<Item, ItemVector>(preprocesedData);
            }
        }

        public float ComputeSimilarity(float[] userVector, float[] exerciseVector)
        {
            if (userVector.Length != exerciseVector.Length || userVector.Length == 0)
                return 0;

            float dotProduct = 0;
            for (int i = 0; i < userVector.Length; i++)
            {
                dotProduct += userVector[i] * exerciseVector[i];
            }

            float userMagnitude = (float)Math.Sqrt(userVector.Sum(x => x * x));
            float exerciseMagnitude = (float)Math.Sqrt(exerciseVector.Sum(x => x * x));

            if (userMagnitude == 0 || exerciseMagnitude == 0)
                return 0;

            return dotProduct / (userMagnitude * exerciseMagnitude);
        }

        public List<Core.Models.Part> RecommendProizvodi(int id)
        {
            var result = new List<Core.Models.Part>();
            var isNull = false;

            var user = context.UserRatings.Where(x => x.UserId == id);
            foreach (var item in user) { isNull = true; }
            if (isNull)
            {
                TrainModel(id);

                var items = new List<Item>();

                var parts = new List<Core.Models.Part>();

                var userRatings = context.Parts.ToList();

                foreach (var userRating in userRatings)
                {
                    items.Add(new Item()
                    {
                        Id = userRating.Id,
                        Price = (float)userRating.Price,
                        Image = userRating.Image,
                        SerialNumber = userRating.SerialNumber,
                        Description = userRating.Description,
                        PartName = userRating.PartName,
                        Manufacturer = userRating.Manufacturer,
                    });
                }

                var itemVector = transformedData.GetColumn<float[]>("Features").ToArray()[0];

                var recommendations = items
                .Select(i => new
                {
                    Item = i,
                    Similarity = ComputeSimilarity(itemVector, predictionEnigne.Predict(i).Features)
                })
                .OrderByDescending(x => x.Similarity)
                .Take(5);

                foreach (var userRating in recommendations)
                {
                    parts.Add(new Core.Models.Part()
                    {
                        Id = userRating.Item.Id,
                        Price = (decimal)userRating.Item.Price,
                        SerialNumber = userRating.Item.SerialNumber,
                        Description = userRating.Item.Description,
                        PartName = userRating.Item.PartName,
                        Manufacturer = userRating.Item.Manufacturer,
                    });
                }
                result = mapper.Map<List<Core.Models.Part>>(parts);
                return result;
            }
            else return result;
        }

        public class Item
        {
            public int Id { get; set; }
            public string SerialNumber { get; set; } = string.Empty;
            public string Manufacturer { get; set; } = string.Empty;
            public string PartName { get; set; } = string.Empty;
            public byte[]? Image { get; set; }
            public float Price { get; set; }
            public string Description { get; set; } = string.Empty;
        }

        public class ItemVector
        {
            [VectorType] // Indicates this is a numerical vector
            public float[] Features { get; set; }
        }
    }
}
