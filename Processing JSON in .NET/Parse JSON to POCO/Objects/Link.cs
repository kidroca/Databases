namespace ProcessingJson.JsonToPoco.Objects
{
    using Newtonsoft.Json;

    public class Link
    {
        [JsonProperty("@rel")]
        public string Relationship { get; set; }

        [JsonProperty("@href")]
        public string Href { get; set; }
    }
}