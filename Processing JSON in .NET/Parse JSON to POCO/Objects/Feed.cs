namespace ProcessingJson.JsonToPoco.Objects
{
    using System;
    using Newtonsoft.Json;
    
    public class Feed
    {
        public string Id { get; set; }

        public string Title { get; set; }

        public Author Author { get; set; }

        public DateTime Published { get; set; }

        public Link[] Link { get; set; }

        [JsonProperty("entry")]
        public Entry[] Entries { get; set; }
    }
}
