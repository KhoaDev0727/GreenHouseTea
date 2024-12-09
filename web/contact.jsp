<%-- 
    Document   : contact
    Created on : Nov 5, 2024, 10:51:04 AM
    Author     : le minh khoa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>       
        <meta charset="utf-8">
        <title>contact page</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <style>
            .header {
                background-color: black;
            }

            .title-header {
                align-self: end;
                padding-bottom: 10px;
            }
            .form-group a {
                margin-bottom: 15px;
            }

            .card-body{
                height: 630px;
                width: auto;
            }

            .body{
                margin-top: 150px;
            }
            .content-wrapper {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 20px;
            }

            .card-header h3 {
                color: white;
                font-family: Arial;
                margin-top: 7px;
            }

            .form-group input{
                margin-left: 10px;
                width: 570px;
            }

            .card{
                width: 630px;
                height: auto;
            }
            .text-left{
                font-family: Arial;
                text-align: left;
                padding: 15px;
                color: grey;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0px 2px 4px 5px rgba(0, 0, 0, 0.05);
                margin-bottom: 50px;
                font-size: 18px;
            }

            .text-left a {
                padding: 5px;
            }

            .left-body{
                margin-left: 70px;
                display: block;
                width: 500px;
                height: auto;

            }

            .text-center button{
                width: 120px;
                background-color: #81C408;
                font-weight: bold;
            }

            .btn-back{
                width: 120px;
                background-color: #FBB431;
                color: white;
                font-weight: bold;
            }

            .image-section img {
                width: 450px;
                height: auto;
                object-fit: cover;
            }

            .image-section {
                flex: 1;

            }

            .text-section {
                flex: 1;
                width: 800px;
            }

            .text-section h1 {
                font-size: 2em;
                color: #333;
            }

            .text-section p {
                font-size: 1.2em;
                color: #666;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp" />

        <div id="toast" class="toast" style="display: none;">
            Your information has been sent successfully!
        </div>
        <div class="body">
            <div class="content-wrapper">
                <div class="left-body">
                    <div class="text-left">
                        <a>Address: Ninh Kieu, CanTho</a>
                        <br>
                        <a>Email: GreenHouse@gmail.com</a>
                        <br>
                        <a>Phone: +8409 8888 8888</a>
                    </div>
                    <div class="image-section">
                        <img src="./img/banner4.jpeg" alt="Background Image">
                    </div>
                </div>
                <div class="container mt-5">
                    <div class="row justify-content-center">
                        <div class="col-md-8 col-lg-6">
                            <div class="card shadow-lg">
                                <div class="card-header bg-primary text-white text-center">
                                    <h3>Contact Us</h3>
                                </div>
                                <div class="card-body">
                                    <form action="contact.jsp" method="post">
                                        <div class="form-group">
                                            <a>Full Name:</a>
                                            <input type="text" id="fullname" name="fullname" class="form-control" title="Enter your fullname" required>
                                        </div>
                                        <div class="form-group">
                                            <a>Email:</a>
                                            <input type="email" id="email" name="email" class="form-control" required>
                                        </div>
                                        <div class="form-group">
                                            <a>Phone:</a>
                                            <input type="tel" id="phone" name="phone" class="form-control" required pattern="[0-9]{10}" title="Enter a 10-digit phone number">
                                        </div>
                                        <div class="form-group">
                                            <a>Address:</a>
                                            <input type="text" id="address" name="address" class="form-control" title="Enter your address">
                                        </div>
                                        <div class="form-group">
                                            <a>Your Feedback:</a>
                                            <textarea id="large-text" name="feedback" rows="5" class="form-control" maxlength="200"></textarea>
                                        </div>
                                        <div class="text-center">
                                            <button type="submit" name="sent" class=" btn btn-success btn-block">Send</button>
                                            <a href="index.jsp" class="btn btn-secondary btn-back">Back</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <% 
            if (request.getParameter("sent") != null) {
                String fullname = request.getParameter("fullname");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String feedback = request.getParameter("feedback");

                Connection conn = null;
                PreparedStatement stmt = null;

                try {
                    // Kết nối tới cơ sở dữ liệu
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    String dbURL = "jdbc:sqlserver://LEMINHKHOA:1433;databaseName=GreenHouseDB;encrypt=true;trustServerCertificate=true;";
                    String dbUser = "sa";
                    String dbPassword = "12345";
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String sql = "INSERT INTO Contact (fullname, email, phone, address, feedback) VALUES (?, ?, ?, ?, ?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, fullname);
                    stmt.setString(2, email);
                    stmt.setString(3, phone);
                    stmt.setString(4, address);
                    stmt.setString(5, feedback);

                    int rowsInserted = stmt.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("");
                    } else {
                        out.println("<p>Sorry, there was an error. Please try again.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>

        <script src="./js/controller.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>      
    </body>
</html>
