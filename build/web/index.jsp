<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Company</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <jsp:include page="header.jsp"/>

    <section class="hero" style="padding-bottom: 40px;">
        <h1>Find Trusted Professionals for Your Services</h1>
<!--        <input type="text" class="search-bar" placeholder="Search for services...">-->
    </section>

    <section class="services">
        <div class="service-card" onclick="window.location.href='./logincomponents/ulogin/userlogin.jsp';" style="cursor: pointer;">
            <img src="./images/home_cleaning.jpg" alt="House Cleaning">
            <h3>House-Cleaning</h3>
        </div>
        <div class="service-card" onclick="window.location.href='./logincomponents/ulogin/userlogin.jsp';" style="cursor: pointer;">
            <img src="./images/nursing.jpg" alt="Nursing">
            <h3>Nursing</h3>
        </div>
        <div class="service-card" onclick="window.location.href='./logincomponents/ulogin/userlogin.jsp';" style="cursor: pointer;">
            <img src="./images/social.jpg" alt="Social Networking Related">
            <h3>Social Networking </h3>
        </div>
        <div class="service-card" onclick="window.location.href='./logincomponents/ulogin/userlogin.jsp';" style="cursor: pointer;">
            <img src="./images/education.jpg" alt="Education">
            <h3>Education</h3>
        </div>
    </section>
    <section class="services" onclick="window.location.href='./logincomponents/ulogin/userlogin.jsp';" style="cursor: pointer;">
        <div class="service-card">
            <img src="./images/electrician.jpg" alt="Electrician" >
            <h3>Electrician</h3>
        </div>
        <div class="service-card" onclick="window.location.href='./logincomponents/ulogin/userlogin.jsp';" style="cursor: pointer;">
            <img src="./images/plumber.jpg" alt="Plumber">
            <h3>Plumbing</h3>
        </div>
        <div class="service-card" onclick="window.location.href='./logincomponents/ulogin/userlogin.jsp';" style="cursor: pointer;">
            <img src="./images/transportation.jpg" alt="Transportation">
            <h3>Transportation </h3>
        </div>
        <div class="service-card" onclick="window.location.href='./logincomponents/ulogin/userlogin.jsp';" style="cursor: pointer;">
            <img src="./images/appliancerepair.jpg" alt="Appliance repair & service">
            <h3>Appliance repair & service</h3>
        </div>
    </section>

    <jsp:include page="footer.jsp"/>

</body>
</html>
