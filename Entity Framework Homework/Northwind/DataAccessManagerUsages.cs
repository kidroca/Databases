namespace Northwind
{
    using System;
    using HomeworkHelpers;
    using Northwind.DataAccess;

    /// <summary>
    /// Write a testing class.
    /// 
    /// Write a method that finds all customers who have orders made in 1997 and shipped to Canada.
    /// 
    /// Implement previous by using native SQL query and executing it through the DbContext.
    /// </summary>
    public class DataAccessManagerUsages
    {
        private const string KEY_CHECK_MESSAGE = "Press A key to continue if the query is completed";

        private const string NOT_YET = "The query is not yet done";

        private const string QUERY_SUCCESS_FORMAT = "Query completed successfully: {0}";

        private const string CHECK_SQL_SERVER = "Check out the changes in SQL Server and press a key to continue...";

        private static ConsoleHelper consoleMio = new ConsoleHelper();

        private static void Main()
        {
            consoleMio.Setup();

            consoleMio.PrintHeading("Task 2 - Data Access Model Usages And Tests ");

            var accessManager = new DataAccessManager();

            // Get All Customers
            consoleMio.WriteLine("Get All customers", ConsoleColor.DarkBlue);

            var getAllTask = accessManager.GetAllCustomersAsync();
            consoleMio.WriteLine(KEY_CHECK_MESSAGE, ConsoleColor.DarkGreen);
            while (!getAllTask.IsCompleted)
            {
                // Async activity simulation
                Console.WriteLine(NOT_YET);
                Console.ReadKey(true);
            }

            Console.WriteLine(QUERY_SUCCESS_FORMAT, !getAllTask.IsFaulted);

            foreach (var cust in getAllTask.Result)
            {
                Console.WriteLine(cust.City);
            }

            Console.WriteLine();

            // Add Customer
            consoleMio.WriteLine("Add new customer", ConsoleColor.DarkBlue);

            var customer = new Customer()
            {
                CustomerID = "DZUAD",
                Address = "Kolio Ganchev",
                City = "Stara Zagora",
                CompanyName = "DZU",
                ContactName = "Con tac",
                ContactTitle = "Bai",
                Country = "Bulgaria",
                PostalCode = "6000",
                Phone = "(359) 42-877-677",
            };

            var addCustomerTask = accessManager.AddCustomerAsync(customer);
            WaitSqlServerCheck(addCustomerTask.Wait(5000));

            // Update Customer
            consoleMio.WriteLine("Update existing customer", ConsoleColor.DarkBlue);

            customer.Address = "Samara 3";
            customer.Fax = "(359) 42-877-578";

            var updateCustomerTask = accessManager.UpdateCustomerAsync(customer);
            WaitSqlServerCheck(updateCustomerTask.Wait(5000));

            // Delete Customer
            consoleMio.WriteLine("Delete existing customer", ConsoleColor.DarkBlue);

            var deleteCustomerTask = accessManager.DeleteCustomerAsync(customer);
            WaitSqlServerCheck(deleteCustomerTask.Wait(5000));

            /* 3. Write a method that finds all customers who have orders made in 1997 and shipped to Canada. */
            consoleMio.PrintHeading(
                "Task 3 Write a method that finds all customers who have orders made in 1997 and shipped to Canada ");

            var customersTask = accessManager.GetCustomersWithOrdersBetweenDatesAsync(new DateTime(1997, 1, 1),
                new DateTime(1997, 12, 31, 23, 59, 59), shipCountry: "Canada");

            consoleMio.WriteLine("Result: ", ConsoleColor.DarkGreen);

            if (customersTask.Wait(5000))
            {
                foreach (var candidate in customersTask.Result)
                {
                    Console.WriteLine(candidate.CompanyName);
                }
            }

            WaitSqlServerCheck(!customersTask.IsFaulted);

            /* 4. Implement previous by using native SQL query and executing it through the DbContext. */
            consoleMio.PrintHeading(
                "Task 4 Implement previous by using native SQL query and executing it through the DbContext. ");

            // Try adding 'DROP' statement in the string to test my simple defence
            string sqlQuery = "SELECT DISTINCT CompanyName " +
                              "FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID " +
                              "WHERE YEAR(o.OrderDate) = 1997 AND o.ShipCountry = 'Canada'";

            var customersSqlTask = accessManager.ExecuteNativeSqlQueryAsync(sqlQuery);

            consoleMio.WriteLine("Result: ", ConsoleColor.DarkGreen);

            while (!customersSqlTask.IsCompleted)
            {
                // Clumsy task waiter
            }

            if (!customersSqlTask.IsFaulted)
            {
                foreach (var item in customersSqlTask.Result)
                {
                    Console.WriteLine(item);
                }
            }

            WaitSqlServerCheck(!customersSqlTask.IsFaulted);
        }

        private static void WaitSqlServerCheck(bool isSuccessfull)
        {
            ConsoleColor color = ConsoleColor.Red;
            if (isSuccessfull)
            {
                color = ConsoleColor.DarkGreen;
            }

            consoleMio.WriteLine(QUERY_SUCCESS_FORMAT, color, isSuccessfull);
            Console.WriteLine();
            Console.WriteLine(CHECK_SQL_SERVER);
            Console.ReadKey(true);
            Console.WriteLine();
        }
    }
}
