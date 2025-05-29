<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

            .services{
                list-style: none;
                padding: 20px;
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
            <div class="logo">PRO-NEST</div>
            <div class="nav-right">
                <ul class="nav-links">
                    <li><a href="index.jsp">Home</a></li>
                    <li><button id="servicesBtn" class="text-button">Services</button></li>
                    <li><a href="aboutus.jsp">About</a></li>
                    <li><a href="contactus.jsp">Support</a></li>
                </ul>

                <div class="profile-icon" onclick="toggleinterfaces()">
                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">                   
                </div>
            </div>
        </nav>
        <!-- Popup Container -->
        <div id="servicesPopup" class="popup">
            <div class="popup-content">
                <span class="close">&times;</span>
<!--                <h2>Our Services</h2>-->
                <ul class="services" style="padding-left: 0px;">
                    <li><a href="./logincomponents/ulogin/userlogin.jsp">Home Cleaning</a></li>
                    <li><a href="./logincomponents/ulogin/userlogin.jsp">Nursing</a></li>
                    <li><a href="./logincomponents/ulogin/userlogin.jsp">Social Networking</a></li>
                    <li><a href="./logincomponents/ulogin/userlogin.jsp">Education</a></li>
                    <li><a href="./logincomponents/ulogin/userlogin.jsp">Electrician</a></li>
                    <li><a href="./logincomponents/ulogin/userlogin.jsp">Plumbing</a></li>
                    <li><a href="./logincomponents/ulogin/userlogin.jsp">Transportation</a></li>
                    <li><a href="./logincomponents/ulogin/userlogin.jsp">Appliance repair & service</a></li>
                </ul>
            </div>
        </div>

        <script>
            function toggleinterfaces() {
                // Change the URL to switch between two JSP pages
                window.location.href = "./logincomponents/ulogin/userlogin.jsp"
            }

            // Get elements
            var popup = document.getElementById("servicesPopup");
            var btn = document.getElementById("servicesBtn");
            var closeBtn = document.querySelector(".close");
            // Show Popup when clicking the button
            btn.onclick = function() {
                popup.style.display = "flex";
            }

            // Close Popup
            closeBtn.onclick = function() {
                popup.style.display = "none";
            }

            // Close when clicking outside
            window.onclick = function(event) {
                if (event.target == popup) {
                    popup.style.display = "none";
                }
            }

        </script>

    </body>

</html>



