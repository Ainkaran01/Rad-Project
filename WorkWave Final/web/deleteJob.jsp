<%-- 
    Document   : deleteJob
    Created on : Jul 20, 2024, 1:34:49 AM
    Author     : Nisal Ranasinghe
--%>

<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Job"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    int jobId = Integer.parseInt(request.getParameter("jobId"));
    Job job = new Job();
    job.setJobId(jobId);
    if (job.deleteJob(DbConnector.getConnection())) {
        response.sendRedirect("employer_home.jsp");
        session.setAttribute("d", "1");
    } else {
        response.sendRedirect("employer_home.jsp");
        session.setAttribute("d", "0");
    }

%>
