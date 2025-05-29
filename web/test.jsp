<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>DB Connection Test</title>
</head>
<body>
    <h1>Testing Database Connection...</h1>
    <%
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pronest", "root", "root");
            if (con != null) {
                out.println("<p style='color:green;'>Connection Successful!</p>");
            } else {
                out.println("<p style='color:red;'>Connection Failed!</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (con != null) {
                try { con.close(); } catch (Exception e) { }
            }
        }
    %>
</body>
</html>
