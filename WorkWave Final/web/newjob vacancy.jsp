<%-- 
    Document   : newjob vacancy
    Created on : Jul 19, 2024, 9:54:32 PM
    Author     : Nisal Ranasinghe
--%>

<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Employer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<!Doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Post Your Vacancy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="Css/admin.css">
        <link rel="stylesheet" type="text/css" href="Css/index.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/f14985d5db.js" crossorigin="anonymous"></script>

    </head>
    <body >
        <%
        if(session.getAttribute("userId")== null){
            response.sendRedirect("loginJobSeeker.jsp");
        }
        %>
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
        <%
            if (session.getAttribute("userId") != null) {
                Integer user_id = (Integer) session.getAttribute("userId");
                Employer emp = new Employer(user_id);
                emp.getemployerdetails(DbConnector.getConnection());
                int employerId = emp.getEmployerId();

             %>

        <div class="container mt-5">
            <h2 class="text-center">Post Your New Vacancy</h2>
            <%      if (session.getAttribute("s") != null) {
                    String message;
                    if (session.getAttribute("s").equals("1")) {
                        message = "<h5 class='text-success'>New Job Add successfully.</h5>";
                    } else {
                        message = "<h5 class='text-danger'>Error occurred. Please try again.</h5>";
                    }
                    out.println(message);
                    session.removeAttribute("s");
                }

            %>
            <form class="row g-3  mx-auto mt-2" action="newvacancy.jsp" method="post"><!--form-->
                

                <div class="col-md-12">
                    <input type="hidden" name="empid" value="<%= employerId %>">
                    <input type="text" class="form-control" id="" placeholder="Vacancy Title" name="job_title" required>
                </div>
                <div class="col-md-6">
                    <select id="" class="form-select" name="job_category" required>
                        <option>Job Category</option>
                        <option value="Software Development">Software Development</option>
                        <option value="Human Resources">Human Resources</option>
                        <option value="Customer Service">Customer Service</option>
                        <option value="Sales">Sales</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <input type="text" class="form-control" id="" placeholder="Location" name="job_location" required>
                </div>
                <div class="col-md-6">
                    <select id="" class="form-select" name="job_type" required>
                        <option>Job Type</option>
                        <option value="Full-Time">Full-Time</option>
                        <option value="Part-Time">Part-Time</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <input type="text" class="form-control" id="" placeholder="Month Salary :" name="salary" required>
                </div>
                <div class="col-md-12">
                    <div class="form-floating">
                        <textarea class="form-control" placeholder="Leave a comment here" id="" name="job_description" style="height:70px"></textarea>
                        <label for="">Job Description</label>
                    </div>
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-outline-primary w-100">Submit</button>
                </div>
            </form>
        </div>
    
      <footer id="footer">

            <div class="container-fluid" >
                <div class="row" >
                    <div class="col-sm-3" style="margin-top: 20px;">
                        <a href="index.jsp">
                            <img src="images/logoboxbr.png" alt="Logo" title="Logo" class="main-logo">
                        </a>
                        <div class="footer_inner">
                            <p class="w-90">"Welcome to WorkWave,Join us today and shape your Life!" 
                            </p>
                        </div>
                    </div>
                    <div class="col-sm-2 mx-auto" style="margin-top: 20px;">
                        <h5>Important Links</h5>
                        <div class="footer_inner">
                            <ul class="list-unstyled footer-links">
                                <li><a href="aboutUs.jsp">About Us</a></li>
                                <li><a href="contact.jsp">Contact Us</a></li>
                                <li><a href="termsAndConditions.jsp">Terms & Conditions</a></li>


                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-3" style="margin-top: 20px;">
                        <h5>Contact Us</h5>
                        <div class="footer_inner">
                            <div class="d-flex media">
                                <i class="fa fa-map-marker me-4" aria-hidden="true"></i>
                                <div class="media-body"><p> <span class="f_rubik ">  43,</span> Passara Road, Badulla <br> Sri Lanka <span>90000</span> </p></div>
                            </div>
                            <div class="d-flex media">
                                <i class="fa-solid fa-envelope me-3"></i>
                                <div class="media-body"><p>info@workwave.com</p></div>
                            </div>
                            <div class="d-flex media">
                                <i class="fa fa-phone me-4" aria-hidden="true"></i>
                                <div class="media-body"><p class="f_rubik ">+9475 5676234</p></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4" style="margin-top: 20px;">
                        <h5>Join our Newsletter</h5>
                        <div class="footer_inner">
                            <form action="">
                                <div class="input-group">
                                    <input type="email" class="form-control" placeholder="Enter your email">
                                    <button class="btn btn-primary" type="submit"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
                                </div>
                            </form>
                            <div class="footer_inner">
                                <ul class="list-inline social-icons">
                                    <li class="list-inline-item"><a href="#"><i class="fa fa-facebook"></i></a></li>
                                    <li class="list-inline-item"><a href="#"><i class="fa fa-twitter"></i></a></li>
                                    <li class="list-inline-item"><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                    <li class="list-inline-item"><a href="#"><i class="fa fa-instagram"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
 <button id="back-to-top" title="Back to top">↑</button>
        </footer>
       <%} %>
        <script>

            var btn = document.getElementById('back-to-top');
            window.onscroll = function () {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    btn.style.display = "block";
                } else {
                    btn.style.display = "none";
                }
            };

            btn.onclick = function () {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
            };
        </script>
</html>
