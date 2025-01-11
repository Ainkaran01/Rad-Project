<%@ page session="true" %>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Job"%>
<%@page import="app.classes.Employer"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="Css/admin.css">
        <link rel="stylesheet" type="text/css" href="Css/index.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/f14985d5db.js" crossorigin="anonymous"></script>
        <title>Job Details</title>
        <style>
            .img-fluid {
                max-width: 100%;
                height: 200px;
            }</style>
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
                                        if (session.getAttribute("userId") != null) {
                                            if (session.getAttribute("usertype").equals("employer")) {%>
                                    <li><a class="dropdown-item" href="newjob vacancy.jsp">Post Job Vacancies</a></li>
                                        <%      }
                                            }
                                        %>

                                    <li><a class="dropdown-item" href="#">Look for jobs</a></li>
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

        <div class="container mt-5">
            <%
                int jobId = Integer.parseInt(request.getParameter("jobId"));

                Job job = null;
                Employer employer = null;
                try {
                    Connection conn = DbConnector.getConnection();
                    job = Job.getJobDetails(conn, jobId);
                    if (job != null) {
                        employer = Employer.getEmployerDetails(conn, job.getEmployerId());

                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <div class="row">
                <div class="col-md-4">
                    <%
                        if (employer != null) {
                            out.println("<img src='./uploads/" + employer.getCompanyLogo() + "' class='img-fluid' alt='Company Logo'>");
                        }
                    %>
                </div>
                <div class="col-md-8">
                    <%
                        if (employer != null) {
                            out.println("<h3>" + employer.getCompanyName() + "</h3>");

                            out.println("<p><strong>Address:</strong> " + employer.getCompanyAddress() + "</p>");
                            out.println("<p><strong>Email:</strong> " + employer.getCompanyEmail() + "</p>");
                            out.println("<p><strong>Website:</strong> <a href='" + employer.getCompanyWebsite() + "'>" + employer.getCompanyWebsite() + "</a></p>");
                        }
                        if (job != null) {
                            out.println("<p><strong>Salary:</strong> Rs " + job.getSalary() + "</p>");
                        }
                    %>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-md-12">
                    <%
                        if (job != null) {
                            out.println("<h4>Job Description</h4>");
                            out.println("<p>" + job.getJobDescription() + "</p>");
                        }
                    %>
                </div>
            </div>
            <%
                // Check if the user is logged in and is a jobseeker
                if (session.getAttribute("userId") != null && "jobseeker".equals(session.getAttribute("usertype"))) {
            %>
            <form action="applyForJob.jsp" method="post" enctype="multipart/form-data">
                <input type="hidden" name="jobId" value="<%= request.getParameter("jobId")%>">
                <input type="hidden" name="employerId" value="<%=  employer.getEmployerId()%>">
                <input type="hidden" name="action" value="pending">

                <div class="mb-3">
                    <label for="cv" class="form-label">Upload CV</label>
                    <input class="form-control" type="file" id="cv" name="cv" required>
                </div>
                <button type="submit" class="btn btn-primary">Apply for Job</button>
            </form>
            <%
                } else {
                    // Optionally, you can add a message for non-logged in users or non-jobseekers
                    out.println("<p>Please <a href='loginJobSeeker.jsp' style='text-decoration: none' ><b>log in as a jobseeker</b></a> to apply for this job.</p>");
                }
            %>

            <input type="button" value="Back to Search Jobs" class="btn btn-info mt-2" onclick="window.location.href = 'searchJob.jsp';">
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

        <script>
            // JavaScript for Back to Top button
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

    </body>
</html>