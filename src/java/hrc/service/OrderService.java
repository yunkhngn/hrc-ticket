package hrc.service;

import hrc.dao.OrderDAO;
import hrc.dao.OrderItemDAO;
import hrc.dao.CustomerDAO;
import hrc.entity.Order;
import hrc.entity.OrderItem;
import hrc.entity.Customer;
import java.util.List;

public class OrderService {
    private final OrderDAO orderDAO;
    private final OrderItemDAO orderItemDAO;
    private final CustomerDAO customerDAO;
    
    public OrderService() {
        this.orderDAO = new OrderDAO();
        this.orderItemDAO = new OrderItemDAO();
        this.customerDAO = new CustomerDAO();
    }
    
    public List<Order> getAllOrders() {
        return orderDAO.list();
    }
    
    public List<Order> getOrdersByCustomer(Long customerId) {
        return orderDAO.findByCustomerId(customerId);
    }
    
    public Order getOrderById(Long id) {
        return orderDAO.findById(id);
    }
    
    public Order getOrderWithItems(Long id) {
        Order order = orderDAO.findById(id);
        if (order != null) {
            List<OrderItem> items = orderItemDAO.findByOrderId(id);
            // Note: In a real application, you might want to add items to order object
            // For now, we'll keep it simple
        }
        return order;
    }
    
    public boolean createOrder(Order order) {
        return orderDAO.create(order);
    }
    
    public boolean updateOrder(Order order) {
        return orderDAO.update(order);
    }
    
    public List<OrderItem> getOrderItems(Long orderId) {
        return orderItemDAO.findByOrderId(orderId);
    }
    
    public boolean createOrderItem(OrderItem orderItem) {
        return orderItemDAO.create(orderItem);
    }
    
    public Customer getCustomerById(Long id) {
        return customerDAO.findById(id);
    }
}
