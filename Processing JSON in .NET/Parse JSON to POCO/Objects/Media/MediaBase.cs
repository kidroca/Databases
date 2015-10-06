namespace ProcessingJson.JsonToPoco.Objects.Media
{
    using Newtonsoft.Json;

    public abstract class MediaBase
    {
        [JsonProperty("@url")]
        public string Url { get; set; }

        [JsonProperty("@width")]
        public double Width { get; set; }

        [JsonProperty("@height")]
        public double Height { get; set; }
    }
}
