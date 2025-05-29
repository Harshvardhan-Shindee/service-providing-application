<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Provider" %>
<%@ page import="DAO.WorkRequestDAO" %>

<%
    Provider provider = (Provider) session.getAttribute("provider");
    if (provider == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/plogin/providerlogin.jsp");
        return;
    }

    //to show total earnig
    double totalEarnings = WorkRequestDAO.getTotalEarnings(provider.getProvider_id());
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Provider Dashboard - PRO-NEST</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <style>
            body {
                margin: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #f2f2f2;
            }

            .navbar {
                background-color: #333;
                color: white;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }

            .nav-right {
                display: flex;
                align-items: center;
                gap: 60px; /* space between nav and profile */
            }

            .nav-links {
                list-style: none;
                display: flex;
                gap: 25px;
                margin: 0;
                padding: 0;
            }

            .navbar .logo {
                font-size: 24px;
                font-weight: bold;
            }

            .navbar ul {
                list-style: none;
                display: flex;
                gap: 25px;
                margin: 0;
                margin-left: auto;
            }

            .navbar ul li a {
                color: white;
                text-decoration: none;
                font-size: 18px;
                transition: 0.3s;
            }

            .navbar ul li a:hover {
                color: #00cfff;
            }

            .profile-icon {
                position: relative;
                cursor: pointer;
            }

            .profile-icon img {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                border: 2px solid white;
            }

            .dropdown {
                position: absolute;
                top: 50px;
                right: 0;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.15);
                width: 150px;
                display: none;
                z-index: 100;
            }

            .dropdown a {
                display: block;
                padding: 10px 15px;
                color: #333;
                text-decoration: none;
                font-size: 14px;
            }

            .dropdown a:hover {
                background-color: #f0f0f0;
            }

            .services{
                list-style: none;
                gap: 15px;
            }
            .services li a {
                color: black;
                text-decoration: none;
            }
            .services a:hover {
                color:red;
            }

            /* Button styled as normal text */
            .text-button {
                background: none;
                border: none;
                font-size: 18px;
                color: inherit; /* Keeps the default text color */
                cursor: pointer;
                padding: 0;
                font-family: inherit; /* Keeps the default font */
            }

            /* Remove default button focus outline */
            .text-button:focus {
                outline: none;
            }

            /* Popup Container */
            .popup {
                display: none;
                position: fixed;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }

            /* Popup Content */
            .popup-content {
                background: white;
                padding: 20px;
                width: 300px;
                border-radius: 10px;
                //text-align: center;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }

            /* Close Button */
            .close {
                float: right;
                font-size: 24px;
                cursor: pointer;
            }



        </style>


    </head>
    <body>
        <nav class="navbar">
            <div class="logo">PRO-NEST | Provider Panel</div>
            <div class="nav-right">
                <ul class="nav-links">
                    <li><a href="mainpagep.jsp">Dashboard</a></li>
                    <li><a href="create_service.jsp">Create Service</a></li>
                    <li><a href="my_services.jsp">My Services</a></li>
                    <li><a href="completed_work.jsp">Completed Works</a></li>
                </ul>

                <div class="profile-icon" onclick="toggleDropdown()">
                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
                    <div class="dropdown" id="profileDropdown">                       
                        <a href="providerprofile.jsp">My Profile</a>                       
                        <a href="contactus.jsp">Help</a>
                        <a href="${pageContext.request.contextPath}/logincomponents/logout.jsp" style="color: red;">Logout</a>
                    </div>
                </div>
            </div>
        </nav>


        <script>
                    function toggleDropdown() {
                    const dropdown = document.getElementById('profileDropdown');
                            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
                    }

            window.onclick = function(event) {
            if (!event.target.matches('.profile-icon img')) {
            const dropdown = document.getElementById('profileDropdown');
                    if (dropdown && dropdown.style.display === 'block') {
            dropdown.style.display = 'none';
            }
            }
            }
        </script>

    </body>

</html>
