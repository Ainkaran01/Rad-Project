<%@ page import="java.sql.*" %>
<%@ page import="app.classes.User" %>
<%@ page import="app.classes.DbConnector" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String city = request.getParameter("city");
        String usertype = request.getParameter("usertype");
        String password = request.getParameter("password");

        Connection con = null;

        try {
            if (firstname == null || lastname == null || email == null || password == null) {
                throw new IllegalArgumentException("Required fields are missing.");
            }

            con = DbConnector.getConnection();
            User user = new User(firstname, lastname, email, phone, city, usertype, password);

            int userId = user.register(con);

            if (userId > 0) {
                response.sendRedirect("loginJobSeeker.jsp");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
