namespace Databases.XmlProcessing.ParseTextDoc
    using System;
    using System.Linq;
    using System.Windows.Forms;
    using System.Xml.Linq;
    using HomeworkHelpers;
    using System.IO;

    /// <summary>
    /// In a text file we are given the name, address and phone number of given person
    /// (each at a single line).
    ///     Write a program, which creates new XML document, which contains these data
    ///     in structured XML format.
    /// </summary>
    public class ParseTextXml
    {
        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        [STAThread]
        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Extract Contact Information");

            string selctedFile = SelectFileToOpen();

            string saveLocation = SelectSaveLocation();

            var contactInfo = new XElement("person");
            
            using (var inputStream = new StreamReader(selctedFile))
            {
                string currentLine;
                while ((currentLine = inputStream.ReadLine()) != null)
                {
                    string[] args = currentLine.Split(' ');
                    string tag = args[0];
                    string content = string.Join(" ", args.Skip(1).ToArray());

                    contactInfo.Add(new XElement(tag, content));
                }
            }

            contactInfo.Save(saveLocation);

            helper.ConsoleMio.PrintColorText("Completed\n ", ConsoleColor.Green);
            
            helper.ConsoleMio.Restart(Main);
        }

        private static string SelectSaveLocation()
        {
            Console.WriteLine("Press a key to select a save location from a menu.");
            Console.ReadKey(true);

            var saveFileDialog = new SaveFileDialog();
            saveFileDialog.Title = "Select a place to save";
            saveFileDialog.Filter = "XML files (*.xml)|*.xml";

            PromptDialog(saveFileDialog);

            return saveFileDialog.FileName;
        }

        private static string SelectFileToOpen()
        {
            Console.WriteLine("Press a key to select a file with contact information from a menu.");
            Console.ReadKey(true);

            var openFileDialog = new OpenFileDialog();
            openFileDialog.Title = "Select a text file";
            openFileDialog.Filter = "Text files (*.txt)|*.txt";

            PromptDialog(openFileDialog);

            return openFileDialog.FileName;
        }

        private static void PromptDialog(FileDialog dialog)
        {
            dialog.InitialDirectory = Directory
                .GetParent("../../").FullName; // Environment.GetFolderPath(Environment.SpecialFolder.Desktop);

            while (dialog.ShowDialog() != DialogResult.OK)
            {
                Console.WriteLine("You have to select a file, try again.");
            }
        }
    }
}
