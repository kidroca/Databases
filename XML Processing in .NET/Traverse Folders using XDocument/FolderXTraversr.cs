namespace Databases.XmlProcessing.TraversR
{
    using System;
    using System.IO;
    using System.Text;
    using System.Xml;
    using System.Xml.Linq;
    using HomeworkHelpers;
    using HomeworkHelpers.Xml;

    /// <summary>
    /// Write a program to traverse given directory and write to a XML file its contents together
    /// with all subdirectories and files.
    /// 
    ///     Use tags<file> and<dir> with appropriate attributes.
    ///     For the generation of the XML document use the class XmlWriter.
    /// 
    /// Rewrite the last exercises using XDocument, XElement and XAttribute.
    /// </summary>
    public class FolderXTraversr
    {
        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        [STAThread]
        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Traverse Folders XDocument");

            helper.ConsoleMio.PrintColorText("Select a directory to traverse\n", ConsoleColor.Red);

            string directoryPath = helper.GetDirectory();
            var dirInfo = new DirectoryInfo(directoryPath);

            var root = new XElement("Directories");
            var traversR = new TraverseUsingXDocument(root);

            traversR.TraverseFolder(dirInfo);

            string savePath = helper.SelectSaveLocation("XML file|*.xml");
            
            root.Save(savePath);

            helper.ConsoleMio.PrintColorText("Completed\n ", ConsoleColor.Green);

            helper.ConsoleMio.Restart(Main);
        }
    }
}
