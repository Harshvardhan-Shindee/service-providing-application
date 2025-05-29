<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/logincomponents/ulogin/userlogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>User Dashboard - PRO-NEST</title>
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
                gap: 60px;
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

            .services {
                list-style: none;
                padding: 20;
                margin: 0;
            }

            .services li a {
                color: black;
                text-decoration: none;
            }

            .services li a:hover {
                color: red;
            }

            .text-button {
                background: none;
                border: none;
                font-size: 18px;
                color: inherit;
                cursor: pointer;
                padding: 0;
                font-family: inherit;
            }

            .text-button:focus {
                outline: none;
            }

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

            .popup-content {
                background: white;
                padding: 20px;
                width: 300px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }

            .close {
                float: right;
                font-size: 24px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>

        <nav class="navbar">
            <div class="logo">PRO-NEST</div>
            <div class="nav-right">
                <ul class="nav-links">
                    <li><a href="mainpageu.jsp">Home</a></li>
                    <li><button id="servicesBtn" class="text-button">Services</button></li>
                    <li><a href="my_booking.jsp">My Bookings</a></li>
                    <li><a href="aboutus.jsp">About</a></li>
                </ul>

                <div class="profile-icon" onclick="toggleDropdown()">
                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
                    <div class="dropdown" id="dropdown">
                        <a href="userprofile.jsp">My Profile</a>
                        <a href="contactus.jsp">Help</a>
                        <a href="${pageContext.request.contextPath}/logincomponents/logout.jsp" style="color: red;">Logout</a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Services Popup -->
        <div class="popup" id="servicesPopup">
            <div class="popup-content">
                <span class="close" onclick="closePopup()">&times;</span>
                <ul class="services">
                    <li><a href="housecleaning.jsp">House Cleaning</a></li>
                    <li><a href="nursing.jsp">Nursing</a></li>
                    <li><a href="socialnetworking.jsp">Social Networking</a></li>
                    <li><a href="education.jsp">Education</a></li>
                    <li><a href="electrician.jsp">Electrician</a></li>
                    <li><a href="plumber.jsp">Plumbing</a></li>
                    <li><a href="transportation.jsp">Transportation</a></li>
                    <li><a href="appliancerepair.jsp">Appliance repair & service</a></li>
                </ul>
            </div>
        </div>

        <script>
            
             window.history.forward();
             
                    function toggleDropdown() {
                    const dropdown = document.getElementById("dropdown");
                            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
                    }

            document.getElementById("servicesBtn").addEventListener("click", function () {
            document.getElementById("servicesPopup").style.display = "flex";
            });
                    function closePopup() {
                    document.getElementById("servicesPopup").style.display = "none";
                    }

            window.addEventListener("click", function (event) {
            const dropdown = document.getElementById("dropdown");
                    const profileIcon = document.querySelector(".profile-icon");
                    if (!profileIcon.contains(event.target)) {
            dropdown.style.display = "none";
            }
            });
        </script>

    </body>
</html>
