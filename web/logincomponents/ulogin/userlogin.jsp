 <%@page import="DAO.UserDAO" %>
<%@page import="models.User" %>
<%@page session="true" %>


<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Pronest</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, html {
            height: 100%;
            font-family: 'Segoe UI', sans-serif;
            overflow: hidden;
        }

        .background {
            position: fixed;
            width: 100%;
            height: 100%;
            background: url('<%=request.getContextPath()%>/images/login.jpg');
            background-size: cover;
            z-index: -1;
        }

        .overlay {
            position: fixed;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            z-index: -1;
        }

        .login-container {
            position: absolute;
            top: 50%;
            right: 50px;
            transform: translateY(-50%);
            width: 420px;
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.96);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            border-radius: 12px;
            animation: slideInRight 1s ease forwards;
        }

        @keyframes slideInRight {
            from {
                right: -500px;
                opacity: 0;
            }
            to {
                right: 50px;
                opacity: 1;
            }
        }

        h2 {
            text-align: center;
            color: #333;
        }
        
        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            font-size: 15px;
            margin-bottom: 6px;
            display: block;
            color: #333;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            font-size: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            background-color: #007BFF;
            color: white;
            border: none;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }

        .login-btn:hover {
            background-color: #0056b3;
        }

        .bottom-text {
            margin-top: 18px;
            text-align: center;
            font-size: 14px;
        }

        .bottom-text a {
            color: #007BFF;
            text-decoration: none;
        }

        .bottom-text a:hover {
            text-decoration: none;
        }
        
        .error {
            color: red;
            font-size: 14px;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="background"></div>
<div class="overlay"></div>

<div class="login-container">
    <h2>LOGIN</h2>

    <%
    String error = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null && password != null) {
            UserDAO ud = new UserDAO();
            User user = ud.getUserByEmailAndPassword(email, password);

            if (user != null) {
                session.setAttribute("user", user);

                // Check user role
                String role = user.getRole(); // Assuming getRole() method exists in User model

                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/Admin/mainpageadmin.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/User/mainpageu.jsp");
                }
                return; // Stop further processing
            } else {
                error = "Invalid username or password.";
            }
        }
    }
%>


    <form method="post">
        <div class="form-group">
            <label for="email">E-mail</label>
            <input type="text" id="user" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="login-btn">Login</button>
    </form>

    <% if (!error.isEmpty()) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <div class="bottom-text">
        New to PRO-NEST? <a href="userregistration.jsp">Register</a>
    </div>
    <div class="bottom-text">
        login as  <a href="../plogin/providerlogin.jsp">Service provider</a>
    </div>
</div>

</body>
</html>
