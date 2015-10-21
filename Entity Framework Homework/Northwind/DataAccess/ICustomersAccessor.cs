namespace Northwind.DataAccess
{
    using System.Threading.Tasks;

    public interface ICustomersAccessor
    {
        Task<Customer[]> GetAllCustomersAsync();

        Task<Customer> GetCustomerAsync(int id);

        Task AddCustomerAsync(Customer customer);

        Task DeleteCustomerAsync(Customer customer);

        Task UpdateCustomerAsync(Customer customer);
    }
}
