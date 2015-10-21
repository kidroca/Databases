namespace Northwind.DataAccess
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using System.Threading.Tasks;

    /// <summary>
    /// 1. Using the Visual Studio Entity Framework designer create a DbContext for the Northwind database
    /// 
    /// 2. Create a DAO class with static methods which provide functionality for inserting, modifying 
    /// and deleting customers.
    ///     Write a testing class.
    /// 
    /// 5. Write a method that finds all the sales by specified region and period (start / end dates).
    /// 
    /// P.S. I didn't make the methods static, but asyncrhonous
    /// </summary>
    public class DataAccessManager : ICustomersAccessor, IOrdersAccessor
    {
        public async Task<Order[]> GetAllOrdersAsync()
        {
            using (var ctx = new NorthwindEntities())
            {
                return await ctx.Orders.ToArrayAsync();
            }
        }

        public async Task<Order> GetOrderAsync(int id)
        {
            using (var ctx = new NorthwindEntities())
            {
                return await ctx.Orders.FindAsync(id);
            }
        }

        public Task AddOrderAsync(Order order)
        {
            return this.ChangeEntityStateAsync(order, EntityState.Added);
        }

        public Task DeleteOrderAsync(Order order)
        {
            return this.ChangeEntityStateAsync(order, EntityState.Deleted);
        }

        public Task UpdateOrderAsync(Order order)
        {
            return this.ChangeEntityStateAsync(order, EntityState.Modified);
        }

        public async Task<Customer> GetCustomerAsync(int id)
        {
            using (var ctx = new NorthwindEntities())
            {
                return await ctx.Customers.FindAsync(id);
            }
        }

        public async Task<Customer[]> GetAllCustomersAsync()
        {
            using (var ctx = new NorthwindEntities())
            {
                return await ctx.Customers.ToArrayAsync();
            }
        }

        public Task AddCustomerAsync(Customer customer)
        {
            return this.ChangeEntityStateAsync(customer, EntityState.Added);
        }

        public Task DeleteCustomerAsync(Customer customer)
        {
            return this.ChangeEntityStateAsync(customer, EntityState.Deleted);
        }

        public Task UpdateCustomerAsync(Customer customer)
        {
            return this.ChangeEntityStateAsync(customer, EntityState.Modified);
        }

        /// <summary>
        /// 5. Write a method that finds all the sales by specified region and period (start / end dates).
        /// </summary>
        /// <param name="lowerBoundry"></param>
        /// <param name="upperBoundry"></param>
        /// <param name="shipRegion"></param>
        /// <param name="shipCountry"></param>
        /// <returns>A Task that will hold the result when the query is completed</returns>
        public async Task<Customer[]> GetCustomersWithOrdersBetweenDatesAsync(
            DateTime lowerBoundry, DateTime upperBoundry, string shipRegion = null, string shipCountry = null)
        {
            using (var ctx = new NorthwindEntities())
            {
                var query = ctx.Customers
                    .Where(c => c.Orders.Any(o =>
                        lowerBoundry <= o.OrderDate && o.OrderDate <= upperBoundry));

                if (!string.IsNullOrEmpty(shipRegion))
                {
                    query = query.Where(c => c.Orders.Any(o => o.ShipRegion == shipRegion));
                }

                if (!string.IsNullOrEmpty(shipCountry))
                {
                    query = query.Where(c => c.Orders.Any(o => o.ShipCountry == shipCountry));
                }

                return await query.ToArrayAsync();
            }
        }

        public async Task<string[]> ExecuteNativeSqlQueryAsync(string query)
        {
            if (query.IndexOf("drop", StringComparison.OrdinalIgnoreCase) != -1)
            {
                throw new InvalidOperationException("Detected DROP Statement in SQL query");
            }

            using (var ctx = new NorthwindEntities())
            {
                return await ctx.Database.SqlQuery<string>(query).ToArrayAsync();
            }
        }

        private async Task ChangeEntityStateAsync(object entity, EntityState state)
        {
            using (var ctx = new NorthwindEntities())
            {
                var entry = ctx.Entry(entity);
                entry.State = state;
                await ctx.SaveChangesAsync();
            }
        }
    }
}