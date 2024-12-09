package control;

import DAOs.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        
        OrderDAO orderDAO = new OrderDAO();
        orderDAO.deleteOrder(orderId);
        
        response.sendRedirect("admin.jsp"); // Điều hướng lại trang quản lý sau khi xóa
    }
}
