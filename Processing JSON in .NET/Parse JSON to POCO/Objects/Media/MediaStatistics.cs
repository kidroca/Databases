namespace ProcessingJson.JsonToPoco.Objects.Media
{
    using Newtonsoft.Json;

    public class MediaStatistics
    {
        [JsonProperty("@views")]
        public long Views { get; set; }
    }
}