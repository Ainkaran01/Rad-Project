<%@ page import="java.sql.*" %>
<%@ page import="app.classes.DbConnector" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String message = request.getParameter("message");
String result = "";

// Simple email validation
if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
    result = "Invalid email format";
} else {
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Use your existing DbConnector class to get a database connection
        DbConnector db = new DbConnector();
        conn = db.getConnection();

        // Insert data into the database
        String sql = "INSERT INTO contact_submissions (name, email, message) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, message);

        int rows = stmt.executeUpdate();

        if (rows > 0) {
            result = "Message sent successfully!";
        } else {
            result = "Failed to send message.";
        }

    } catch (Exception e) {
        e.printStackTrace();
        result = "Error: " + e.getMessage();
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
}

// Redirect back to the contact page with the result message
response.sendRedirect("contact.jsp?result=" + java.net.URLEncoder.encode(result, "UTF-8"));
%>
