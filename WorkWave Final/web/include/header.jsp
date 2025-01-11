<%-- 
    Document   : header
    Created on : Aug 8, 2024, 12:48:08 PM
    Author     : Geeth
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
       <header id="header">
            <nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="container-fluid">
                     <a class="navbar-brand" href="index.jsp">
                        <img src="images/logobox.jpg" class="main-logo" alt="Logo" title="Logo" style="max-width: 250px; max-height: 40px;">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarScroll">
                        <ul class="navbar-nav ms-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
                           <li class="nav-item me-5">
                                <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                            </li>

                            <li class="nav-item dropdown me-5">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Services
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">Post Job Vacancies</a></li>
                                    <li><a class="dropdown-item" href="searchJob.jsp">Look for jobs</a></li>
                                </ul>
                            </li>
                            <li class="nav-item me-5">
                                <a class="nav-link" href="#">About us</a>
                            </li>
                            <li class="nav-item me-5">
                                <a class="nav-link " href="#">Contact</a>
                            </li>
                        </ul>
                        </ul>
                        <%
                            // Check if user is logged in
                            Integer userId = (Integer) session.getAttribute("userId");
                            if (userId != null) {
                                try {
                                    DbConnector connector = new DbConnector();
                                    Connection conn = connector.getConnection();
                                    String query = "SELECT firstname FROM user WHERE user_id = ?";
                                    PreparedStatement pstmt = conn.prepareStatement(query);
                                    pstmt.setInt(1, userId);
                                    ResultSet rs = pstmt.executeQuery();
                                    if (rs.next()) {
                                        String firstName = rs.getString("firstname");
                        %>
                        <a href="profile.jsp" class="btn btn-primary me-2">
                            <%= firstName %>
                        </a>
                        <%
                                    }
                                    rs.close();
                                    pstmt.close();
                                    conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                        <a href="loginJobSeeker.jsp" style="text-decoration: none">
                            <button class="btn btn-outline-primary me-5" type="submit">Login</button>
                        </a>
                    </div>
                </div>
            </nav>
        </header>
    </body>
</html>