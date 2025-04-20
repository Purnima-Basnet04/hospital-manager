# Hospital Management System - Web Application Structure

This document outlines the organization of JSP files in the Hospital Management System web application.

## Directory Structure

The web application is organized into the following directories:

### User Role-Based Directories

- **admin/** - Admin-specific pages
  - dashboard.jsp - Admin dashboard
  - (other admin-specific pages)

- **doctor/** - Doctor-specific pages
  - dashboard.jsp - Doctor dashboard
  - profile.jsp - Doctor profile page
  - public-profile.jsp - Public doctor profile
  - list.jsp - List of doctors
  - consultation.jsp - Doctor consultation page
  - (other doctor-specific pages)

- **patient/** - Patient-specific pages
  - dashboard.jsp - Patient dashboard
  - profile.jsp - Patient profile page
  - appointments.jsp - Patient appointments
  - book-appointment.jsp - Book appointment page
  - schedule-appointment.jsp - Schedule appointment page
  - medical-record-form.jsp - Medical record form
  - (other patient-specific pages)

### Functionality-Based Directories

- **auth/** - Authentication-related pages
  - login.jsp - Login page
  - login-handler.jsp - Login processing
  - register.jsp - Registration page
  - register-handler.jsp - Registration processing
  - logout.jsp - Logout page
  - login-simple.jsp - Simple login page (alternative)
  - register-attractive.jsp - Alternative registration page
  - register-new.jsp - New registration page

- **common/** - Common pages
  - index.jsp - Home page
  - home.jsp - Alternative home page
  - about-us.jsp - About us page
  - contact-us.jsp - Contact us page
  - services.jsp - Services page
  - departments.jsp - Departments page
  - department-services.jsp - Department services page
  - profile.jsp - Generic profile page

- **appointment/** - Appointment-related pages
  - list.jsp - List of appointments
  - book.jsp - Book appointment
  - schedule.jsp - Schedule appointment
  - online.jsp - Online appointment

- **medical/** - Medical-related pages
  - record-form.jsp - Medical record form
  - consultation.jsp - Consultation page

- **dashboard/** - Dashboard templates
  - admin-new.jsp - New admin dashboard
  - admin-simple.jsp - Simple admin dashboard
  - doctor-new.jsp - New doctor dashboard
  - doctor-simple.jsp - Simple doctor dashboard
  - patient-new.jsp - New patient dashboard
  - patient-simple.jsp - Simple patient dashboard

- **test/** - Test pages
  - test-page.jsp - Test page
  - redirect-test.jsp - Redirect test page

## Root Directory Files

- **index.jsp** - Main entry point (redirects to common/index.jsp)
- **index-redirect.jsp** - Alternative redirect to common/index.jsp
- **index-new.jsp** - New index page

## Navigation

When navigating between pages, use the following conventions:

1. For links within the same directory, use relative paths:
   ```html
   <a href="profile.jsp">Profile</a>
   ```

2. For links to pages in other directories, use paths relative to the current directory:
   ```html
   <a href="../common/index.jsp">Home</a>
   ```

3. For links to static resources (CSS, JS, images), use paths relative to the webapp root:
   ```html
   <link rel="stylesheet" href="../styles/main.css">
   ```

## Authentication Flow

1. Users access the login page at `/auth/login.jsp`
2. After successful authentication, they are redirected to their role-specific dashboard:
   - Admins: `/admin/dashboard.jsp`
   - Doctors: `/doctor/dashboard.jsp`
   - Patients: `/patient/dashboard.jsp`
