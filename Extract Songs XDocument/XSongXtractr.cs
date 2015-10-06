namespace Databases.XmlProcessing.ExtractSongs
{
    using System;
    using System.Linq;
    using System.Xml.Linq;
    using HomeworkHelpers;

    /// <summary>
    /// Write a program, which using XmlReader extracts all song titles from catalog.xml.
    /// Rewrite the same using XDocument and LINQ query.
    /// </summary>
    public class XSongXtractr
    {
        private const string pathToXml = "../../../catalogue.xml";

        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Extract Songs XDocument ");

            var doc = XDocument.Load(pathToXml);
            XNamespace ns = doc.Root.GetDefaultNamespace();
            
            var desc = doc.Descendants(ns + "song");

            var songTitles =
                from songs in doc.Descendants(ns + "song")
                select songs.Element(ns + "title").Value;  

            Console.WriteLine("Completed\n ");
            helper.ConsoleMio.PrintColorText("Songs:\n", ConsoleColor.DarkRed);
            Console.WriteLine(string.Join("\n", songTitles.OrderBy(x => x)));

            helper.ConsoleMio.Restart(Main);
        }
    }
}
