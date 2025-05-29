<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Provider" %>
<%@ page import="DAO.WorkRequestDAO" %>
<%@ page import="DAO.ServiceDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="models.WorkRequest" %>

<%
    Provider provider = (Provider) session.getAttribute("provider");
    if (provider == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/plogin/providerlogin.jsp");
        return;
    }

    int providerId = provider.getProvider_id();

    int serviceCount = ServiceDAO.getServiceCountByProvider(providerId);
    int completedCount = WorkRequestDAO.getCompletedWorks(providerId).size();
    double totalEarnings = WorkRequestDAO.getTotalEarnings(providerId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service Provider Dashboard - PRO-NEST</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
        }

        .main-content {
            padding: 50px;
            text-align: center;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 120px;
            padding: 50px;
        }

        .card {
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .card h3 {
            margin: 0;
            color: #333;
        }

        .card p {
            font-size: 18px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<jsp:include page="headerp.jsp"/>

<div class="main-content">
    <h2>Welcome, <%= provider.getName() %>!</h2>
    <p>Here is a quick overview of your service activities.</p>

    <div class="card-grid">
        <div class="card" onclick="window.location.href='my_services.jsp';" style="cursor: pointer;">
            <h3>My Services</h3>
            <p><%= serviceCount %> total</p>
        </div>
        <div class="card" onclick="window.location.href='completed_work.jsp';" style="cursor: pointer;">
            <h3>Completed Jobs</h3>
            <p><%= completedCount %> total</p>
        </div>
        <div class="card">
            <h3>Total Earnings</h3>
            <p>₹<%= String.format("%.2f", totalEarnings) %></p>
        </div>
<!--        <div class="card">
            <h3>Profile Rating</h3>
            <p>4.8 ★</p>  Placeholder for now 
        </div>-->
    </div>
</div>

</body>
</html>
