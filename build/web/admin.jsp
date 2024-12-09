<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="DAOs.ProductDAO" %>
<%@ page import="DAOs.OrderDAO" %>
<%@ page import="Models.Product" %>
<%@ page import="Models.Order" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container-fluid {
                display: flex;
                height: 100vh;
            }
            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                padding: 20px;
                color: white;
            }
            .sidebar h3 {
                font-weight: bold;
            }
            .sidebar a {
                color: white;
                text-decoration: none;
                display: block;
                padding: 10px;
                margin-bottom: 10px;
                border-radius: 5px;
            }
            .sidebar a:hover {
                background-color: #1abc9c;
            }
            .content {
                flex: 1;
                padding: 20px;
            }
            .table-container {
                margin-top: 20px;
            }
            /* Hide add product form initially */
            #addProductForm {
                display: none;
            }
            .form-container {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .form-container h2 {
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <!-- Sidebar -->
            <div class="sidebar">
                <h3>Admin Menu</h3>
                <a href="javascript:void(0)" onclick="showSection('addProductForm')">Add Product</a>
                <a href="javascript:void(0)" onclick="showSection('productList')">Product List</a>
                <a href="javascript:void(0)" onclick="showSection('orderList')">Order List</a>
                <a href="LogoutServlet">Logout</a>
            </div>

            <!-- Content Area -->
            <div class="content">
                <!-- Add Product Form -->
                <div id="addProductForm" class="form-container">
                    <h2>Add Product</h2>
                    <form action="AddProductServlet" method="post">
                        <div class="form-group">
                            <label for="productName">Product Name:</label>
                            <input type="text" id="productName" name="productName" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="category">Category:</label>
                            <input type="text" id="category" name="category" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="price">Price:</label>
                            <input type="number" id="price" name="price" class="form-control" step="0.01" required>
                        </div>

                        <div class="form-group">
                            <label for="quantity">Quantity:</label>
                            <input type="number" id="quantity" name="quantity" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="imageUrl">Image URL:</label>
                            <input type="text" id="imageUrl" name="imageUrl" class="form-control" required>
                        </div>

                        <button type="submit" class="btn btn-success">Add Product</button>
                    </form>
                </div>

                <!-- Product List -->
                <div id="productList" class="table-container">
                    <h2>Product List</h2>
                    <%
                        ProductDAO productDAO = new ProductDAO();
                        List<Product> productList = productDAO.getAllProducts();
                    %>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Image</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Product product : productList) { %>
                            <tr>
                                <td><%= product.getProductID() %></td>
                                <td><%= product.getProductName() %></td>
                                <td><%= product.getCategory() %></td>
                                <td><%= product.getPrice() %></td>
                                <td><%= product.getQuantity() %></td>
                                <td><img src="<%= product.getImageUrl() %>" alt="Product Image" width="50"></td>
                                <td>
                                    <form action="EditProductServlet" method="get" style="display:inline;">
                                        <input type="hidden" name="productID" value="<%= product.getProductID() %>">
                                        <button type="submit" class="btn btn-primary btn-sm">Edit</button>
                                    </form>
                                    <button class="btn btn-danger btn-sm" onclick="openDeleteModal(<%= product.getProductID() %>)">Delete</button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Order List -->
                <div id="orderList" class="table-container" style="display:none;">
                    <h2>Order List</h2>
                    <%
                        OrderDAO orderDAO = new OrderDAO();
                        List<Order> orders = orderDAO.getAllOrders(); // Lấy danh sách đơn hàng
                    %>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Recipient Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Order Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (orders != null && !orders.isEmpty()) {
                            for (Order order : orders) { %>
                            <tr>
                                <td><%= order.getOrderID() %></td>
                                <td><%= order.getUserName() %></td>
                                <td><%= order.getEmail() %></td>
                                <td><%= order.getPhone() %></td>
                                <td><%= order.getAddress() %></td>
                                <td><%= order.getOrderDate() %></td>
                                <td><%= order.getStatus() %></td>
                                <td>
                                    <form action="UpdateOrderStatusServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderID() %>">
                                        <select name="status" class="form-select">
                                            <option value="Not delivered" <%= order.getStatus().equals("Not delivered") ? "selected" : "" %>>Not delivered</option>
                                            <option value="Delivered" <%= order.getStatus().equals("Delivered") ? "selected" : "" %>>Delivered</option>
                                        </select>
                                        <button type="submit" class="btn btn-success btn-sm">Update</button>
                                    </form>

                                    <form action="DeleteOrderServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderID() %>">
                                        <button type="button" class="btn btn-danger btn-sm" onclick="confirmDeleteOrder(<%= order.getOrderID() %>)">Delete</button>
                                    </form>

                                    <!-- Delete Confirmation Modal -->
                                    <div class="modal fade" id="deleteOrderModal" tabindex="-1" aria-labelledby="deleteOrderModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="deleteOrderModalLabel">Confirm Deletion</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    Are you sure you want to delete this order?
                                                </div>
                                                <div class="modal-footer">
                                                    <form id="deleteOrderForm" action="DeleteOrderServlet" method="post" style="display:inline;">
                                                        <input type="hidden" name="orderId" id="deleteOrderId">
                                                        <button type="submit" class="btn btn-danger">Delete</button>
                                                    </form>
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <% } 
                        } else { %>
                            <tr>
                                <td colspan="8">No orders yet.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this product?
                    </div>
                    <div class="modal-footer">
                        <form id="deleteForm" action="DeleteProductServlet" method="post" style="display:inline;">
                            <input type="hidden" name="productID" id="productID">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
        <script>
        function showSection(section) {
            document.getElementById('addProductForm').style.display = 'none';
            document.getElementById('productList').style.display = 'none';
            document.getElementById('orderList').style.display = 'none';

            document.getElementById(section).style.display = 'block';
        }

        function openDeleteModal(productId) {
            document.getElementById('productID').value = productId;
            var myModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            myModal.show();
        }

        // Mặc định hiển thị danh sách sản phẩm
        showSection('productList');

        function confirmDeleteOrder(orderId) {
        document.getElementById('deleteOrderId').value = orderId;
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteOrderModal'));
        deleteModal.show();
    }
        </script>
    </body>
</html>
