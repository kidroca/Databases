namespace Databases.XmlProcessing.ExtractArtists
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Xml;
    using HomeworkHelpers;

    /// <summary>
    /// Write program that extracts all different artists which are found in the catalog.xml.
    ///     For each author you should print the number of albums in the catalogue.
    ///     Use the DOM parser and a hash-table.
    /// 
    ///     Implement the previous using XPath.
    /// </summary>
    public class ArtistXpathExtractr
    {
        private const string pathToXml = "../../../catalogue.xml";

        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Extract Artists With XPath");

            var doc = new XmlDocument();
            doc.Load(pathToXml);
            XmlElement root = doc.DocumentElement;
            var nsManager = new XmlNamespaceManager(doc.NameTable);

            Console.WriteLine("Extracting Information...");
            SortedDictionary<string, int> result = ExtractArtistsInformation(root, nsManager);
            helper.ConsoleMio.PrintColorText("Success!\n\n", ConsoleColor.DarkGreen);

            foreach (var entry in result)
            {
                Console.WriteLine(
                    "Artist: {0} - {1} {2}"
                    , entry.Key
                    , entry.Value
                    , entry.Value == 1 ? "album" : "albums");
            }

            helper.ConsoleMio.Restart(Main);
        }

        public static SortedDictionary<string, int> ExtractArtistsInformation(
            XmlElement rootElement, XmlNamespaceManager nsManager)
        {
            var result = new SortedDictionary<string, int>();

            nsManager.AddNamespace("cat", rootElement.NamespaceURI);

            XmlNodeList albums = rootElement.SelectNodes("cat:album", nsManager);

            foreach (XmlNode a in albums)
            {
                string artistName = a.SelectSingleNode("cat:artist", nsManager).InnerText;
                if (result.ContainsKey(artistName))
                {
                    result[artistName] += 1;
                }
                else
                {
                    result[artistName] = 1;
                }
            }

            return result;
        }
    }
}
