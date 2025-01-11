<%-- 
    Document   : update
    Created on : Jul 27, 2024, 12:48:50 PM
    Author     : Nisal Ranasinghe
--%>

<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Application"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

int appId=Integer.parseInt(request.getParameter("appid"));
Application app=new Application();
app.setApplicationId(appId);
if(app.updateAction(DbConnector.getConnection())){
    response.sendRedirect("employer_home.jsp?u=1");
}
else{
    response.sendRedirect("employer_home.jsp?u=0");
}



%>
