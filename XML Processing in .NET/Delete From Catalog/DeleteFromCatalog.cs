namespace Databases.XmlProcessing.DeleteFromCatalog
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Xml;
    using HomeworkHelpers;

    /// <summary>
    /// Using the DOM parser write a program to delete from catalog.xml all albums having price > 20.
    /// </summary>
    public class DeleteFromCatalog
    {
        private const string pathToXml = "../../../Sample.xml";

        private const string savePath = "../../../RemovedPriceAbove20.xml";

        private static StreamHomeworkHelper helper = new StreamHomeworkHelper();

        private static void Main()
        {
            helper.ConsoleMio.Setup();
            helper.ConsoleMio.PrintHeading("Delete From Catalog");

            var doc = new XmlDocument();
            doc.Load(pathToXml);
            XmlElement root = doc.DocumentElement;

            int priceRange = 20;

            var albums = root.GetElementsByTagName("album");

            var nodesForeRemoval = new List<XmlNode>();

            foreach (XmlNode a in albums)
            {
                if (int.Parse(a["price"].InnerText) > priceRange)
                {
                    nodesForeRemoval.Add(a);
                }
            }

            foreach (XmlNode n in nodesForeRemoval)
            {
                root.RemoveChild(n);
            }

            doc.Save(savePath);

            Console.Write("Completed\n See the results at: ");
            helper.ConsoleMio.PrintColorText(new FileInfo(savePath).FullName, ConsoleColor.DarkGreen);

            helper.ConsoleMio.Restart(Main);
        }
    }
}
