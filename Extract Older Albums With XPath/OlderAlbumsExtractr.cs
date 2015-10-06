namespace Databases.XmlProcessing.OlderAlbums
{
    using System;
    using System.Xml;
    using HomeworkHelpers;

    /// <summary>
    /// Write a program, which extract from the file catalog.xml the prices for all
    /// albums, published 5 years ago or earlier. 
    ///     Use XPath query.
    /// </summary>
    public class OlderAlbumsExtractr
    {
        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        [STAThread]
        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Extract New Albums With XPath ");

            string selctedFile = helper.SelectFileToOpen("catalogue.xml|catalogue.xml");

            var doc = new XmlDocument();
            doc.Load(selctedFile);
            var root = doc.DocumentElement;
            var nsManager = new XmlNamespaceManager(doc.NameTable);

            nsManager.AddNamespace("cat", root.NamespaceURI);

            int fiveYearsAgo = DateTime.Now.Year - 5;

            var prices = root.SelectNodes(
                @"cat:album[cat:year <=" + fiveYearsAgo + "]/cat:price", nsManager);

            helper.ConsoleMio.PrintColorText("Prices of albums older than 5 years:\n", ConsoleColor.Green);

            foreach (XmlNode p in prices)
            {
                Console.WriteLine("\t{0}", p.InnerText );
            }

            helper.ConsoleMio.Restart(Main);
        }
    }
}
