namespace Databases.XmlProcessing.Albums
{
    using System;
    using System.Xml;
    using HomeworkHelpers;

    /// <summary>
    /// Write a program, which (using XmlReader and XmlWriter) reads the file catalog.xml and
    /// creates the file album.xml, in which stores in appropriate way the names of all albums
    /// and their authors.
    /// </summary>
    public class FilterAlbums
    {
        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        [STAThread]
        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Extract Contact Information");

            string selctedFile = helper.SelectFileToOpen("catalogue.xml|catalogue.xml");

            string saveLocation = helper.SelectSaveLocation("XML document|*.xml");

            using (var readStream = XmlReader.Create(selctedFile))
            {
                using (var writeStream = XmlWriter.Create(saveLocation))
                {
                    writeStream.WriteStartDocument();
                    writeStream.WriteStartElement("albums");

                    while (readStream.ReadToFollowing("album"))
                    {
                        writeStream.WriteStartElement("album");

                        readStream.ReadToFollowing("name");
                        string album = readStream.ReadElementContentAsString();

                        writeStream.WriteElementString("name", album);

                        readStream.ReadToFollowing("artist");
                        string artist = readStream.ReadElementContentAsString();

                        writeStream.WriteElementString("artist", artist);

                        writeStream.WriteEndElement();
                    }

                    writeStream.WriteEndDocument();
                }
            }

            helper.ConsoleMio.PrintColorText("Completed\n ", ConsoleColor.Green);

            helper.ConsoleMio.Restart(Main);
        }
    }
}
