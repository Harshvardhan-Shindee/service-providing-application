<%@page import="models.Provider"%>
<%@page import="DAO.ProviderDAO"%>
<%@page import="java.sql.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Provider provider = (Provider) session.getAttribute("provider");
    if (provider == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/plogin/providerlogin.jsp");
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

            provider.setName(name);
            provider.setPassword(password);
            provider.setPhone(phone);
            provider.setAadhar(aadhar);

            boolean updated = ProviderDAO.updateProvider(provider);
            if (updated) {
                message = "Profile updated successfully.";
                session.setAttribute("provider", provider); // Update session object
            } else {
                message = "Failed to update profile.";
            }

        } else if ("delete".equals(action)) {
            int provider_id = provider.getProvider_id();
            boolean deleted = ProviderDAO.deleteProvider(provider_id);
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
        <title>Provider Profile</title>
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
        
        <jsp:include page="headerp.jsp"/>
        
        <div class="form-container">
        <h2>Provider Profile</h2>

        <!-- Update Form -->
        <form method="post" onsubmit="return confirm('Are you sure you want to update your account?')">
            <input type="hidden" name="action" value="update">

            <label>User ID</label>
            <input type="text" name="provider_id" value="<%= provider.getProvider_id()%>" readonly>

            <label>Name</label>
            <input type="text" name="name" value="<%= provider.getName()%>" required>

            <label>Email</label>
            <input type="email" name="email" value="<%= provider.getEmail()%>" readonly>

            <label>Password</label>
            <input type="password" name="password" value="<%= provider.getPassword()%>" required>

            <label>Phone</label>
            <input type="text" name="phone" value="<%= provider.getPhone()%>" required>

            <label>Aadhar</label>
            <input type="text" name="aadhar" value="<%= provider.getAadhar()%>" required>

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

    </body>

</html>
