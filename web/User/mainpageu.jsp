<%@ page import="models.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pro-Nest</title>
    <link rel="stylesheet" href="../styles.css">
    <script type="text/javascript">
       window.history.forward()
    </script>
</head>
<body>

    <jsp:include page="headeru.jsp"/>

    <section class="hero" style="padding-bottom: 40px;">
        <h1>Find Trusted Professionals for Your Services</h1>
<!--        <input type="text" class="search-bar" placeholder="Search for services...">-->
    </section>

    <section class="services">
        <div class="service-card" onclick="window.location.href='housecleaning.jsp';" style="cursor: pointer;">
            <img src="../images/home_cleaning.jpg" alt="House Cleaning">
            <h3>House-Cleaning</h3>
        </div>
        <div class="service-card" onclick="window.location.href='nursing.jsp';" style="cursor: pointer;">
            <img src="../images/nursing.jpg" alt="Nursing">
            <h3>Nursing</h3>
        </div>
        <div class="service-card" onclick="window.location.href='socialnetworking.jsp';" style="cursor: pointer;">
            <img src="../images/social.jpg" alt="Social Networking Related">
            <h3>Social Networking </h3>
        </div>
        <div class="service-card" onclick="window.location.href='education.jsp';" style="cursor: pointer;">
            <img src="../images/education.jpg" alt="Education">
            <h3>Education</h3>
        </div>
    </section>
    <section class="services" onclick="window.location.href='electrician.jsp';" style="cursor: pointer;">
        <div class="service-card">
            <img src="../images/electrician.jpg" alt="Electrician" >
            <h3>Electrician</h3>
        </div>
        <div class="service-card" onclick="window.location.href='plumber.jsp';" style="cursor: pointer;">
            <img src="../images/plumber.jpg" alt="Plumber">
            <h3>Plumbing</h3>
        </div>
        <div class="service-card" onclick="window.location.href='transportation.jsp';" style="cursor: pointer;">
            <img src="../images/transportation.jpg" alt="Transportation">
            <h3>Transportation </h3>
        </div>
        <div class="service-card" onclick="window.location.href='appliancerepair.jsp';" style="cursor: pointer;">
            <img src="../images/appliancerepair.jpg" alt="Appliance repair & service">
            <h3>Appliance repair & service</h3>
        </div>
    </section>

    <jsp:include page="footeru.jsp"/>

</body>
</html>
