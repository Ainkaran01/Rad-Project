<%-- 
    Document   : logout
    Created on : Aug 6, 2024, 12:03:58 AM
    Author     : HP
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   
    if (session.getAttribute("userId") != null) {
        session.removeAttribute("userId");
        session.invalidate();
    }

  
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("userId".equals(cookie.getName()) || "usertype".equals(cookie.getName())) {
                cookie.setValue("");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
    }

    response.sendRedirect("index.jsp");
%>
