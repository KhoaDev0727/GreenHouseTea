<%-- 
    Document   : service
    Created on : Nov 4, 2024, 10:53:32 PM
    Author     : le minh khoa
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Green House Coffee - Services</title>
        <link rel="stylesheet" href="./css/style.css">
        <style>
            /* Styling the service page */
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
                color: #333;
            }
            .header {
                background-color: #4b3b2f;
                color: #fff;
                padding: 15px;
                text-align: center;
                font-size: 24px;
            }
            .banner {
                background-image: url('images/banner-coffee.jpg');
                background-size: cover;
                color: white;
                padding: 60px;
                text-align: center;
            }
            .banner h1 {
                font-size: 48px;
                margin: 0;
            }
            .services-section {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 50px 20px;
            }
            .service-item {
                width: 80%;
                background: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin: 20px 0;
                padding: 20px;
                border-radius: 8px;
                transition: transform 0.2s;
            }
            .service-item:hover {
                transform: translateY(-10px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }
            .service-icon {
                font-size: 40px;
                color: #4b3b2f;
            }
            .service-title {
                font-size: 28px;
                margin: 10px 0;
                color: #4b3b2f;
            }
            .service-description {
                font-size: 16px;
                color: #555;
            }
            .footer {
                background-color: #4b3b2f;
                color: #fff;
                text-align: center;
                padding: 20px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp" />

        <div class="banner">
            <h1>Our Services</h1>
            <p>Experience our inviting coffee space with top-notch services at Green House Coffee</p>
        </div>

        <div class="services-section">
            <div class="service-item">
                <div class="service-icon">☕</div>
                <h2 class="service-title">On-Site Service</h2>
                <p class="service-description">Enjoy a perfect cup of coffee in the cozy and relaxing space of Green House.</p>
            </div>
            <div class="service-item">
                <div class="service-icon">🏃‍♂️</div>
                <h2 class="service-title">Takeaway Service</h2>
                <p class="service-description">Quick and convenient takeaway service for those always on the go.</p>
            </div>
            <div class="service-item">
                <div class="service-icon">🚚</div>
                <h2 class="service-title">Home Delivery</h2>
                <p class="service-description">Order online, and we’ll deliver coffee right to your door with careful service.</p>
            </div>
            <div class="service-item">
                <div class="service-icon">🎉</div>
                <h2 class="service-title">Event Services</h2>
                <p class="service-description">Book our space for meetings, birthdays, and special events.</p>
            </div>
        </div>

        <div class="footer">
            <p>&copy; 2024 Green House Coffee. Follow us on social media: 
                <a href="#" style="color: #fff; margin: 0 10px;">Facebook</a> |
                <a href="#" style="color: #fff; margin: 0 10px;">Instagram</a> |
                <a href="#" style="color: #fff; margin: 0 10px;">Twitter</a>
            </p>
        </div>

        <script src="./js/controller.js"></script>
    </body>
</html>
