namespace ProcessingJson.JsonToPoco.Objects
{
    using System;
    using Media;
    using Newtonsoft.Json;
    
    public class MediaGroup
    {
        [JsonProperty("media:title")]
        public string Title { get; set; }

        [JsonProperty("media:content")]
        public MediaContent Content { get; set; }

        [JsonProperty("media:thumbnail")]
        public MediaThumbnail Thumbnail { get; set; }

        [JsonProperty("media:description")]
        public string Description { get; set; }

        [JsonProperty("media:community")]
        public MediaCommunity Community { get; set; }
    }
}