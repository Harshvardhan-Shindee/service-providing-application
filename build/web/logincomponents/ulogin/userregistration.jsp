<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="DAO.UserDAO" %>
<%@page import="models.User" %>
<%@page session="true" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Pronest - Register</title>
        <style>

            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background: url('<%=request.getContextPath()%>/images/service.webp');
                background-size: cover;

            }

            .overlay {
                background-color: rgba(0, 0, 0, 0.6);
                position: fixed;
                width: 100%;
                height: 100%;
                z-index: 0;
            }


            /* Form Container */
            .form-container {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -45%);
                width: 400px;
                background-color: rgba(255, 255, 255, 0.95);
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
                z-index: 2;
                animation: slideUp 1.2s forwards;
            }

            @keyframes slideUp {
                from {
                    top: 100%;
                }
                to {
                    top: 45%;
                }
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                color: #333;
            }

            .form-group input {
                width: 100%;
                padding: 10px;
                border-radius: 8px;
                border: 1px solid #ccc;
            }

            .form-group input:focus {
                border-color: #007BFF;
            }

            .register-btn {
                width: 100%;
                padding: 12px;
                background-color: #007BFF;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .register-btn:hover {
                background-color: #0056b3;
            }

            .login-link {
                text-align: center;
                margin-top: 15px;
            }

            .login-link a {
                color: #007bff;
                text-decoration: none;
            }
        </style>

        <script>
            function checkPasswordMatch() {
            const password = document.getElementById("password").value;
                    const confirm = document.getElementById("confirmPassword").value;
                    if (password !== confirm) {
            alert("Passwords do not match!");
                    return false;
            }
            return true;
            }
            function validateForm() {
            var name = document.getElementById("fullname").value.trim();
                    var email = document.getElementById("email").value.trim();
                    var mobile = document.getElementById("mobile").value.trim();
                    var aadhar = document.getElementById("aadhar").value.trim();
                    var password = document.getElementById("password").value;
                    var confirmPassword = document.getElementById("confirmPassword").value;
                    var emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
                    var mobilePattern = /^[0-9]{10}$/;
                    var aadharPattern = /^[0-9]{12}$/;
                    if (name === "" || email === "" || mobile === "" || aadhar === "" || password === "" || confirmPassword === "") {
            alert("All fields are required!");
                    return false;
            }

            if (!emailPattern.test(email)) {
            alert("Invalid email address!");
                    return false;
            }

            if (!mobilePattern.test(mobile)) {
            alert("Mobile must be 10 digits.");
                    return false;
            }

            if (!aadharPattern.test(aadhar)) {
            alert("Aadhar must be 12 digits.");
                    return false;
            }

            if (password.length < 6) {
            alert("Password must be at least 6 characters.");
                    return false;
            }

            if (password !== confirmPassword) {
            alert("Passwords do not match!");
                    return false;
            }

            return true;
            }
        </script>
    </head>
    <body>


        <div class="overlay"></div>

        <!-- Registration Form -->
        <div class="form-container">
            <h2>Register</h2>
            <form onsubmit="return validateForm();"  method="post">
                <div class="form-group">
                    <label for="fullname">Full Name</label>
                    <input type="text" id="fullname" name="name">
                </div>
                <div class="form-group">
                    <label for="email">Email ID</label>
                    <input type="email" id="email" name="email">
                </div>
                <div class="form-group">
                    <label for="mobile">Mobile Number</label>
                    <input type="text" id="mobile" name="phone">
                </div>

                <div class="form-group">
                    <label for="password">Create Password</label>
                    <input type="password" id="password" name="password">
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword">
                </div>
                <div class="form-group">
                    <label for="aadhar">Aadhar Number</label>
                    <input type="text" id="aadhar" name="aadhar">
                </div>
                <button type="submit" class="register-btn">Register</button>
                <div class="login-link">
                    Already have an account? <a href="providerlogin.jsp">Login</a>
                </div>
            </form>
        </div>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String name = request.getParameter("name");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                String aadhar = request.getParameter("aadhar");
                String phone = request.getParameter("phone");

                if (name != null && password != null && email != null) {
                    try {

                        User p = new User(name, email, password, phone, aadhar);
                      
                        UserDAO pd = new UserDAO();
                        int n = pd.registerUser(p);
                        User provider = pd.getUserByEmailAndPassword(email, password);

                        if (n > 0) {
                            if (provider != null) {
                                // Set session attribute
                                session.setAttribute("provider", provider);
                                out.println("<script>alert('Registration successful! Redirecting to login...'); window.location.href='../../User/mainpageu.jsp';</script>");
                                return; // Important to stop further execution
                            }else{
                                out.println("<script>alert('Failed to create session..');</script>");
                                out.println("<script>alert('Registration successful! Redirecting to login...'); window.location.href='../../User/mainpageu.jsp';</script>");
                                return; // Important to stop further execution
                            }
                        } else {
                            out.println("<script>alert('Failed to create account. Try again.');</script>");
                        }
                    } catch (Exception ex) {
                        out.println("<span style='color:red;'>Error: " + ex.getMessage() + "</span>");
                    }
                }
            }
        %>

    </body>
</html>
