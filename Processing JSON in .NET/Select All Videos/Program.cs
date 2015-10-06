namespace ProcessingJson.Videos
{
    using System;
    using System.Linq;
    using HomeworkHelpers;
    using Newtonsoft.Json.Linq;
    using XmlToJson;

    /// <summary>
    /// Using LINQ-to-JSON select all video titles and print them on the console
    /// 
    /// The RSS feed is located at
    /// https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw
    /// </summary>
    class Program
    {
        static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Select All Video Titles ");

            var rssJson = new RssFeedToJsonRequester(indented: false);

            string urlFeed =
                @"https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw";

            string json = rssJson.Request(urlFeed);

            var feedJson = JObject.Parse(json);

            helper.ConsoleMio.Write(
                feedJson["feed"]["title"]
                    .ToString().PadLeft(Console.WindowWidth / 2)
                , ConsoleColor.DarkGreen);
            Console.WriteLine();

            var videoTitles = feedJson["feed"]["entry"]
                .OrderBy(entry => entry["title"].ToString(), StringComparer.CurrentCulture)
                .Select(entry => entry["title"].ToString());

            foreach (var title in videoTitles)
            {
                helper.ConsoleMio.Write(title, ConsoleColor.DarkRed);
                Console.WriteLine();
            }

            helper.ConsoleMio.Restart(Main);
        }
    }
}
