<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Admin Dashboard - PRO-NEST</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
        }

        .navbar {
            background-color: #333;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 40px;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 25px;
            margin: 0;
            padding: 0;
        }

        .nav-links li {
            position: relative;
        }

        .nav-links a,
        .nav-links button {
            color: white;
            text-decoration: none;
            font-size: 18px;
            background: none;
            border: none;
            font-family: inherit;
            cursor: pointer;
        }

        .nav-links a:hover,
        .nav-links button:hover {
            color: #00cfff;
        }

        /* Dropdown Content */
        .dropdown-content {
            display: none;
            position: absolute;
            top: 40px;
            left: 0;
            background-color: white;
            min-width: 180px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            border-radius: 8px;
            z-index: 999;
        }

        .dropdown-content a {
            color: black;
            padding: 10px 16px;
            display: block;
            text-decoration: none;
        }

        .dropdown-content a:hover {
            background-color: #f0f0f0;
        }

        /* Profile Icon */
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

        /* Profile Dropdown */
        .profile-dropdown {
            display: none;
            position: absolute;
            right: 0;
            top: 50px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            border-radius: 8px;
            z-index: 999;
            width: 150px;
        }

        .profile-dropdown a {
            display: block;
            padding: 10px 15px;
            text-decoration: none;
            color: black;
        }

        .profile-dropdown a:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>

    <nav class="navbar">
        <div class="logo">PRO-NEST Admin</div>
        <div class="nav-right">
            <ul class="nav-links">
                <li><a href="mainpageadmin.jsp">Dashboard</a></li>
                <li><a href="users.jsp">Users</a></li>
                <li><a href="providers.jsp">Providers</a></li>

                <li>
                    <button onclick="toggleDropdown('workDropdown')">Work Requests</button>
                    <div id="workDropdown" class="dropdown-content">
                        <a href="pending_works.jsp">Pending Requests</a>
                        <a href="completed_works.jsp">Completed Requests</a>
                    </div>
                </li>

            </ul>

            <div class="profile-icon" onclick="toggleDropdown('profileDropdown')">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
                <div id="profileDropdown" class="profile-dropdown">
                    <a href="admin_logout.jsp" style="color: red;">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <script>
        function toggleDropdown(id) {
            // Hide all other dropdowns
            document.querySelectorAll('.dropdown-content, .profile-dropdown').forEach(d => {
                if (d.id !== id) d.style.display = 'none';
            });

            const dropdown = document.getElementById(id);
            dropdown.style.display = (dropdown.style.display === 'block') ? 'none' : 'block';
        }

        // Close dropdowns when clicking outside
        window.onclick = function(event) {
            if (!event.target.closest('.profile-icon') && !event.target.closest('li')) {
                document.querySelectorAll('.dropdown-content, .profile-dropdown').forEach(d => {
                    d.style.display = 'none';
                });
            }
        }
    </script>

</body>
</html>
