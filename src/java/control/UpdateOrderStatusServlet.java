package control;

import DAOs.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateOrderStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy giá trị orderId và status từ form
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        
        // Kiểm tra giá trị orderId và status để đảm bảo không có giá trị null
        if (orderId != null && status != null) {
            OrderDAO orderDAO = new OrderDAO();
            
            // Cập nhật trạng thái đơn hàng
            orderDAO.updateOrderStatus(orderId, status);
        }
        
        // Chuyển hướng về trang admin sau khi cập nhật
        response.sendRedirect("admin.jsp");
    }
}
