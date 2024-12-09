package control;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:sqlserver://LEMINHKHOA:1433;databaseName=GreenHouseDB;encrypt=true;trustServerCertificate=true;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "12345";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        Map<String, String> errors = new HashMap<>();

        // Validate inputs
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.put("fullNameError", "Full name is required.");
        }
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            errors.put("emailError", "Invalid email address.");
        }
        if (phone == null || !phone.matches("\\d{10,15}")) {
            errors.put("phoneError", "Invalid phone number. Enter 10-15 digits.");
        }
        if (address == null || address.trim().isEmpty()) {
            errors.put("addressError", "Address is required.");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Process order if no errors
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("cart.jsp?error=Session expired. Please try again.");
            return;
        }

        List<AddToCartServlet.CartItem> cart = (List<AddToCartServlet.CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Your cart is empty.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement orderStmt = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false);

            String updateQuantitySQL = "UPDATE Products SET Quantity = Quantity - ? WHERE ProductName = ? AND Quantity >= ?";
            pstmt = conn.prepareStatement(updateQuantitySQL);

            BigDecimal grandTotal = new BigDecimal(0);

            for (AddToCartServlet.CartItem item : cart) {
                pstmt.setInt(1, item.getQuantity());
                pstmt.setString(2, item.getModel());
                pstmt.setInt(3, item.getQuantity());

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected == 0) {
                    conn.rollback();
                    response.sendRedirect("cart.jsp?error=Insufficient quantity for product: " + item.getModel());
                    return;
                }

                BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                grandTotal = grandTotal.add(itemTotal);
            }

            Integer userID = (Integer) session.getAttribute("userID");
            if (userID == null) {
                response.sendRedirect("cart.jsp?error=User not logged in.");
                return;
            }

            String insertOrderSQL = "INSERT INTO Orders (UserID, FullName, Email, Phone, Address, OrderDate, Status, TotalAmount) VALUES (?, ?, ?, ?, ?, GETDATE(), 'On the way', ?)";
            orderStmt = conn.prepareStatement(insertOrderSQL);
            orderStmt.setInt(1, userID);
            orderStmt.setString(2, fullName);
            orderStmt.setString(3, email);
            orderStmt.setString(4, phone);
            orderStmt.setString(5, address);
            orderStmt.setBigDecimal(6, grandTotal);
            orderStmt.executeUpdate();

            conn.commit();
            session.removeAttribute("cart");

            // Send order confirmation email
            String subject = "Order Confirmation - GreenHouse";
            StringBuilder body = new StringBuilder("<h1>Thank you for your order, " + fullName + "!</h1>");
            body.append("<p>Your order is on the way. Here are your order details:</p>");
            body.append("<ul>");
            for (AddToCartServlet.CartItem item : cart) {
                body.append("<li>").append(item.getModel()).append(" - Quantity: ").append(item.getQuantity())
                        .append(", Price: $").append(item.getPrice()).append("</li>");
            }
            body.append("</ul>");
            body.append("<p><strong>Total Amount: $").append(grandTotal).append("</strong></p>");
            body.append("<p>We will notify you once the order has been delivered.</p>");

            EmailUtility.sendEmail(email, subject, body.toString());

            response.sendRedirect("orderConfirmation.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.sendRedirect("cart.jsp?error=Internal error. Please try again.");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (orderStmt != null) orderStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
