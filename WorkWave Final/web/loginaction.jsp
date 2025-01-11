<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="app.classes.User" %>
<%@ page import="app.classes.DbConnector" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String usertype = request.getParameter("usertype");
    String rememberme = request.getParameter("rememberme");

    if (email != null && password != null && usertype != null) {
        User user = new User(email, password, usertype);
        
        if (user.authenticate(DbConnector.getConnection())) {
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("usertype", user.getUsertype());

            if ("on".equals(rememberme)) { 
                Cookie userIdCookie = new Cookie("userId", String.valueOf(user.getUserId()));
                Cookie usertypeCookie = new Cookie("usertype", usertype);

                userIdCookie.setMaxAge(60*60*24*7); 
                usertypeCookie.setMaxAge(60*60*24*7);

                userIdCookie.setHttpOnly(true);
                usertypeCookie.setHttpOnly(true);
                userIdCookie.setSecure(request.isSecure());
                usertypeCookie.setSecure(request.isSecure());

                response.addCookie(userIdCookie);
                response.addCookie(usertypeCookie);
            }

            if ("jobseeker".equals(user.getUsertype())) {
                response.sendRedirect("jobseeker_home.jsp");
            } else if ("employer".equals(user.getUsertype())) {
                response.sendRedirect("employer_home.jsp");
            } else if ("admin".equals(user.getUsertype())) {
                response.sendRedirect("admin.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    } else {
        response.sendRedirect("login.jsp?error=missing");
    }
%>
