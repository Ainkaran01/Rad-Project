<%-- 
    Document   : loginJobSeeker
    Created on : Jun 28, 2024, 10:28:43 PM
    Author     : Geeth
--%>
<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" type="text/css" href="Css/main.css">
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
                                    <%
                                    if(session.getAttribute("userId")!=null){
                                        if(session.getAttribute("usertype").equals("employer")){%>
                                             <li><a class="dropdown-item" href="newjob vacancy.jsp">Post Job Vacancies</a></li>
                                  <%      }
                                    }
                                    %>
                                   
                                             <li><a class="dropdown-item" href="searchJob.jsp">Look for jobs</a></li>
                                </ul>
                            </li>
           
                            <li class="nav-item me-5">
                                <a class="nav-link " href="contact.jsp">Contact</a>
                            </li>
                        </ul>
                        <%
                            if (session.getAttribute("userId") != null) {
                                if (session.getAttribute("usertype").equals("employer")) {%>
                        <a href="employer_home.jsp" style="text-decoration: none">
                            <button class="btn btn-outline-primary me-5 btn-hover-fill" type="submit"> <span>Profile</span></button></a>
                            <% } else if (session.getAttribute("usertype").equals("jobseeker")) {%>
                        <a href="jobseeker_home.jsp" style="text-decoration: none">
                            <button class="btn btn-outline-primary me-5 btn-hover-fill" type="submit"> <span>Profile</span></button></a>
                            <%}
                            } else {%>

                        <a href="loginJobSeeker.jsp" style="text-decoration: none">
                            <button class="btn btn-outline-primary me-5 btn-hover-fill" type="submit"> <span>Login</span></button></a>
                            <%}%>
                    </div>
                </div>
            </nav>
        </header>
        <%-- login form --%>
        <div class="container-fluid d-flex justify-content-center  align-items-center"style="height:80vh;">
            <div class="row col-sm-8 col-md-4 ">
                <img  src="images/logowide.png" alt="Banner" />
                <form action="loginaction.jsp" method="post">
                    <h3 class="text-center">Login</h3>
                    <div class="mb-3"> 
                        <input type="hidden" name="usertype" value="jobseeker"> 
                        <label for="exampleInputEmail1" class="form-label">Email address</label>
                        <div class="input-group">
                            <input type="email" class="form-control" name="email" id="exampleInputEmail1" aria-describedby="emailHelp">
                            <span class="input-group-text" id="basic-addon3"><i class="fa fa-user"></i></span>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" name="password" id="exampleInputPassword1">
                            <span class="input-group-text" id="basic-addon1"><i class="fa fa-lock"></i></span>
                        </div>
                       
                    </div>
                    <input type="checkbox"  name="rememberme" id="rememberme">
                    <label for="rememberme" class="form-label">Remember Me</label>
                    <div class="mb-3 reg">
                        <a href="forgetPassword.jsp">ForgetPassword</a> |
                        <a href="register.jsp">Register now</a>
                    </div>
                    
                    <button type="submit" class="btn btn-outline-primary mt-2"style="width:100%;">Submit</button>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

