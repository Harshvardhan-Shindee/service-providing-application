
<%@ page import="java.util.*" %>
<%@ page import="DAO.ServiceDAO" %>
<%@ page import="models.User ,models.Service" %>
<%@ page import="DAO.WorkRequestDAO" %>
<%@ page import="models.WorkRequest" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Session check for logged-in user
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/ulogin/userlogin.jsp");
        return;
    }

    List<Service> services = ServiceDAO.getServicesByCategory("Education");

    String bookServiceIdStr = request.getParameter("bookServiceId");
    if (bookServiceIdStr != null) {
        int serviceId = Integer.parseInt(bookServiceIdStr);

        // Get the service to know provider_id
        Service selectedService = ServiceDAO.getServiceById(serviceId);

        if (selectedService != null) {
            WorkRequest wr = new WorkRequest();
            wr.setUser_id(user.getUser_id());
            wr.setProvider_id(selectedService.getProvider_id());
            wr.setService_id(serviceId);
            wr.setStatus("Pending");

            boolean booked = WorkRequestDAO.createRequest(wr);

            if (booked) {
                request.setAttribute("message", "Service booked successfully!");
            } else {
                request.setAttribute("message", "Failed to book service. Try again.");
            }
        } else {
            request.setAttribute("message", "Invalid service selected.");
        }
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <title>Education Services</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 1100px;
                margin: 40px auto;
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: center;
            }
            .card {
                background: white;
                width: 300px;
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.15);
                padding: 20px;
                transition: 0.3s;
            }
            .card:hover {
                transform: scale(1.02);
            }
            .card h3 {
                margin-top: 0;
                color: #333;
            }
            .card p {
                margin: 5px 0;
                color: #666;
            }
            .btn {
                background-color: #28a745;
                color: white;
                padding: 10px 16px;
                text-decoration: none;
                border: none;
                border-radius: 6px;
                display: inline-block;
                margin-top: 10px;
                cursor: pointer;
            }
            .btn:hover {
                background-color: #218838;
            }
            h1 {
                text-align: center;
                margin-top: 40px;
                color: #333;
            }
        </style>
    </head>
    <body>

        <jsp:include page="headeru.jsp"/>

        <%            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
        <script>alert("<%= message%>");</script>
        <%
            }
        %>

        <h1>Education Services</h1>

        <div class="container">
            <%
                if (services != null && !services.isEmpty()) {
                    for (Service service : services) {
            %>
            <div class="card">
                <h3><%= service.getCategory()%></h3>
                <p><strong>Provider:</strong> <%= service.getProviderName()%></p>
                <p><strong>Description:</strong> <%= service.getDescription()%></p>
                <p><strong>Price:</strong> ₹<%= service.getPrice()%></p>
                <form method="get">
                    <input type="hidden" name="bookServiceId" value="<%= service.getService_id()%>" />
                    <button class="btn" type="submit">Book Now</button>
                </form>



            </div>
            <%
                }
            } else {
            %>
            <p style="text-align:center; width: 100%;">No Education services available at the moment.</p>
            <%
                }
            %>
        </div>

        <jsp:include page="footeru.jsp"/>

    </body>
</html>
