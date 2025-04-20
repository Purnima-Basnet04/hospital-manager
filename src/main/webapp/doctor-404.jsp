<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - LifeCare Medical Center</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #1a73e8;
            --primary-light: #e8f0fe;
            --secondary: #34a853;
            --accent: #fbbc05;
            --warning: #ea4335;
            --header-green: #006400;
            --white: #ffffff;
            --light-gray: #f8f9fa;
            --text-dark: #202124;
            --text-medium: #5f6368;
        }
        
        body {
            font-family: 'Roboto', 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--light-gray);
            color: var(--text-dark);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .top-header {
            background-color: var(--header-green);
            height: 4px;
            width: 100%;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 20px;
            text-align: center;
        }
        
        .title {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 20px;
        }
        
        .message {
            font-size: 16px;
            color: var(--text-medium);
            margin-bottom: 30px;
        }
        
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            margin: 10px;
            transition: all 0.2s;
        }
        
        .btn:hover {
            background-color: #1967d2;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <!-- Green Header Bar -->
    <div class="top-header"></div>
    
    <div class="container">
        <h1 class="title">Doctor Dashboard</h1>
        <p class="message">Please click the button below to access the doctor dashboard.</p>
        
        <a href="doctor/dashboard.jsp" class="btn">Go to Doctor Dashboard</a>
    </div>
</body>
</html>
