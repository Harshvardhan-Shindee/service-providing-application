<%@page import="models.User"%>
<%@page import="DAO.UserDAO"%>
<%@page import="java.sql.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/ulogin/userlogin.jsp");
        return;
    }

    String message = null;

    // Update Logic
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("action") != null) {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String aadhar = request.getParameter("aadhar");

            user.setName(name);
            user.setPassword(password);
            user.setPhone(phone);
            user.setAadhar(aadhar);

            boolean updated = UserDAO.updateUser(user);
            if (updated) {
                message = "Profile updated successfully.";
                session.setAttribute("user", user); // Update session object
            } else {
                message = "Failed to update profile.";
            }

        } else if ("delete".equals(action)) {
            int user_id = user.getUser_id();
            boolean deleted = UserDAO.deleteUser(user_id);
            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/logincomponents/logout.jsp");
                return;
            } else {
                message = "Failed to delete account.";
            }
        }

    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Profile</title>
        <!--        <link rel="stylesheet" href="../profile.css">-->
        <style>
            .form-container {
                max-width: 420px;
                margin: 30px auto;
                padding: 30px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .form-container h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #333;
            }

            .form-container label {
                display: block;
                margin: 12px 0 5px;
                font-weight: 600;
            }

            .form-container input {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                gap: 15px;
                margin-top: 20px;
            }

            .button-group button {
                flex: 1;
                padding: 12px;
                font-weight: 600;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }

            .update-btn {
                background-color: #28a745;
                color: white;
            }

            .delete-btn {
                background-color: #dc3545;
                color: white;
            }
        </style>
    </head>
    
    <body>
        
        <jsp:include page="headeru.jsp"/>
        
        <div class="form-container">
        <h2>User Profile</h2>

        <!-- Update Form -->
        <form method="post" onsubmit="return confirm('Are you sure you want to update your account?')">
            <input type="hidden" name="action" value="update">

            <label>User ID</label>
            <input type="text" name="user_id" value="<%= user.getUser_id()%>" readonly>

            <label>Name</label>
            <input type="text" name="name" value="<%= user.getName()%>" required>

            <label>Email</label>
            <input type="email" name="email" value="<%= user.getEmail()%>" readonly>

            <label>Password</label>
            <input type="password" name="password" value="<%= user.getPassword()%>" required>

            <label>Phone</label>
            <input type="text" name="phone" value="<%= user.getPhone()%>" required>

            <label>Aadhar</label>
            <input type="text" name="aadhar" value="<%= user.getAadhar()%>" required>

            <div class="button-group">
                <button type="submit" class="update-btn">Update Profile</button>
            </div>
        </form>

        <!-- Delete Form -->
        <form method="post" onsubmit="return confirm('Are you sure you want to delete your account?')">
            <input type="hidden" name="action" value="delete">

            <div class="button-group">
                <button type="submit" class="delete-btn">Delete Profile</button>
            </div>
        </form>
    </div>
            
            <jsp:include page="footeru.jsp"/>
    </body>

</html>
