<%-- 
    Document   : jobseeker_home
    Created on : Jul 20, 2024, 4:57:39 PM
    Author     : HP
--%>

<%@page session="true" %>
<%@page import="app.classes.User"%>
<%@page import="java.util.*"%>
<%@page import="app.classes.Employer"%>
<%@page import="app.classes.DbConnector"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="app.classes.Job" %>
<%@ page import="app.classes.Application" %>
<%@ page import="app.classes.DbConnector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Job Seeker Page</title>
        <link rel="stylesheet" href="Css/admin.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/f14985d5db.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="Css/index.css">
        <style>
            button.btn.btn-outline-primary.mb-2.text-start.btn-hover-fill {
                width: -webkit-fill-available;
            }

        </style>
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

        <div class="container d-flex mt-5 rounded-2 py-3 border-2 flex-column flex-lg-row company">
            <div class="col-md-3 d-flex flex-column p-1">
                <div class="image">
                    <img src="images/user.png" alt="" class="object-fit-cover border rounded" style="width: 100%; aspect-ratio: 1/1;">
                </div>
                <div class="button-set d-flex flex-column">
                    <button type="button" class="btn btn-outline-primary mb-2 text-start btn-hover-fill my-2" id="applied-jobs-btn" onclick="showAppliedJobs()">
                        <span>Applied Jobs</span>
                    </button>
                    <button type="button" class="btn btn-outline-primary mb-2 text-start btn-hover-fill my-2" id="profile-btn" style="display: none;" onclick="showProfile()">
                        <span>Profile</span>
                    </button>
                    <button type="button" class="btn btn-outline-primary mb-2 text-start btn-hover-fill my-2" id="approved-jobs-btn" onclick="showApprovedJobs()">
                        <span>Approved Jobs</span>
                    </button>
                </div>
                <a href="logout.jsp">
                    <button type="button" class="btn btn-outline-primary mb-2 text-start btn-hover-fill my-2">
                        <span>Logout</span>
                    </button>
                </a>
            </div>
            <div class="col-md-9 p-2 p-lg-4">
                <div class="jobseeker-details mt-2" id="jobseeker-details">
                    <form class="row g-3" method="post" action="editJobSeeker.jsp">
                        <div class="col-12 d-flex justify-content-between mb-2 flex-column flex-lg-row">
                            <div class="col-md-7">
                                <h3>Job Seeker Details</h3>
                            </div>
                            <div class="button-set d-inline d-lg-flex justify-content-around col-md-4">
                                <button type="button" class="btn btn-outline-primary" style="--bs-btn-padding-x: 1rem;" id="edit" onclick="change()">Edit</button>
                                <button type="submit" class="btn btn-outline-primary" style="--bs-btn-padding-x: 1rem; display: none;" id="save" onclick="changesave()">Save</button>
                                <a href="searchJob.jsp">
                                    <button type="button" class="btn btn-outline-primary" id="Create" style="--bs-btn-padding-y: .5rem;">Find Your Jobs</button>
                                </a>
                            </div>
                        </div>

                        <%
                        Integer userId = (Integer) session.getAttribute("userId");

                        if (userId != null) {
                            User u = new User(userId); 
                            u = u.getDetails(DbConnector.getConnection()); 
                            if (u == null) {
                                out.println("<h5 class='text-danger'>Error: Jobseeker details not found.</h5>");
                        } else {
                        %>


                        <input type="hidden" name="userid" value="<%= userId %>">


                        <% if (session.getAttribute("u") != null) {
                            String messag;
                            if (session.getAttribute("u").equals("1")) {
                                messag = "<h5 class='text-success'>Jobseeker Details Update successfully.</h5>";
                            } else {
                                messag = "<h5 class='text-danger'>Error occurred. Please try again.</h5>";
                            }%>
                        <div class="col-md-12">
                            <% out.println(messag);
                                session.removeAttribute("u");%>
                        </div>


                        <% }%>

                        <div class="col-md-6">
                            <label for="inputfna" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="inputfna" name="firstname" value="<%= u.getFirstname() %>" disabled>
                        </div> 
                        <div class="col-md-6">
                            <label for="inputlna" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="inputlna" name="lastname" value="<%= u.getLastname() %>" disabled>
                        </div>
                        <div class="col-md-6">
                            <label for="inputa" class="form-label">Email</label>
                            <input type="email" class="form-control" id="inputa" name="email" value="<%= u.getEmail() %>" disabled>
                        </div>
                        <div class="col-md-6">
                            <label for="inputu" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="inputu" name="phone" value="<%= u.getPhone() %>" disabled>
                        </div>
                        <div class="col-md-6">
                            <label for="inputnu" class="form-label">City</label>
                            <input type="text" class="form-control" name="city" value="<%= u.getCity() %>" id="inputnu" disabled>
                        </div>

                        <%
                                }
                            } else {
                                out.println("<h5 class='text-danger'>Error: Job Seeker ID not found in session.</h5>");
                            }
                        %>

                        <%
             User user = new User(userId);
             user.getDetails(DbConnector.getConnection());
             String applicantName = user.getLastname(); 
             Connection conn = DbConnector.getConnection();
    
            
             String appliedJobsQuery = "SELECT job_id FROM application WHERE applicant_name = ?";
             String approvedJobsQuery = "SELECT job_id FROM application WHERE applicant_name = ? AND action = 'Accepted'";
    
         
             PreparedStatement appliedJobsStmt = conn.prepareStatement(appliedJobsQuery);
             appliedJobsStmt.setString(1, applicantName);
             ResultSet appliedJobsRs = appliedJobsStmt.executeQuery();
             List<Application> appliedApplications = new ArrayList<>();

             while (appliedJobsRs.next()) {
                 int jobId = appliedJobsRs.getInt("job_id");
                 Application app = Application.getApplicationDetails(conn, jobId); 
                 if (app != null) {
                     appliedApplications.add(app);
                 }
             }
    
             PreparedStatement approvedJobsStmt = conn.prepareStatement(approvedJobsQuery);
             approvedJobsStmt.setString(1, applicantName);
             ResultSet approvedJobsRs = approvedJobsStmt.executeQuery();
             List<Application> approvedApplications = new ArrayList<>();

             while (approvedJobsRs.next()) {
                 int jobId = approvedJobsRs.getInt("job_id");
                 Application app = Application.getApplicationDetails(conn, jobId); 
                 if (app != null) {
                     approvedApplications.add(app);
                 }
             }
                        %>

                        <div id="applied-jobs-section" class="mt-4" style="display:none;">
                            <h4>Applied Jobs</h4>
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>

                                        <th>Job Title</th>
                                        <th>Job Category</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Application app : appliedApplications) { %>
                                    <tr>

                                        <td><%= app.getTitle() %></td>
                                        <td><%= app.getCategory() %></td>
                                        <td><%= app.getAction() %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>

                        <div id="approved-jobs-section" class="mt-4" style="display:none;">
                            <h4>Approved Jobs</h4>
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>

                                        <th>Job Title</th>
                                        <th>Job Category</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Application app : approvedApplications) { %>
                                    <tr>

                                        <td><%= app.getTitle() %></td>
                                        <td><%= app.getCategory() %></td>
                                        <td><%= app.getAction() %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>

            </div>

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

        <script>
            function showAppliedJobs() {
                document.getElementById('applied-jobs-section').style.display = "block";
                document.getElementById('approved-jobs-section').style.display = "none";

            }

            function showApprovedJobs() {
                document.getElementById('approved-jobs-section').style.display = "block";
                document.getElementById('applied-jobs-section').style.display = "none";
            }
            function change() {

                document.getElementById('edit').style.display = "none";
                document.getElementById('save').style.display = "inline-block";
                document.getElementById('inputfna').disabled = false;
                document.getElementById('inputlna').disabled = false;
                document.getElementById('inputa').disabled = false;
                document.getElementById('inputu').disabled = false;
                document.getElementById('inputnu').disabled = false;


            }
            function changesave() {

                document.getElementById('edit').style.display = "block";
                document.getElementById('save').style.display = "none";
            }

        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>

</html>