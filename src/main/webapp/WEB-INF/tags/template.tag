<%@ tag description="Overall Page template" pageEncoding="UTF-8" %>
<%@ attribute name="title" required="true" rtexprvalue="true" %>
<%@ attribute name="additionalCSS" fragment="true" required="false" %>
<%@ attribute name="additionalJS" fragment="true" required="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">
    
    <!-- Page-specific CSS -->
    <link rel="stylesheet" type="text/css" href="styles/${pageContext.request.servletPath.substring(1).replace(".jsp", "")}.css">
    
    <!-- Additional CSS if provided -->
    <jsp:invoke fragment="additionalCSS"/>
</head>
<body>
    <header>
        <div class="header-content">
            <div class="logo-container">
                <div class="logo">
                    <img src="images/hospital-logo.svg" alt="LifeCare Medical Center Logo">
                </div>
                <h1>LifeCare Medical Center</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="departments.jsp">Departments</a></li>
                    <li><a href="services.jsp">Services</a></li>
                    <li><a href="about-us.jsp">About Us</a></li>
                    <li><a href="contact-us.jsp">Contact</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="register.jsp">Register</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <jsp:doBody/>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>LifeCare Medical Center</h3>
                <p>Providing exceptional healthcare with compassion and excellence since 2000.</p>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="departments.jsp">Departments</a></li>
                    <li><a href="services.jsp">Services</a></li>
                    <li><a href="about-us.jsp">About Us</a></li>
                    <li><a href="contact-us.jsp">Contact</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p><i class="fas fa-map-marker-alt"></i> 123 Medical Center Drive, Healthcare City, HC 12345</p>
                <p><i class="fas fa-phone"></i> (123) 456-7890</p>
                <p><i class="fas fa-envelope"></i> info@lifecaremedical.com</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2023 LifeCare Medical Center. All rights reserved.</p>
        </div>
    </footer>

    <!-- Common JavaScript -->
    <script src="js/common.js"></script>
    
    <!-- Page-specific JavaScript -->
    <script src="js/${pageContext.request.servletPath.substring(1).replace(".jsp", "")}.js"></script>
    
    <!-- Additional JavaScript if provided -->
    <jsp:invoke fragment="additionalJS"/>
</body>
</html>
