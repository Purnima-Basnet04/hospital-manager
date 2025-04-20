//package filter;
//
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//import java.util.Arrays;
//import java.util.List;
//
//@WebFilter("/*")
//public class AuthenticationFilter implements Filter {
//
//    // List of pages that don't require authentication
//    private static final List<String> PUBLIC_PAGES = Arrays.asList(
//        "/login.jsp",
//        "/register.jsp",
//        "/index.jsp",
//        "/about-us.jsp",
//        "/contact-us.jsp",
//        "/login-handler.jsp",
//        "/RegisterServlet",
//        "/departments.jsp",
//        "/appointments.jsp",
//        "/services.jsp",
//        "/view-department.jsp",
//        "/view-service.jsp",
//        "/book-appointment.jsp",
//        "/styles/",
//        "/js/",
//        "/images/",
//        "/favicon.ico"
//    );
//
//    @Override
//    public void init(FilterConfig filterConfig) throws ServletException {
//        // Initialization code if needed
//    }
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        HttpServletResponse httpResponse = (HttpServletResponse) response;
//        HttpSession session = httpRequest.getSession(false);
//
//        String requestURI = httpRequest.getRequestURI();
//        String contextPath = httpRequest.getContextPath();
//        String relativePath = requestURI.substring(contextPath.length());
//
//        boolean isPublicPage = true;
//        for (String publicPage : PUBLIC_PAGES) {
//            if (relativePath.startsWith(publicPage)) {
//                isPublicPage = true;
//                break;
//            }
//            else {
//                isPublicPage = false;
//            }
//        }
//
//        boolean isLoggedIn = (session != null && session.getAttribute("username") != null);
//
//        if (isPublicPage || isLoggedIn) {
//            // User is either accessing a public page or is logged in
//            chain.doFilter(request, response);
//        } else {
//            // User is not logged in and trying to access a protected page
//            httpResponse.sendRedirect(contextPath + "/login.jsp?error=session");
//        }
//    }
//
//    @Override
//    public void destroy() {
//        // Cleanup code if needed
//    }
//}
