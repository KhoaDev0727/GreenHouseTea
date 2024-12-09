<%-- 
    Document   : searchResults
    Created on : Oct 31, 2024, 2:57:23 PM
    Author     : le minh khoa
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Product" %>
<jsp:include page="header.jsp" />

<%-- Retrieve the search results list from the servlet --%>
<%
    List<Product> searchResults = (List<Product>) request.getAttribute("searchResults");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <link rel="stylesheet" href="css/style.css"> <%-- Ensure the path is correct --%>
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f3ef;
            color: #3e3d3a;
        }
        h2 {
            font-size: 2em;
            color: #5e4631;
            text-align: center;
            padding-bottom: 10px;
            border-bottom: 1px solid #dcd2b6;
        }

        /* Search Results Container */
        .search-results-container {
            padding: 20px;
            max-width: 1000px;
            margin: 30px auto;
            background-color: #fffdf5;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Result Item */
        .result-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border: 1px solid #e0d9ca;
            margin-bottom: 15px;
            border-radius: 10px;
            background-color: #fff;
            transition: transform 0.3s ease;
        }
        .result-item:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .result-item img {
            width: 80px;
            height: 80px;
            margin-right: 20px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid #ddd;
        }

        /* Result Info */
        .result-info h4 {
            margin: 0;
            font-size: 1.25em;
            color: #5e4631;
        }
        .result-info p {
            margin: 5px 0;
            font-size: 0.95em;
            color: #8b8b7a;
        }

        /* Add to Cart Button */
        .btn-add-to-cart {
            margin-left: auto;
            padding: 10px 15px;
            background-color: #a67643;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.95em;
            transition: background-color 0.3s;
        }
        .btn-add-to-cart:hover {
            background-color: #8a5d3c;
        }
    </style>
</head>
<body>
<div class="search-results-container">
    <h2>Search results for "<%= request.getParameter("searchQuery") %>"</h2>
   
    <c:choose>
        <c:when test="${not empty searchResults}">
            <c:forEach var="product" items="${searchResults}">
                <div class="result-item">
                    <img src="${product.imageUrl}" alt="${product.productName}">
                    <div class="result-info">
                        <h4>${product.productName}</h4>
                        <p>Category: ${product.category}</p>
                        <p>Price: ${product.price} $</p>
                    </div>
                    <form action="AddToCartServlet" method="post">
                        <input type="hidden" name="productID" value="${product.productID}">
                        <button type="submit" class="btn-add-to-cart">Add to Cart</button>
                    </form>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p style="text-align: center; color: #8b8b7a;">No products found matching your search.</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
