<%@ page import="java.sql.*" %>
<%@ page import="app.classes.User" %>
<%@ page import="app.classes.Employer" %>
<%@ page import="app.classes.DbConnector" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registration Action</title>
    </head>
    <body>
        <%
            // Extract parameters from request
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String city = request.getParameter("city");
            String usertype = request.getParameter("usertype");
            String password = request.getParameter("password");
            String companyName = request.getParameter("companyName");
            int numberOfEmployees = Integer.parseInt(request.getParameter("numberOfEmployees"));
            String companyEmail = request.getParameter("companyEmail");
            String companyAddress = request.getParameter("companyAddress");
            String companyWebsite = request.getParameter("companyWebsite");
            String companyLogo = request.getParameter("companyLogo");

            Connection con = null;

            try {
                con = DbConnector.getConnection();

                // Create User object
                User user = new User(firstname, lastname, email, phone, city, usertype, password);
                int userId = user.register(con); // Register user and get userId

                if (userId > 0) { // If user registration was successful
                    // Create Employer object
                    Employer employer = new Employer(companyName, companyAddress, numberOfEmployees, companyEmail, companyWebsite, companyLogo);
                    if (employer.register(con, userId)) {
                        response.sendRedirect("loginJobSeeker.jsp");
                    } else {
                        response.sendRedirect("register.jsp");
                    }
                } else {
                    response.sendRedirect("register.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("register.jsp");
            } finally {
                try {
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>
