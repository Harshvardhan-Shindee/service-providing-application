<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/ulogin/userlogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us - Pronest</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: url('about.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .overlay {
            background-color: rgba(0, 0, 0, 0.6);
            position: fixed;
            width: 100%;
            height: 100%;
            z-index: 0;
        }

        .content-box {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            text-align: center;
            z-index: 2;
            width: 500px;
        }

        h2 {
            margin-bottom: 15px;
            color: #333;
        }

        p {
            color: #555;
            line-height: 1.6;
        }

        .back-btn {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            background-color: #007BFF;
            color: white;
            cursor: pointer;
        }

        .back-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    
    <jsp:include page="headeru.jsp"/>
    
    <div class="overlay"></div>

    <div class="content-box">
        <h2>About Us</h2>
        <p>Pronest is a trusted platform that connects customers with verified service providers across India. From home cleaning to plumbing, our mission is to bring convenience to your doorstep with transparency and quality.</p>
        <button class="back-btn" onclick="window.location.href='mainpageu.jsp'">Back to Home</button>
    </div>
    
</body>
</html>