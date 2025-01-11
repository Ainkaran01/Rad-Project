<%-- 
    Document   : sendResetLink
    Created on : Jul 22, 2024, 10:45:44 PM
    Author     : HP
--%>

<%@page import="java.sql.*"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.MD5"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String email = request.getParameter("email");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    if (newPassword.equals(confirmPassword)) {
        Connection con = null;
        try {
            // Get database connection from DbConnector
            DbConnector dbConnector = new DbConnector();
            con = dbConnector.getConnection();

            // Hash the new password using MD5
            String hashedPassword = MD5.getMd5(newPassword);

            // Update the password
            String sql = "UPDATE user SET password = ? WHERE email = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, hashedPassword); // Use MD5 hashed password
            stmt.setString(2, email);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                out.println("Password has been reset successfully.");
                response.sendRedirect("loginJobSeeker.jsp");
            } else {
                out.println("Email not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            // Close the connection
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    } else {
        out.println("Passwords do not match.");
    }
%>
