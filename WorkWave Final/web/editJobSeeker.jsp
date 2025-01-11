<%-- 
    Document   : editJobSeeker
    Created on : Aug 10, 2024, 2:09:24 PM
    Author     : Ravindu
--%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    int userId = Integer.parseInt(request.getParameter("userid"));
    String firstName = request.getParameter("firstname");
    String lastName = request.getParameter("lastname");
    String userEmail = request.getParameter("email");
    String userPhone = request.getParameter("phone");
    String userCity = request.getParameter("city");
    
    User user = new User(userId, firstName, lastName, userEmail, userPhone, userCity);

    // Call the update method
    if(user.updatedetails(DbConnector.getConnection())) {
        session.setAttribute("u", "1");
        response.sendRedirect("jobseeker_home.jsp");
    } else {
        session.setAttribute("u", "0");
        response.sendRedirect("jobseeker_home.jsp");
}
%>