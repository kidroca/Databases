namespace ProcessingJson.JsonToPoco.Objects
{
    using System;
    using Newtonsoft.Json;

    public class Entry
    {
        public string Id { get; set; }

        public string Title { get; set; }

        public Link Link { get; set; }

        public Author Author { get; set; }

        public DateTime Published { get; set; }

        public DateTime Updated { get; set; }

        [JsonProperty("media:group")]
        public MediaGroup MediaGroup { get; set; }
    }
}