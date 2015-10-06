namespace ProcessingJson.JsonToPoco.Objects.Media
{
    using Newtonsoft.Json;

    public class MediaCommunity
    {
        [JsonProperty("media:starRating")]
        public MediaStarRating Rating { get; set; }

        [JsonProperty("media:statistics")]
        public MediaStatistics Statistics { get; set; }
    }
}