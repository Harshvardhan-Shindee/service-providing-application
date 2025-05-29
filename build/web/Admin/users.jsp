<%@ page import="java.util.*, DAO.UserDAO, DAO.WorkRequestDAO, DAO.ServiceDAO, models.WorkRequest, models.Service,  models.User" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/ulogin/userlogin.jsp");
        return;
    }
    // Handle user update if form submitted
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("updateUser") != null) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String aadhar = request.getParameter("aadhar");
        String role = request.getParameter("role");

        User use = new User(id, name, email, password, phone, aadhar, role);
        UserDAO.updateUser(use);
        response.sendRedirect("users.jsp");
        return;
    }

    // Handle delete user
    if (request.getParameter("deleteId") != null) {
        int deleteId = Integer.parseInt(request.getParameter("deleteId"));
        UserDAO.deleteUser(deleteId);
        response.sendRedirect("users.jsp");
        return;
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7fc; }
        .container { max-width: 900px; }
        .table { margin-top: 20px; border-radius: 10px; overflow: hidden; }
        .table th, .table td { text-align: center; vertical-align: middle; }
        .table th:nth-child(2), .table td:nth-child(2) { width: 50%; }
        .table th:nth-child(1), .table td:nth-child(1) { width: 10%; }
        .table th:nth-child(3), .table td:nth-child(3) { width: 30%; }
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
    <h2 class="mb-4 text-center">User List</h2>
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
            List<User> users = UserDAO.getAllUsers();
            for (User u : users) {
        %>
        <tr>
            <td><%= u.getUser_id() %></td>
            <td><%= u.getName() %></td>
            <td>
                <!-- Info Button -->
                <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#infoModal<%= u.getUser_id() %>">Info</button>
                <!-- Edit Button -->
                <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#editModal<%= u.getUser_id() %>">Edit</button>
                <!-- Delete Button (form for POST delete) -->
                <form method="post" action="users.jsp" style="display:inline;">
                    <input type="hidden" name="deleteId" value="<%= u.getUser_id() %>" />
                    <button class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want delete?')">Delete</button>
                </form>
            </td>
        </tr>

        <!-- Info Modal -->
        <div class="modal fade" id="infoModal<%= u.getUser_id() %>" tabindex="-1" aria-labelledby="infoModalLabel<%= u.getUser_id() %>" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">User Details - <%= u.getName() %></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p><strong>User ID:</strong> <%= u.getUser_id() %></p>
                        <p><strong>Name:</strong> <%= u.getName() %></p>
                        <p><strong>Email:</strong> <%= u.getEmail() %></p>
                        <p><strong>Password:</strong> <%= u.getPassword() %></p>
                        <p><strong>Phone:</strong> <%= u.getPhone() %></p>
                        <p><strong>Aadhar:</strong> <%= u.getAadhar() %></p>

                        <hr>
                        <h6>Pending Work</h6>
                        <%
                            List<WorkRequest> pendingWorks = WorkRequestDAO.getPendingWorkByUser(u.getUser_id());
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
                                <strong>Service:</strong> <%= s.getCategory() %><br>
                                <strong>Description:</strong> <%= s.getDescription() %><br>
                                <strong>Status:</strong> <%= w.getStatus() %>
                            </li>
                            <% } %>
                        </ul>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Modal -->
        <div class="modal fade" id="editModal<%= u.getUser_id() %>" tabindex="-1" aria-labelledby="editModalLabel<%= u.getUser_id() %>" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form method="post" action="users.jsp">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit User - <%= u.getName() %></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="updateUser" value="true" />
                            <input type="hidden" name="id" value="<%= u.getUser_id() %>" />
                            <div class="mb-3">
                                <label>Name</label>
                                <input type="text" name="name" class="form-control" value="<%= u.getName() %>" required />
                            </div>
                            <div class="mb-3">
                                <label>Email</label>
                                <input type="email" name="email" class="form-control" value="<%= u.getEmail() %>" required />
                            </div>
                            <div class="mb-3">
                                <label>Password</label>
                                <input type="text" name="password" class="form-control" value="<%= u.getPassword() %>" required />
                            </div>
                            <div class="mb-3">
                                <label>Phone</label>
                                <input type="text" name="phone" class="form-control" value="<%= u.getPhone() %>" required />
                            </div>
                            <div class="mb-3">
                                <label>Aadhar</label>
                                <input type="text" name="aadhar" class="form-control" value="<%= u.getAadhar() %>" required />
                            </div>
                            <input type="hidden" name="role" class="form-control" value="<%= u.getRole()%>" required />
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-success" type="submit">Save Changes</button>
                            <button class="btn btn-secondary" data-bs-dismiss="modal" type="button">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <% } %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
