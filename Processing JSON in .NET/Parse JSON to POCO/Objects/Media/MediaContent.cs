namespace ProcessingJson.JsonToPoco.Objects.Media
{
    using Newtonsoft.Json;

    public class MediaContent : MediaBase
    {
        [JsonProperty("@type")]
        public string Type { get; set; }        
    }
}