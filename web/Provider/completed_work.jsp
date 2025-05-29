<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="models.WorkRequest, models.Provider, models.User, models.Service" %>
<%@ page import="DAO.WorkRequestDAO, DAO.UserDAO, DAO.ServiceDAO" %>

<%
    // Check if provider is logged in
    Provider provider = (Provider) session.getAttribute("provider");
    if (provider == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/plogin/providerlogin.jsp");
        return;
    }

    // Get completed works for the provider
    WorkRequestDAO workRequestDAO = new WorkRequestDAO();
    List<WorkRequest> completedWorks = workRequestDAO.getCompletedWorks(provider.getProvider_id());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Completed Works</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 30px;
            color: #333;
        }

        .work-cards-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 30px;
        }

        .work-card {
            background-color: white;
            width: 300px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: 0.3s;
        }

        .work-card:hover {
            transform: scale(1.02);
        }

        .work-card h3 {
            margin-top: 0;
            color: #28a745;
        }

        .work-card p {
            color: #555;
            margin: 8px 0;
        }

        .no-data {
            text-align: center;
            margin-top: 50px;
            color: #888;
        }
    </style>
</head>
<body>

<jsp:include page="headerp.jsp" />

<h1>Completed Works</h1>

<div class="work-cards-container">
    <% 
        if (completedWorks != null && !completedWorks.isEmpty()) {
            UserDAO ud = new UserDAO();
            ServiceDAO sd = new ServiceDAO();
            for (WorkRequest work : completedWorks) {
                User user = ud.getUserById(work.getUser_id());
                Service service = sd.getServiceById(work.getService_id());
    %>
    <div class="work-card">
        <h3>Request ID: <%= work.getRequest_id() %></h3>
        <p><strong>User Name:</strong> <%= user.getName() %></p>
        <p><strong>User Mobile:</strong> <%= user.getPhone() %></p>
        <p><strong>Service:</strong> <%= service.getCategory()%></p>
        <p><strong>Status:</strong> <%= work.getStatus() %></p>
    </div>
    <% 
            }
        } else { 
    %>
    <div class="no-data">No completed works available.</div>
    <% } %>
</div>

</body>
</html>
