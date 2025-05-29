<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.UserDAO, DAO.ProviderDAO, DAO.WorkRequestDAO, models.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/ulogin/userlogin.jsp");
        return;
    }
    
    
    int totalUsers = UserDAO.getTotalUsers();
    int totalProviders = ProviderDAO.getTotalProviders();
    int totalPending = WorkRequestDAO.getTotalPendingWorks();
    int totalCompleted = WorkRequestDAO.getTotalCompletedWorks();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Dashboard - PRO-NEST</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
        }

        .dashboard {
            padding: 50px;
            text-align: center;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            padding: 40px;
        }

        .card {
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .card h3 {
            margin: 0;
            color: #333;
        }

        .card p {
            font-size: 24px;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<jsp:include page="headerA.jsp" />

<div class="dashboard">
    <h2>ADMIN - DASHBOARD</h2>
    <div class="stats-grid">
        <div class="card">
            <h3>Total Users</h3>
            <p><%= totalUsers %></p>
        </div>
        <div class="card">
            <h3>Total Providers</h3>
            <p><%= totalProviders %></p>
        </div>
        <div class="card">
            <h3>Pending Works</h3>
            <p><%= totalPending %></p>
        </div>
        <div class="card">
            <h3>Completed Works</h3>
            <p><%= totalCompleted %></p>
        </div>
    </div>
</div>

</body>
</html>
