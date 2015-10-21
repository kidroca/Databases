namespace Northwind.DataAccess
{
    using System.Threading.Tasks;

    public interface IOrdersAccessor
    {
        Task<Order[]> GetAllOrdersAsync();

        Task<Order> GetOrderAsync(int id);

        Task AddOrderAsync(Order order);

        Task DeleteOrderAsync(Order order);

        Task UpdateOrderAsync(Order order);
    }
}
