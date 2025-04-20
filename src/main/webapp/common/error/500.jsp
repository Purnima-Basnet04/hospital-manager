<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Server Error | LifeCare Medical Center</title>
    
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
            color: #e74c3c;
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
        
        .error-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
            max-width: 800px;
            width: 100%;
            text-align: left;
            border: 1px solid #e1e4e8;
        }
        
        .error-details h3 {
            font-size: 18px;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .error-details pre {
            background-color: #f1f2f6;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            font-family: monospace;
            font-size: 14px;
            color: #e74c3c;
            margin-bottom: 15px;
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
        <i class="fas fa-exclamation-triangle error-icon"></i>
        <div class="error-code">500</div>
        <h1 class="error-title">Server Error</h1>
        <p class="error-message">
            Sorry, something went wrong on our servers. We're working to fix the issue as soon as possible.
        </p>
        
        <div class="btn-group">
            <a href="../../common/index.jsp" class="btn">Go to Homepage</a>
            <a href="javascript:history.back()" class="btn secondary">Go Back</a>
        </div>
        
        <% if (exception != null) { %>
        <div class="error-details">
            <h3>Error Details (Visible only in development mode)</h3>
            <pre><%= exception.getMessage() %></pre>
            <p>Please contact the system administrator with the above error message and the time this occurred.</p>
        </div>
        <% } %>
        
        <div class="helpful-links">
            <h3>You might want to:</h3>
            <div class="links-grid">
                <a href="../../common/index.jsp" class="link-item">
                    <i class="fas fa-home"></i>
                    <span>Go to Home</span>
                </a>
                <a href="../../common/contact-us.jsp" class="link-item">
                    <i class="fas fa-envelope"></i>
                    <span>Contact Support</span>
                </a>
                <a href="../../auth/login.jsp" class="link-item">
                    <i class="fas fa-sign-in-alt"></i>
                    <span>Login Again</span>
                </a>
                <a href="../../common/services.jsp" class="link-item">
                    <i class="fas fa-stethoscope"></i>
                    <span>Our Services</span>
                </a>
            </div>
        </div>
    </div>
    
    <footer>
        &copy; <%= new java.util.Date().getYear() + 1900 %> LifeCare Medical Center. All rights reserved.
    </footer>
</body>
</html>
