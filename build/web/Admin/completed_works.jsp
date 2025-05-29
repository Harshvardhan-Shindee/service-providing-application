<%@ page import="java.util.*, DAO.WorkRequestDAO, DAO.UserDAO, DAO.ProviderDAO, DAO.ServiceDAO, models.WorkRequest, models.User, models.Provider, models.Service" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/ulogin/userlogin.jsp");
        return;
    }
%>

<html>
<head>
    <title>Completed Works</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="headerA.jsp" />
<div class="container mt-5">
    <h2 class="mb-4 text-center">All Completed Works</h2>
    <table class="table table-bordered">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>User Name</th>
            <th>Provider Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Created Date</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<WorkRequest> list = WorkRequestDAO.getAllCompletedWorks();
            for (WorkRequest w : list) {
                User u = UserDAO.getUserById(w.getUser_id());
                Provider p = ProviderDAO.getProviderById(w.getProvider_id());
                Service s = ServiceDAO.getServiceById(w.getService_id());
        %>
        <tr>
            <td><%= w.getRequest_id() %></td>
            <td><%= u.getName() %></td>
            <td><%= p.getName() %></td>
            <td><%= s.getCategory() %></td>
            <td><%= s.getPrice() %></td>
            <td><%= w.getRequest_date()%></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
