<%@ page session="true" %>
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page import="models.WorkRequest, models.Provider, models.User, models.Service" %>
<%@ page import="DAO.WorkRequestDAO, DAO.UserDAO, DAO.ServiceDAO" %>
<%@ page import="java.sql.*, connection.DBConnection" %>


<%
    Provider provider = (Provider) session.getAttribute("provider");
    if (provider == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/plogin/providerlogin.jsp");
        return;
    }

    // Action Handling
    String action = request.getParameter("action");
    String reqIdParam = request.getParameter("requestId");

    if (action != null && reqIdParam != null) {
        int requestId = Integer.parseInt(reqIdParam);

        if (action.equals("complete")) {
            WorkRequestDAO.markAsCompleted(requestId);
        } else if (action.equals("cancel")) {
            try {
                Connection con = DBConnection.getConnection();
                String sql = "UPDATE work_requests SET status='Cancelled' WHERE request_id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, requestId);
                ps.executeUpdate();
                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect to avoid form resubmission
        response.sendRedirect("pending_work.jsp");
        return;
    }

    // Fetch pending works
    String serviceIdParam = request.getParameter("serviceId");
    int serviceId = 0;
    List<WorkRequest> pendingWorks = new ArrayList<WorkRequest>();


    if (serviceIdParam != null) {
        serviceId = Integer.parseInt(serviceIdParam);
        pendingWorks = WorkRequestDAO.getPendingWorksByService(provider.getProvider_id(), serviceId);
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Pending Works</title>
        <style>
            .work-cards-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                padding: 20px;
            }

            .work-card {
                border: 1px solid #ccc;
                padding: 20px;
                width: 300px;
                border-radius: 10px;
                box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
            }

            .btn {
                display: inline-block;
                margin-top: 10px;
                padding: 8px 15px;
                border: none;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                margin-right: 10px;
                cursor: pointer;
            }

            .btn.cancel {
                background-color: #dc3545;
            }

            .btn:hover {
                opacity: 0.9;
            }
        </style>
    </head>
    <body>

        <jsp:include page="headerp.jsp" />

        <h1 style="text-align:center;">Pending Works for Service ID: <%= serviceId %></h1>

        <div class="work-cards-container">
            <% UserDAO ud = new UserDAO();
            ServiceDAO sd = new ServiceDAO();
            for (WorkRequest work : pendingWorks) {
                User user = ud.getUserById(work.getUser_id());
                Service service = sd.getServiceById(work.getService_id());
            %>
            <div class="work-card">
                <h3>Work ID: <%= work.getRequest_id()%></h3>
                <p><strong>User Name:</strong> <%= user.getName()%></p>
                <p><strong>User Mobile:</strong> <%= user.getPhone()%></p>
                <p><strong>Status:</strong> <%= work.getStatus()%></p>
                <p><strong>Service ID:</strong> <%= work.getService_id()%></p>
                <p><strong>Service Name:</strong> <%= service.getCategory()%></p>
                <p><strong>User ID:</strong> <%= work.getUser_id()%></p>

                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="complete" />
                    <input type="hidden" name="requestId" value="<%= work.getRequest_id()%>" />
                    <button type="submit" class="btn">Mark as Complete</button>
                </form>

                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="cancel" />
                    <input type="hidden" name="requestId" value="<%= work.getRequest_id()%>" />
                    <button type="submit" class="btn cancel">Cancel Work</button>
                </form>
            </div>
            <% }%>
        </div>

    </body>
</html>
