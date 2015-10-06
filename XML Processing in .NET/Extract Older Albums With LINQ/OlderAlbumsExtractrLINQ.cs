namespace Databases.XmlProcessing.OlderAlbums
{
    using System;
    using System.Xml;
    using HomeworkHelpers;
    using System.Xml.Linq;
    using System.Linq;

    /// <summary>
    /// Write a program, which extract from the file catalog.xml the prices for all
    /// albums, published 5 years ago or earlier. 
    ///     Use XPath query.
    /// 
    /// Rewrite the previous using LINQ query.
    /// </summary>
    public class NewAlbumsExtractr
    {
        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        [STAThread]
        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Extract New Albums With XPath ");

            string selctedFile = helper.SelectFileToOpen("catalogue.xml|catalogue.xml");

            var doc = XDocument.Load(selctedFile);
            XNamespace ns = doc.Root.GetDefaultNamespace();

            int fiveYearsAgo = DateTime.Now.Year - 5;

            var prices =
                from album in doc.Root.Elements(ns + "album")
                where int.Parse(album.Element(ns + "year").Value) <= fiveYearsAgo
                select new
                {
                    name = album.Element(ns + "name").Value,
                    price = album.Element(ns + "price").Value
                };

            helper.ConsoleMio.PrintColorText(
                "Prices of albums older than 5 years:\n", ConsoleColor.Green);
            foreach (var p in prices)
            {
                Console.WriteLine("\t price: {0}, name: {1}", p.price, p.name);
            }

            helper.ConsoleMio.Restart(Main);
        }
    }
}
