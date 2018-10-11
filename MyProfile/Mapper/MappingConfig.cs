using AutoMapper;
using MyProfile.Settings;

namespace MyProfile.Mapper
{
    public class MappingConfig
    {
        public static IMapper Mapper { get; set; }

        public static void RegisterMapping()
        {
            var mapperConfig = new MapperConfiguration(config =>
            {
                config.CreateMap<HashTag, HashTag>();
            });
            Mapper = mapperConfig.CreateMapper();
        }
    }
}