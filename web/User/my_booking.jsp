<%@ page import="java.util.*" %>
<%@ page import="DAO.WorkRequestDAO, DAO.UserDAO, DAO.ProviderDAO, DAO.ServiceDAO " %>
<%@page import="models.WorkRequest, models.User, models.Provider, models.Service" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/ulogin/userlogin.jsp");
        return;
    }

    String markId = request.getParameter("markId");
    String cancelId = request.getParameter("cancelId");
    String message = null;

    if (markId != null) {
        int reqId = Integer.parseInt(markId);
        boolean updated = WorkRequestDAO.markAsCompleted(reqId);
        message = updated ? "Marked as done!" : "Failed to update status.";
    }

    if (cancelId != null) {
        int reqId = Integer.parseInt(cancelId);
        boolean cancelled = WorkRequestDAO.cancelRequest(reqId);
        message = cancelled ? "Request cancelled." : "Failed to cancel.";
    }

    List<WorkRequest> workList = WorkRequestDAO.getUserRequests(user.getUser_id());
    Collections.reverse(workList); // Latest first
%>

<html>
    <head>
        <title>My Bookings</title>
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
            .done-btn { background-color: green; color: white; }
            .cancel-btn { background-color: red; color: white; }
        </style>
    </head>
    <body>
        <jsp:include page="headeru.jsp"/>

        <% if (message != null) {%>
        <script>
            alert("<%= message%>");
            window.location.href = "my_booking.jsp";
        </script>
        <% } %>

        <h2 style="text-align:center;">My Bookings</h2>

        <% if (workList == null || workList.size() == 0) { %>
        <p style="text-align:center;">You have no work requests yet.</p>
        <% } else {
           
            ServiceDAO sd = new ServiceDAO();
            for (WorkRequest w : workList) {
                Provider provider = ProviderDAO.getProviderById(w.getProvider_id());
                Service service = sd.getServiceById(w.getService_id());
        %>
        <div class="card">
            <p><strong>Request ID:</strong> <%= w.getRequest_id()%></p>
            <p><strong>Provider Name:</strong> <%= provider.getName()%></p>
            <p><strong>Service ID:</strong> <%= w.getService_id()%></p>
            <p><strong>Service Name:</strong> <%= service.getCategory()%></p>
            <p><strong>Status:</strong> <%= w.getStatus()%></p>
            <p><strong>Request Date:</strong> <%= w.getRequest_date()%></p>

            <% if ("Pending".equalsIgnoreCase(w.getStatus())) {%>
            <a href="my_booking.jsp?markId=<%= w.getRequest_id()%>" class="btn done-btn">Mark as Done</a>
            <a href="my_booking.jsp?cancelId=<%= w.getRequest_id()%>" class="btn cancel-btn">Cancel</a>
            <% } else {%>
            <p style="color:green;"><strong>Status:</strong> <%= w.getStatus()%></p>
            <% } %>
        </div>
        <% }
        }%>

        <jsp:include page="footeru.jsp"/>
    </body>
</html>
