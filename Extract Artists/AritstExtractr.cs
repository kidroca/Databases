namespace Databases.XmlProcessing.ExtractArtists
{
    using System;
    using System.Collections;
    using System.Xml;
    using HomeworkHelpers;

    /// <summary>
    /// Write program that extracts all different artists which are found in the catalog.xml.
    ///     For each author you should print the number of albums in the catalogue.
    ///     Use the DOM parser and a hash-table.
    /// </summary>
    public class AritstExtractr
    {
        private const string pathToXml = "../../../catalogue.xml";

        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Extract Artists ");

            var doc = new XmlDocument();
            doc.Load(pathToXml);
            XmlElement root = doc.DocumentElement;

            Console.WriteLine("Extracting Information...");
            Hashtable result = ExtractInformationForEachChild(root, "album", "artist");
            helper.ConsoleMio.PrintColorText("Success!\n\n", ConsoleColor.DarkGreen);

            foreach (DictionaryEntry entry in result)
            {
                Console.WriteLine(
                    "Artist: {0} - {1} {2}"
                    , entry.Key
                    , entry.Value
                    , (int)entry.Value == 1 ? "album" : "albums");
            }

            helper.ConsoleMio.Restart(Main);
        }

        public static Hashtable ExtractInformationForEachChild(
            XmlElement rootElement, string childTag, string informationTag)
        {
            var result = new Hashtable();

            XmlNodeList children = rootElement.GetElementsByTagName(childTag);

            foreach (XmlNode c in children)
            {
                string information = c[informationTag].InnerText;

                if (result.ContainsKey(information))
                {
                    result[information] = (int)result[informationTag] + 1;
                }
                else
                {
                    result[information] = 1;
                }
            }

            return result;
        }
    }
}
