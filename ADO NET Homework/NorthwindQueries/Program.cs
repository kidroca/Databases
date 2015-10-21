using System.Linq;

namespace NorthwindQueries
{
    using System;
    using System.Collections.Generic;
    using System.Data.SqlClient;
    using System.IO;
    using System.Threading.Tasks;

    using HomeworkHelpers;

    public class Program
    {
        private const string ConnectionString = "Server=.;Database=Northwind; " +
                                                "Integrated Security=true";

        private const string NextTaskMessage = "Press any key to print the next task...";

        private static ConsoleHelper consoleMio = new ConsoleHelper();

        [STAThread]
        private static void Main()
        {
            consoleMio.Setup();

            // Task 1
            consoleMio.PrintHeading("Task 1");

            int categoriesCount = GetCategories();
            consoleMio.WriteLine(
                "Number Of Rows in Categories: {0}", ConsoleColor.DarkGreen, categoriesCount);

            EndTaskRoutine();

            // Task 2
            consoleMio.PrintHeading("Task 2");
            Dictionary<string, string> nameDescriptionDict = GetNamesAndDescriptions();

            consoleMio.WriteLine("{0,-15} | {1}", ConsoleColor.DarkGreen, "Name", "Description");
            foreach (var pair in nameDescriptionDict)
            {
                Console.WriteLine("{0,-15} | {1}", pair.Key, pair.Value);
            }

            EndTaskRoutine();

            // Task 3
            consoleMio.PrintHeading("Task 3");
            Dictionary<string, List<string>> categoriesAndProducts = GetCategoriesAndProducts();
            foreach (var category in categoriesAndProducts.Keys)
            {
                consoleMio.WriteLine("{0}: ", ConsoleColor.DarkBlue, category);
                foreach (var product in categoriesAndProducts[category])
                {
                    Console.WriteLine("\t\t{0}", product);
                }
                Console.WriteLine();
            }

            EndTaskRoutine();

            // Task 4
            consoleMio.PrintHeading("Task 4");
            int rowsAffected = AddProduct("Marzipan", 0, "8", "3", "24 pieces", "5.15", "15");
            consoleMio.WriteLine("Affected Rows: {0}", ConsoleColor.DarkGreen, rowsAffected);

            EndTaskRoutine();

            //Task 5
            consoleMio.PrintHeading("Task 5");
            List<Task> tasks = GetCategoryImagesAsync();
            consoleMio.WriteLine(
                "Asynchornous taks running, write something while waiting...", ConsoleColor.DarkRed);
            while (tasks.Any(t => !t.IsCompleted))
            {
                consoleMio.ReadInColor(ConsoleColor.Cyan);
            }

            consoleMio.WriteLine("Tasks completed, files are saved!", ConsoleColor.DarkGreen);

            consoleMio.Restart(Main);
        }

        /// <summary>
        /// Write a program that retrieves from the Northwind sample database in MS SQL Server 
        /// the number of rows in the Categories table.
        /// </summary>
        /// <returns>Number of rows in Categories Table</returns>
        private static int GetCategories()
        {
            var connection = new SqlConnection(ConnectionString);

            connection.Open();
            using (connection)
            {
                var command = new SqlCommand("SELECT COUNT(*) FROM Categories", connection);

                return (int)command.ExecuteScalar();
            }
        }

        /// <summary>
        /// Write a program that retrieves the name and description of all categories in the 
        /// Northwind DB.
        /// </summary>
        /// <returns>Dictionary of Key = Category, Value = Description</returns>
        private static Dictionary<string, string> GetNamesAndDescriptions()
        {
            var connection = new SqlConnection(ConnectionString);

            var extractedNamesAndDescriptions = new Dictionary<string, string>();

            connection.Open();
            using (connection)
            {
                var command = new SqlCommand(
                    "SELECT CategoryName, Description FROM Categories", connection);

                var readStream = command.ExecuteReader();
                while (readStream.Read())
                {
                    extractedNamesAndDescriptions.Add(
                        (string)readStream["CategoryName"],
                        (string)readStream["Description"]);
                }
            }

            return extractedNamesAndDescriptions;
        }

        /// <summary>
        /// Write a program that retrieves from the Northwind database all product categories and 
        /// the names of the products in each category.
        /// </summary>
        /// <returns>Dictionary of Key = Category, Value = List of products</returns>
        private static Dictionary<string, List<string>> GetCategoriesAndProducts()
        {
            var connection = new SqlConnection(ConnectionString);

            var categoryProductsDict = new Dictionary<string, List<string>>();

            connection.Open();
            using (connection)
            {
                var command = new SqlCommand(
                    "SELECT c.CategoryName, p.ProductName " +
                    "FROM Categories c JOIN Products p " +
                    "ON c.CategoryID = p.CategoryID " +
                    "ORDER BY c.CategoryName", connection);

                var readStream = command.ExecuteReader();
                while (readStream.Read())
                {
                    string category = (string)readStream["CategoryName"];
                    if (!categoryProductsDict.ContainsKey(category))
                    {
                        categoryProductsDict.Add(category, new List<string>());
                    }

                    string product = (string)readStream["ProductName"];
                    categoryProductsDict[category].Add(product);
                }
            }

            return categoryProductsDict;
        }

        /// <summary>
        /// Write a method that adds a new product in the products table in the Northwind database.
        ///     Use a parameterized SQL command.
        /// </summary>
        /// <param name="name">Name of the product</param>
        /// <param name="discontinued"></param>
        /// <param name="additionalInfo">
        /// Optional Additional Columns Data:
        ///     SupplierID, CategoryID, QuantityPerUnit,
        ///     UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel
        /// </param>
        /// <returns>Count of affected rows</returns>
        private static int AddProduct(string name, byte discontinued, params string[] additionalInfo)
        {
            string[] additioalColumns =
            {
                "SupplierID", "CategoryID", "QuantityPerUnit",
                "UnitPrice", "UnitsInStock", "UnitsOnOrder", "ReorderLevel"
            };

            string[] additionalParams =
            {
                "@supplier", "@category", "@quantit",
                "@price", "@stock", "@onOrder", "@reorderLevel"
            };

            List<SqlParameter> parameters = new List<SqlParameter>()
            {
                new SqlParameter("@name", name),
                new SqlParameter("@discontinued", discontinued),
            };

            for (int i = 0; i < additionalInfo.Length; i++)
            {
                var parameter = new SqlParameter(additionalParams[i], additionalInfo[i]);
                parameters.Add(parameter);
            }

            string columns = string.Format(
                "ProductName, Discontinued, {0}",
                    string.Join(", ", additioalColumns, 0, additionalInfo.Length));

            string values = string.Format(
                "VALUES(@name, @discontinued, {0})",
                    string.Join(", ", additionalParams, 0, additionalInfo.Length));

            var connection = new SqlConnection(ConnectionString);

            connection.Open();
            using (connection)
            {
                var command = new SqlCommand("INSERT INTO Products(" +
                columns + ") " + values, connection);

                command.Parameters.AddRange(parameters.ToArray());

                return command.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Write a program that retrieves the images for all categories in the Northwind 
        /// database and stores them as JPG files in the file system.
        /// </summary>
        private static List<Task> GetCategoryImagesAsync()
        {
            List<Task> tasks = new List<Task>();
            var filesHelper = new StreamHomeworkHelper();

            filesHelper.ConsoleMio.WriteLine(
                "Select where to save the images", ConsoleColor.DarkMagenta);

            string saveDirectory = filesHelper.GetDirectory();

            var connection = new SqlConnection(ConnectionString);
            connection.Open();
            using (connection)
            {
                var command = new SqlCommand("SELECT Picture FROM Categories", connection);

                var readStream = command.ExecuteReader();

                int fileNumber = 0;
                while (readStream.Read())
                {
                    string currentFile = string.Format("{0}.jpg", ++fileNumber);

                    var fileWriter = new FileStream(
                        saveDirectory + "\\" + currentFile, FileMode.Create, FileAccess.Write, FileShare.None, 4096, FileOptions.Asynchronous);

                    using (fileWriter)
                    {
                        // the pictures in Northwind are stored with leading bytes of 
                        // non standard information
                        int startOffset = 78;

                        byte[] currentPicture = (byte[])readStream[0];
                        Task writeCurrentFile = fileWriter.WriteAsync(
                            currentPicture, startOffset, currentPicture.Length - startOffset);

                        tasks.Add(writeCurrentFile);
                    }
                }
            }

            return tasks;
        }

        private static void EndTaskRoutine()
        {
            Console.WriteLine();
            consoleMio.WriteLine(NextTaskMessage, ConsoleColor.DarkRed);
            Console.ReadKey(true);
        }
    }
}
