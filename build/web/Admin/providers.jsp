<%@ page import="java.util.*, DAO.ProviderDAO, DAO.WorkRequestDAO, DAO.ServiceDAO, models.Provider, models.WorkRequest, models.Service" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/ulogin/userlogin.jsp");
        return;
    }
%>
<%
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("updateProvider") != null) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String aadhar = request.getParameter("aadhar");
        Provider provider = new Provider(id, name, email, password, phone, aadhar);
        ProviderDAO.updateProvider(provider);
        response.sendRedirect("providers.jsp");
        return;
    }

    if (request.getParameter("deleteId") != null) {
        int deleteId = Integer.parseInt(request.getParameter("deleteId"));
        ProviderDAO.deleteProvider(deleteId);
        response.sendRedirect("providers.jsp");
        return;
    }
%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>All Providers</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f4f7fc; }
            .container { max-width: 900px; }
            .table { margin-top: 20px; border-radius: 10px; overflow: hidden; }
            .table th, .table td { text-align: center; vertical-align: middle; }
            .btn-info { background-color: #17a2b8; border-color: #17a2b8; }
            .modal-header { background-color: #343a40; color: white; }
            .modal-body { background-color: #f8f9fa; }
            .modal-content { border-radius: 10px; }
            .btn { margin-right: 10px; }
        </style>
    </head>
    <body>
        <jsp:include page="headerA.jsp" />

        <div class="container mt-5">
            <h2 class="mb-4 text-center">Provider List</h2>
            <table class="table table-bordered table-striped shadow-sm">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Provider> providers = ProviderDAO.getAllProviders();
                        for (Provider p : providers) {
                    %>
                    <tr>
                        <td><%= p.getProvider_id()%></td>
                        <td><%= p.getName()%></td>
                        <td>
                            <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#infoModal<%= p.getProvider_id()%>">Info</button>
                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#editModal<%= p.getProvider_id()%>">Edit</button>
                            <form method="post" action="providers.jsp" style="display:inline;">
                                <input type="hidden" name="deleteId" value="<%= p.getProvider_id()%>" />
                                <button class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete?')">Delete</button>
                            </form>
                        </td>
                    </tr>

                    <!-- Info Modal -->
                <div class="modal fade" id="infoModal<%= p.getProvider_id()%>" tabindex="-1" aria-labelledby="infoModalLabel<%= p.getProvider_id()%>" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Provider Details - <%= p.getName()%></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p><strong>ID:</strong> <%= p.getProvider_id()%></p>
                                <p><strong>Name:</strong> <%= p.getName()%></p>
                                <p><strong>Email:</strong> <%= p.getEmail()%></p>
                                <p><strong>Password:</strong> <%= p.getPassword()%></p>
                                <p><strong>Phone:</strong> <%= p.getPhone()%></p>
                                <p><strong>Aadhar:</strong> <%= p.getAadhar()%></p>

                                <hr>
                                <h6>Pending Work Requests</h6>
                                <%
                                    List<WorkRequest> pendingWorks = WorkRequestDAO.getPendingWorkByProvider(p.getProvider_id());
                                    if (pendingWorks.isEmpty()) {
                                %>
                                <p class="text-muted">No pending work.</p>
                                <%
                                } else {
                                %>
                                <ul class="list-group">
                                    <% for (WorkRequest w : pendingWorks) {
                                            Service s = ServiceDAO.getServiceById(w.getService_id());
                                    %>
                                    <li class="list-group-item">
                                        <strong>Service:</strong> <%= s.getCategory()%><br>
                                        <strong>Description:</strong> <%= s.getDescription()%><br>
                                        <strong>Status:</strong> <%= w.getStatus()%>
                                    </li>
                                    <% } %>
                                </ul>
                                <% } %>
                                <h6>Completed Work Requests</h6>
                                <%
                                    List<WorkRequest> completedWorks = WorkRequestDAO.getCompletedWorkByProvider(p.getProvider_id());
                                    if (completedWorks.isEmpty()) {
                                %>
                                <p class="text-muted">No completed work.</p>
                                <%
                                } else {
                                %>
                                <ul class="list-group">
                                    <% for (WorkRequest w : completedWorks) {
                                            Service s = ServiceDAO.getServiceById(w.getService_id());
                                    %>
                                    <li class="list-group-item">
                                        <strong>Service:</strong> <%= s.getCategory()%><br>
                                        <strong>Description:</strong> <%= s.getDescription()%><br>
                                        <strong>Status:</strong> <%= w.getStatus()%>
                                    </li>
                                    <% } %>
                                </ul>
                                <% }%>

                            </div>
                        </div>
                    </div>
                </div>

                <!-- Edit Modal -->
                <div class="modal fade" id="editModal<%= p.getProvider_id()%>" tabindex="-1" aria-labelledby="editModalLabel<%= p.getProvider_id()%>" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="providers.jsp">
                                <div class="modal-header">
                                    <h5 class="modal-title">Edit Provider - <%= p.getName()%></h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="hidden" name="updateProvider" value="true" />
                                    <input type="hidden" name="id" value="<%= p.getProvider_id()%>" />
                                    <div class="mb-3">
                                        <label>Name</label>
                                        <input type="text" name="name" class="form-control" value="<%= p.getName()%>" required />
                                    </div>
                                    <div class="mb-3">
                                        <label>Email</label>
                                        <input type="email" name="email" class="form-control" value="<%= p.getEmail()%>" required />
                                    </div>
                                    <div class="mb-3">
                                        <label>Password</label>
                                        <input type="text" name="password" class="form-control" value="<%= p.getPassword()%>" required />
                                    </div>
                                    <div class="mb-3">
                                        <label>Phone</label>
                                        <input type="text" name="phone" class="form-control" value="<%= p.getPhone()%>" required />
                                    </div>
                                    <div class="mb-3">
                                        <label>Aadhar</label>
                                        <input type="text" name="aadhar" class="form-control" value="<%= p.getAadhar()%>" required />
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-success" type="submit">Save Changes</button>
                                    <button class="btn btn-secondary" data-bs-dismiss="modal" type="button">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <% }%>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
