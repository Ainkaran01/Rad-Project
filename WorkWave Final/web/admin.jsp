<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%@ page import="java.sql.*, app.classes.DbConnector, app.classes.AdminManager" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Admin Dashboard</title>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/f14985d5db.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="Css/index.css">
        <link rel="stylesheet" href="Css/admin.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
                            <% } else if (session.getAttribute("usertype").equals("admin")) {%>
                        <a href="admin.jsp" style="text-decoration: none">
                            <button class="btn btn-outline-primary me-5 btn-hover-fill" type="submit"> <span>Profile</span></button></a>
                            <%}
                            } else {%>

                        <a href="loginJobSeeker.jsp" style="text-decoration: none">
                            <button class="btn btn-outline-primary me-5 btn-hover-fill" type="submit"> <span>Login</span></button></a>


                        <%}%>
                        <a href="logout.jsp" style="text-decoration: none">
                            <button type="button" class="btn btn-outline-primary mb-2 text-start btn-hover-fill">
                                <span>Logout</span>
                            </button>
                        </a>

                    </div>
                </div>
            </nav>
        </header>



        <div class="container-fluid">
            <div class="row">
                <div class="d-flex w-100 justify-content-center align-items-center">
                    <img class="w-90" src="images/logowide.png" alt="Banner" />
                </div>
            </div>
        </div>

        <div class="container mt-5">
            <h1 class="text-center mb-4">Admin Dashboard</h1>

            <%
                // Handle disable/enable actions
                String action = request.getParameter("action");
                if (action != null) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    boolean success = false;
                    String message = "";

                    if (action.equals("toggleUser")) {
                        success = AdminManager.toggleUserStatus(id);
                        message = success ? "User status updated successfully." : "Failed to update user status.";
                    } else if (action.equals("toggleJob")) {
                        success = AdminManager.toggleJobStatus(id);
                        message = success ? "Job status updated successfully." : "Failed to update job status.";
                    }

                    if (!message.isEmpty()) {
                        out.println("<div class='alert alert-" + (success ? "success" : "danger") + " alert-dismissible fade show' role='alert'>");
                        out.println(message);
                        out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                        out.println("</div>");
                    }
                }
            %>

            <h2 class="mt-4 mb-3">Users</h2>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>User ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>City</th>
                            <th>User Type</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ResultSet rs = AdminManager.getAllUsers();
                            while (rs.next()) {
                                int userId = rs.getInt("user_id");
                                String userType = rs.getString("usertype");
                                String status = rs.getString("status");
                        %>
                        <tr>
                            <td><%= userId%></td>
                            <td><%= rs.getString("firstname")%></td>
                            <td><%= rs.getString("lastname")%></td>
                            <td><%= rs.getString("email")%></td>
                            <td><%= rs.getString("phone")%></td>
                            <td><%= rs.getString("city")%></td>
                            <td><%= userType%></td>
                            <td><%= status%></td>
                            <td>
                                <% if (!userType.equals("admin")) {%>
                                <form action="admin.jsp" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="toggleUser">
                                    <input type="hidden" name="id" value="<%= userId%>">
                                    <button type="submit" class="btn btn-sm <%= status.equals("active") ? "btn-danger" : "btn-success"%>">
                                        <%= status.equals("active") ? "Disable" : "Enable"%>
                                    </button>
                                </form>
                                <% } %>
                            </td>
                        </tr>
                        <%
                            }
                            rs.close();
                        %>
                    </tbody>
                </table>
            </div>

            <h2 class="mt-5 mb-3">Jobs</h2>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Job ID</th>
                            <th>Employer ID</th>
                            <th>Job Title</th>
                            <th>Category</th>
                            <th>Type</th>
                            <th>Location</th>
                            <th>Salary</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            rs = AdminManager.getAllJobs();
                            while (rs.next()) {
                                int jobId = rs.getInt("job_id");
                                String status = rs.getString("status");
                        %>
                        <tr>
                            <td><%= jobId%></td>
                            <td><%= rs.getInt("employer_id")%></td>
                            <td><%= rs.getString("job_title")%></td>
                            <td><%= rs.getString("job_category")%></td>
                            <td><%= rs.getString("job_type")%></td>
                            <td><%= rs.getString("job_location")%></td>
                            <td><%= rs.getDouble("salary")%></td>
                            <td><%= status%></td>
                            <td>
                                <form action="admin.jsp" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="toggleJob">
                                    <input type="hidden" name="id" value="<%= jobId%>">
                                    <button type="submit" class="btn btn-sm <%= status.equals("active") ? "btn-danger" : "btn-success"%>">
                                        <%= status.equals("active") ? "Disable" : "Enable"%>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                            rs.close();

                        %>
              </tbody>
              </table>
                 <h2>Contact Submissions</h2>
              <div class="d-flex justify-content-around flex-wrap mt-5">
                  <% 
               
                Connection conn = null;
                Statement stmt = null;
           

               
                    // Use DbConnector to get the connection
                    DbConnector db = new DbConnector();
                    conn = db.getConnection();
                    
                    stmt = conn.createStatement();
                    String query = "SELECT * FROM contact_submissions";
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String email = rs.getString("email");
                        String message = rs.getString("message");
                        Timestamp submittedAt = rs.getTimestamp("submitted_at");
            %>
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    Submission ID: <%= id %>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title"><%= name %></h5>
                                    <h6 class="card-subtitle mb-2 text-muted"><%= email %></h6>
                                    <p class="card-text"><%= message.replaceAll("\n", "<br>") %></p>
                                </div>
                                <div class="card-footer text-muted">
                                    Submitted on: <%= submittedAt %>
                                </div>
                            </div>
                        </div>
            <%
                    }
              
            %>
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
    </body>
</html>