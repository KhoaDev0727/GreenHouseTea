package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String imageUrl = request.getParameter("imageUrl");

        // Kiểm tra null cho các tham số
        if (productName == null || category == null || priceStr == null || quantityStr == null) {
            response.getWriter().write("Please fill all required fields.");
            return; // Kết thúc sớm nếu có tham số null
        }

        try {
            // Chuyển đổi giá và số lượng từ String sang số
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);

            // Tải driver JDBC
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 

            // Kết nối đến database
            String url = "jdbc:sqlserver://LEMINHKHOA:1433;databaseName=GreenHouseDB;encrypt=true;trustServerCertificate=true;";
            String user = "sa"; 
            String password = "12345"; 
            Connection connection = DriverManager.getConnection(url, user, password);

            // Câu lệnh SQL để thêm sản phẩm
            String sql = "INSERT INTO Products (ProductName, Category, Price, Quantity, ImageUrl) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, productName);
            statement.setString(2, category);
            statement.setDouble(3, price);
            statement.setInt(4, quantity);
            statement.setString(5, imageUrl);

            // Thực hiện câu lệnh
            statement.executeUpdate();

            // Đóng kết nối
            statement.close();
            connection.close();

            // Chuyển hướng về trang admin sau khi thêm sản phẩm thành công
            response.sendRedirect("admin.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().write("Invalid number format for price or quantity.");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("SQL Server Driver not found: " + e.getMessage());
        }
    }

}
