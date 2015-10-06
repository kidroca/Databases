namespace Databases.XmlProcessing.TraversR
{
    using System;
    using System.IO;
    using System.Text;
    using System.Xml;
    using HomeworkHelpers;
    using HomeworkHelpers.Xml;

    /// <summary>
    /// Write a program to traverse given directory and write to a XML file its contents together
    /// with all subdirectories and files.
    /// 
    ///     Use tags<file> and<dir> with appropriate attributes.
    ///     For the generation of the XML document use the class XmlWriter.
    /// </summary>
    public class FolderTraversr
    {
        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        [STAThread]
        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Traverse Folders");

            helper.ConsoleMio.PrintColorText("Select a directory to traverse\n", ConsoleColor.Red);

            string directoryPath = helper.GetDirectory();

            string savePath = helper.SelectSaveLocation("XML file|*.xml");

            using(var writeStream = new XmlTextWriter(savePath, Encoding.UTF8))
            {
                var dirInfo = new DirectoryInfo(directoryPath);

                writeStream.Formatting = Formatting.Indented;
                writeStream.WriteStartDocument();
                writeStream.WriteStartElement("Directories");

                var traversR = new TraverseUsingXmlWriter(writeStream);

                traversR.TraverseFolder(dirInfo);

                writeStream.WriteEndDocument();
            }

            helper.ConsoleMio.PrintColorText("Completed\n ", ConsoleColor.Green);

            helper.ConsoleMio.Restart(Main);
        }
    }
}
