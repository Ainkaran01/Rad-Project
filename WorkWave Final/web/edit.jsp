<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Employer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int empid = Integer.parseInt(request.getParameter("empid"));
    String em_name = request.getParameter("ename");
    String em_address = request.getParameter("eaddress");
    String em_website = request.getParameter("ewebsite");
    int em_noemploye = Integer.parseInt(request.getParameter("eno"));
    String em_email = request.getParameter("eemail");

    
    Employer emp = new Employer(empid, em_name, em_address, em_website, em_noemploye, em_email);

    if(emp.updatedetails(DbConnector.getConnection())) {
        session.setAttribute("u", "1");
        response.sendRedirect("employer_home.jsp");
    } else {
        session.setAttribute("u", "0");
        response.sendRedirect("employer_home.jsp");
    }
%>
