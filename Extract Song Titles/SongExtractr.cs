namespace Databases.XmlProcessing.ExtractSongs
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Xml;
    using HomeworkHelpers;

    /// <summary>
    /// Write a program, which using XmlReader extracts all song titles from catalog.xml.
    /// </summary>
    public class SongExtractr
    {
        private const string pathToXml = "../../../catalogue.xml";

        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Extract Song Titles ");

            var songTitles = new List<string>();

            using (var inputStream = XmlReader.Create(pathToXml))
            {
                while (inputStream.Read())
                {
                    // In case there are other elements besides song that have a tag title
                    if (inputStream.NodeType == XmlNodeType.Element && 
                        inputStream.Name == "song")
                    {
                        inputStream.ReadToFollowing("title");
                        songTitles.Add(inputStream.ReadInnerXml());
                    }
                }
            }

            Console.WriteLine("Completed\n ");
            helper.ConsoleMio.PrintColorText("Songs:\n", ConsoleColor.DarkRed);
            Console.WriteLine(string.Join("\n", songTitles.OrderBy(x => x)));

            helper.ConsoleMio.Restart(Main);
        }
    }
}
