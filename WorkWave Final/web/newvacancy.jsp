<%-- 
    Document   : newvacancy
    Created on : Jul 19, 2024, 11:51:39 PM
    Author     : Nisal Ranasinghe
--%>
<%@ page session="true" %>
<%@page import="app.classes.Employer"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Job"%>
<%@page import="app.classes.jobN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        
        String empd=request.getParameter("empid");
        int employerId=Integer.parseInt(empd);
        String jobTitle = request.getParameter("job_title");
        String jobCategory = request.getParameter("job_category");
        String jobType = request.getParameter("job_type");
        String jobLocation = request.getParameter("job_location");
        String salaryStr = request.getParameter("salary");
        String jobDescription = request.getParameter("job_description");

        try {
        
            double salary = Double.parseDouble(salaryStr);
            
            jobN job = new jobN(employerId, jobTitle, jobCategory, jobType, jobLocation, salary, jobDescription);
            if (job.save()) {
                response.sendRedirect("newjob vacancy.jsp?s=1");
                session.setAttribute("s", "1");
            } else {
               response.sendRedirect("newjob vacancy.jsp?s=1");
               session.setAttribute("s", "1");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("newjob vacancy.jsp?s=0");
        }
    }
    
%>