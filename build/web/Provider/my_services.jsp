<%@ page import="java.util.*" %>
<%@ page import="DAO.ServiceDAO, models.Provider, models.Service" %>
<%@ page session="true" %>
<%
    Provider provider = (Provider) session.getAttribute("provider");
    if (provider == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/plogin/providerlogin.jsp");
        return;
    }

     
    String deleteId = request.getParameter("deleteId");
    if (deleteId != null) {
        int serviceId = Integer.parseInt(deleteId);
        boolean deleted = ServiceDAO.deleteService(serviceId);
        String message = deleted ? "Service deleted successfully." : "Failed to delete service.";
        response.sendRedirect("my_services.jsp?message=" + message); // Redirect to show the message
        return;
    }
    
    // Retrieve the list of services
//    Provider provider = (Provider) session.getAttribute("provider");
    List<Service> serviceList = ServiceDAO.getServicesByProvider(provider.getProvider_id());
%>

<html>
<head>
    <title>My Services</title>
    <style>
        .card {
            border: 1px solid #ccc;
            padding: 16px;
            margin: 10px auto;
            border-radius: 10px;
            width: 60%;
            box-shadow: 2px 2px 8px #aaa;
        }
        .btn {
            padding: 6px 12px;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 8px;
        }
        .pending-btn { background-color: orange; color: white; }
        .delete-btn { background-color: red; color: white; }
    </style>
</head>
<body>
    <jsp:include page="headerp.jsp"/>

    <% if (request.getParameter("message") != null) { %>
        <script>
            alert("<%= request.getParameter("message") %>");
        </script>
    <% } %>

    <h2 style="text-align:center;">My Created Services</h2>

    <% if (serviceList == null || serviceList.isEmpty()) { %>
        <p style="text-align:center;">No services created yet.</p>
    <% } else {
        for (Service s : serviceList) {
    %>
        <div class="card">
            <p><strong>Service ID:</strong> <%= s.getService_id() %></p>
            <p><strong>Title:</strong> <%= s.getCategory() %></p>
            <p><strong>Description:</strong> <%= s.getDescription() %></p>
            <p><strong>Price:</strong> <%= s.getPrice() %></p>

            <a href="pending_work.jsp?serviceId=<%= s.getService_id() %>" class="btn pending-btn">Pending Works</a>
            <a href="my_services.jsp?deleteId=<%= s.getService_id() %>" class="btn delete-btn">Delete Service</a>
        </div>
    <% } } %>

</body>
</html>
