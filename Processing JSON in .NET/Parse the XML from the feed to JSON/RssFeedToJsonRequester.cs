namespace ProcessingJson.XmlToJson
{
    using System;
    using System.Net;
    using System.Text;
    using System.Text.RegularExpressions;
    using System.Xml;
    using Newtonsoft.Json;

    /// <summary>
    /// Using JSON.NET and the Telerik Academy Youtube RSS feed, implement the following:
    ///     Download the content of the feed programatically
    ///     You can use WebClient.DownloadFile()
    ///     Parse the XML from the feed to JSON
    /// 
    /// The RSS feed is located at
    /// https://www.youtube.com/feeds/videos.xml?channel_id=UCLC-vbm7OWvpbqzXaoAMGGw
    /// </summary>
    public class RssFeedToJsonRequester
    {
        private const string invalidUrlMessage = "Invalid URL, try again";

        private static Regex urlValidator = new Regex(@"((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[.\!\/\\w]*))?)");

        public RssFeedToJsonRequester(bool indented = false)
        {
            if (indented)
            {
                this.Formatting = Newtonsoft.Json.Formatting.Indented;
            }
        }

        public Newtonsoft.Json.Formatting Formatting { get; set; }

        public string Request(string url)
        {
            string xml;
            while ((xml = GetFeed(url)).StartsWith(invalidUrlMessage))
            {
                Console.Write(invalidUrlMessage);
                url = Console.ReadLine();
            }
            
            var doc = new XmlDocument();
            doc.LoadXml(xml);

            string jsonFromXml = 
                JsonConvert.SerializeXmlNode(doc.DocumentElement, this.Formatting);

            return jsonFromXml;
        }

        private string GetFeed(string url)
        {
            if (urlValidator.IsMatch(url))
            {
                using (var webClient = new WebClient())
                {
                    try
                    {
                        webClient.Encoding = Encoding.UTF8;
                        webClient.Headers.Add(HttpRequestHeader.UserAgent, "Mozilla/5.0");
                        webClient.Headers.Add(HttpRequestHeader.AcceptCharset, "utf-8");
                        string xml = webClient.DownloadString(url);

                        return xml;     
                    }
                    catch (WebException ex)
                    {
                        if (ex.Status == WebExceptionStatus.NameResolutionFailure)
                        {
                            return invalidUrlMessage;
                        }
                        else
                        {
                            throw ex;
                        }
                    }
                }
            }
            else
            {
                return invalidUrlMessage;
            }
        }
    }
}
