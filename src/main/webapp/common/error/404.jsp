<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found | LifeCare Medical Center</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .error-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            text-align: center;
        }
        
        .error-icon {
            font-size: 80px;
            color: #3498db;
            margin-bottom: 20px;
        }
        
        .error-code {
            font-size: 120px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 20px;
            line-height: 1;
        }
        
        .error-title {
            font-size: 32px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 15px;
        }
        
        .error-message {
            font-size: 18px;
            color: #7f8c8d;
            max-width: 600px;
            margin-bottom: 30px;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 30px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin: 0 10px 10px 0;
        }
        
        .btn:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        
        .btn.secondary {
            background-color: transparent;
            border: 2px solid #3498db;
            color: #3498db;
        }
        
        .btn.secondary:hover {
            background-color: rgba(52, 152, 219, 0.1);
        }
        
        .search-form {
            max-width: 500px;
            width: 100%;
            margin: 0 auto 30px;
            position: relative;
        }
        
        .search-input {
            width: 100%;
            padding: 15px 20px;
            border: 1px solid #ddd;
            border-radius: 50px;
            font-size: 16px;
            outline: none;
            transition: all 0.3s ease;
        }
        
        .search-input:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        .search-btn {
            position: absolute;
            right: 5px;
            top: 5px;
            bottom: 5px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 50px;
            padding: 0 20px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .search-btn:hover {
            background-color: #2980b9;
        }
        
        .helpful-links {
            margin-top: 40px;
            max-width: 600px;
            width: 100%;
        }
        
        .helpful-links h3 {
            font-size: 20px;
            color: #2c3e50;
            margin-bottom: 15px;
            text-align: center;
        }
        
        .links-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }
        
        .link-item {
            background-color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            text-decoration: none;
            color: #2c3e50;
            font-weight: 500;
            display: flex;
            align-items: center;
            width: calc(50% - 15px);
            max-width: 250px;
        }
        
        .link-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            color: #3498db;
        }
        
        .link-item i {
            margin-right: 10px;
            color: #3498db;
        }
        
        footer {
            background-color: white;
            padding: 20px;
            text-align: center;
            color: #7f8c8d;
            font-size: 14px;
            border-top: 1px solid #eee;
        }
        
        @media (max-width: 768px) {
            .error-code {
                font-size: 100px;
            }
            
            .error-title {
                font-size: 28px;
            }
            
            .error-message {
                font-size: 16px;
            }
            
            .link-item {
                width: 100%;
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-search error-icon"></i>
        <div class="error-code">404</div>
        <h1 class="error-title">Page Not Found</h1>
        <p class="error-message">
            The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.
        </p>
        
        <form class="search-form" action="../search.jsp" method="get">
            <input type="text" class="search-input" name="q" placeholder="Search for pages, services, or information...">
            <button type="submit" class="search-btn">Search</button>
        </form>
        
        <div class="btn-group">
            <a href="../../common/index.jsp" class="btn">Go to Homepage</a>
            <a href="javascript:history.back()" class="btn secondary">Go Back</a>
        </div>
        
        <div class="helpful-links">
            <h3>You might be looking for:</h3>
            <div class="links-grid">
                <a href="../../common/services.jsp" class="link-item">
                    <i class="fas fa-stethoscope"></i>
                    <span>Our Services</span>
                </a>
                <a href="../../doctor/list.jsp" class="link-item">
                    <i class="fas fa-user-md"></i>
                    <span>Our Doctors</span>
                </a>
                <a href="../../common/departments.jsp" class="link-item">
                    <i class="fas fa-hospital"></i>
                    <span>Departments</span>
                </a>
                <a href="../../appointment/book.jsp" class="link-item">
                    <i class="fas fa-calendar-check"></i>
                    <span>Book Appointment</span>
                </a>
            </div>
        </div>
    </div>
    
    <footer>
        &copy; <%= new java.util.Date().getYear() + 1900 %> LifeCare Medical Center. All rights reserved.
    </footer>
</body>
</html>
