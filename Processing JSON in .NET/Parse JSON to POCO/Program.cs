namespace ProcessingJson.JsonToPoco
{
    using System;
    using System.IO;
    using System.Web.UI;
    using HomeworkHelpers;
    using Newtonsoft.Json;
    using XmlToJson;
    using Objects;

    /// <summary>
    /// Parse the videos' JSON to POCO
    /// 
    /// The RSS feed is located at
    /// https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw
    /// </summary>
    class Program
    {
        static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        [STAThread]
        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Select All Video Titles ");

            var rssJson = new RssFeedToJsonRequester(indented: false);

            string urlFeed =
                @"https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw";

            Console.WriteLine("Getting JSON Object");
            string json = rssJson.Request(urlFeed);
            helper.ConsoleMio.WriteLine("Done", ConsoleColor.DarkGreen);
            Console.WriteLine();

            Console.WriteLine("Creating POCO from JSON");
            Rss rssFeed = JsonConvert.DeserializeObject<Rss>(json);
            helper.ConsoleMio.WriteLine("Done", ConsoleColor.DarkGreen);
            Console.WriteLine();

            Console.WriteLine("Creating HTML");
            CreateHtmlFromFeed(rssFeed.Feed);
            helper.ConsoleMio.WriteLine("Done", ConsoleColor.DarkGreen);
            Console.WriteLine();

            helper.ConsoleMio.Restart(Main);
        }

        private static void CreateHtmlFromFeed(Feed feed)
        {
            string savePath = helper.SelectSaveLocation("Html document|*.html");

            var documentWriter = new StreamWriter(
                savePath, append: false, encoding: System.Text.Encoding.UTF8);

            using (documentWriter)
            {
                using (var htmlWriter = new HtmlTextWriter(documentWriter))
                {
                    // The document generated is partial html piece without head and body
                    // Imagine trying to add the <html> <head> <title> <body> and their closing
                    // tags with this load of crap... no thank you

                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.H2);
                    htmlWriter.Write("Videos from ");
                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Href, feed.Author.Uri);
                    htmlWriter.RenderBeginTag(HtmlTextWriterTag.A);
                    htmlWriter.Write(feed.Author.Name);
                    htmlWriter.RenderEndTag();
                    htmlWriter.RenderEndTag();
                    htmlWriter.WriteLine();

                    htmlWriter.AddAttribute(HtmlTextWriterAttribute.Id, "videos");
                    htmlWriter.RenderBeginTag("section");

                    foreach (var entry in feed.Entries)
                    {
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Class, "video");
                        htmlWriter.AddStyleAttribute(HtmlTextWriterStyle.Display, "inline-block");
                        htmlWriter.AddStyleAttribute(HtmlTextWriterStyle.PaddingLeft, "10px");
                        htmlWriter.RenderBeginTag("article");

                        htmlWriter.RenderBeginTag(HtmlTextWriterTag.H3);
                        htmlWriter.AddAttribute(HtmlTextWriterAttribute.Href, entry.Link.Href);
                        htmlWriter.RenderBeginTag(HtmlTextWriterTag.A);
                        htmlWriter.Write(entry.Title);
                        htmlWriter.RenderEndTag();
                        htmlWriter.RenderEndTag();
                        htmlWriter.WriteLine();

                        htmlWriter.AddAttribute(
                            HtmlTextWriterAttribute.Src, entry.MediaGroup.Content.Url);
                        htmlWriter.AddAttribute(
                            HtmlTextWriterAttribute.Width
                            , entry.MediaGroup.Thumbnail.Width.ToString());
                        htmlWriter.RenderBeginTag(HtmlTextWriterTag.Iframe);
                        htmlWriter.RenderBeginTag(HtmlTextWriterTag.P);
                        htmlWriter.Write("Your browser does not support iframes.");
                        htmlWriter.RenderEndTag();
                        htmlWriter.RenderEndTag();
                        htmlWriter.WriteLine();

                        htmlWriter.RenderEndTag();
                        htmlWriter.WriteLine();
                    }

                    htmlWriter.RenderEndTag();
                    htmlWriter.WriteLine();
                }
            }
        }
    }
}
