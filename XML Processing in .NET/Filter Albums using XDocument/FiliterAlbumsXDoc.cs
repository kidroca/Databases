namespace Databases.XmlProcessing.Albums
{
    using System;
    using System.Linq;
    using System.Xml.Linq;
    using HomeworkHelpers;

    /// <summary>
    /// Write a program, which (using XmlReader and XmlWriter) reads the file catalog.xml and
    /// creates the file album.xml, in which stores in appropriate way the names of all albums
    /// and their authors.
    /// 
    /// Rewrite the last exercises using XDocument, XElement and XAttribute.
    /// </summary>
    public class FiliterAlbumsXDoc
    {
        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        [STAThread]
        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Filter Albums using XDocument");

            string selctedFile = helper.SelectFileToOpen("catalogue.xml|catalogue.xml");

            var originalDoc = XDocument.Load(selctedFile);
            XNamespace ns = originalDoc.Root.GetDefaultNamespace();

            var albums = new XDocument(new XElement("albums", 
                from album in originalDoc.Descendants(ns + "album")
                select new XElement(
                    "album"
                    , album.Element(ns + "name")
                    , album.Element(ns + "artist")
                )
            ));

            string saveLocation = helper.SelectSaveLocation("XML document|*.xml");

            albums.Save(saveLocation);

            helper.ConsoleMio.PrintColorText("Completed\n ", ConsoleColor.Green);

            helper.ConsoleMio.Restart(Main);
        }
    }
}
