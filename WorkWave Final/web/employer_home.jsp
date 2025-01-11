<%@ page session="true" %>
<%@page import="app.classes.Application"%>
<%@page import="java.util.jar.Attributes.Name"%>
<%@page import="app.classes.Employer"%>
<%@page import="java.util.List"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.Job"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Employer Page</title>
        <link rel="stylesheet" href="Css/admin.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/f14985d5db.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="Css/index.css">
    </head>
    <style>
        button.btn.btn-outline-primary.mb-2.text-start.btn-hover-fill {
    width: -webkit-fill-available;
}
    </style>
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
                  <%
                       Integer user_id = (Integer) session.getAttribute("userId");
                                
                         Employer emp = new Employer(user_id);
                        emp.getemployerdetails(DbConnector.getConnection());
                        if (emp != null) {
                            out.println("<img src='./uploads/" + emp.getCompanyLogo() + "' class='img-fluid' alt='Company Logo'>");
                        }
                  %><!--image-->
                </div>
                <div class="button-set d-flex flex-column">
                    <button type="button" class="btn btn-outline-primary my-2 text-start btn-hover-fill" id="vacancies-btn" onclick="showpostedvacancies()">
                        <span>My Vacancies</span>
                    </button>
                    <button type="button" class="btn btn-outline-primary mb-2 text-start my-2 btn-hover-fill" id="profile-btn" style="display: none;" onclick="showporifile()">
                        <span>Profile</span>
                    </button>
                    <button type="button" class="btn btn-outline-primary mb-2 text-start btn-hover-fill" id="application-btn" onclick="showapplication()">
                        <span>Received Application</span>
                    </button>
                    <a href="logout.jsp">
                        <button type="button" class="btn btn-outline-primary mb-2 text-start btn-hover-fill">
                            <span>Logout</span>
                        </button>
                    </a>

                </div>
            </div>
            <div class="col-md-9 p-2 p-lg-4">

                <div class="company-details mt-2" id="company-details"><!--company details-->
                    <form class="row g-3" action="edit.jsp" method="post"><!--form-->
                        <div class="col-12 d-flex justify-content-between mb-2 flex-column flex-lg-row ">
                            <div class="col-md-7">
                                <h3>Company Details</h3>
                            </div>
                            <div class="button-set d-inline d-lg-flex justify-content-around col-md-4">
                                <button type="button" class="btn btn-outline-primary text-start btn-hover-fill" style="--bs-btn-padding-x: 1rem;" id="edit" onclick="change()">
                                    <span>Edit</span>
                                </button>
                                <button type="submit" class="btn btn-outline-primary btn-hover-fill" style="--bs-btn-padding-x: 1rem;display: none;" id="save" onclick="changesave()">
                                    <span>Save</span>
                                </button>
                                <a href="newjob vacancy.jsp">
                                    <button type="button" class="btn btn-outline-primary btn-hover-fill" id="Create" style="--bs-btn-padding-y: .5rem;">
                                        <span>Create New Vacancies</span>
                                    </button>
                                </a>
                            </div>
                        </div>
                        <%
                            if (session.getAttribute("userId") != null) {
                              emp.getemployerdetails(DbConnector.getConnection());

                        %>
                        <input type="hidden" name="userid" value="<%= user_id%>">
                        <input type="hidden" name="empid" value="<%= emp.getEmployerId()%>">

                        <% if (session.getAttribute("u") != null) {
                                String messag;
                                if (session.getAttribute("u").equals("1")) {
                                    messag = "<h5 class='text-success'>Company Details Update successfully.</h5>";
                                } else {
                                    messag = "<h5 class='text-danger'>Error occurred. Please try again.</h5>";
                                }%>
                        <div class="col-md-12">
                            <% out.println(messag);
                                session.removeAttribute("u");%>
                        </div>


                        <% }%>

                        <div class="col-md-6">
                            <label for="" class="form-label">Name</label>
                            <input type="text" class="form-control" id="inputna" name="ename" value="<%= emp.getCompanyName()%>" required disabled >
                        </div>
                        <div class="col-md-6">
                            <label for="" class="form-label">Address</label>
                            <input type="text" class="form-control" id="inputa" name="eaddress"  value="<%= emp.getCompanyAddress()%>"required disabled >
                        </div>

                        <div class="col-md-6">
                            <label for="" class="form-label">Website</label>
                            <input type="url" class="form-control" id="inputu" name="ewebsite" value="<%= emp.getCompanyWebsite()%>" required disabled >
                        </div>
                        <div class="col-md-6">
                            <label for="" class="form-label">No of Employees</label>
                            <input type="number" class="form-control" name="eno"  value="<%= emp.getNumberOfEmployees()%>" id="inputnu" required disabled >
                        </div>
                        <div class="col-md-6">
                            <label for="" class="form-label">Email</label>
                            <input type="email" class="form-control"  name="eemail" value="<%= emp.getCompanyEmail()%>" id="inpute" required disabled >
                        </div>


                    </form>
                </div>
                <div class="posted-vacancies mt2" id="posted-vacancies" style="display: none;"><!--posted vacancies-->
                    <% if (session.getAttribute("d") != null) {
                            String message;
                            if (session.getAttribute("d").equals("1")) {
                                message = "<h5 class='text-success'>Job Delete successfully.</h5>";
                            } else {
                                message = "<h5 class='text-danger'>Error occurred. Please try again.</h5>";
                            }
                            out.println(message);
                            session.removeAttribute("d");
                        }%>
                    <div class="col-12 d-flex justify-content-between mb-3 flex-column flex-lg-row ">
                        <div class="col-md-7">
                            <h3>Posted Vacancies</h3>
                        </div>
                        <div class="button-set d-inline d-lg-flex justify-content-around col-md-4">
                            <a href="newjob vacancy.jsp"><button type="button" class="btn btn-outline-primary" id="Create" style="--bs-btn-padding-y: .5rem;">Create New
                                    Vacancies</button></a>
                        </div>
                    </div>

                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Post Id</th>
                                <th scope="col">Title</th>
                                <th scope="col">Category</th>
                                <th scope="col">Location</th>
                                <th scope="col">Type</th>
                                <th scope="col">Salary</th>
                                <th scope="col">Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%

                                int employerId = emp.getEmployerId();
                                Job job = new Job();
                                job.setEmployerId(employerId);
                                List<Job> jobs = job.getJobListCompany(DbConnector.getConnection());
                                for (Job j : jobs) {%>
                            <tr>
                                <td><%=j.getJobId()%></td>
                                <td><%=j.getJobTitle()%></td>
                                <td><%=j.getJobCategory()%></td>
                                <td><%=j.getJobLocation()%></td>
                                <td><%=j.getJobType()%></td>
                                <td><%=j.getSalary()%></td>
                                <td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal" data-jobid="<%=j.getJobId()%>">Delete</button></td>
                            </tr>
                            <%}
                            %>

                        </tbody>
                    </table>
                    <!-- Modal -->
                    <div class="modal fade " id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="deleteModalLabel">Confirm Deletion</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    Are you sure you want to delete this job?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <form id="deleteForm" method="post" action="deleteJob.jsp">
                                        <input type="hidden" name="jobId" id="deleteJobId">
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="application mt2" id="application" style="display: none;"><!-- received application-->
                    <div class="col-12 d-flex justify-content-between mb-3 flex-column flex-lg-row ">
                        <h3>Received Application</h3>    
                    </div>
                    <div class="col-12">
                        <%
                            if (request.getParameter("u") != null) {
                                String msg;
                                if (request.getParameter("u").equals("1")) {
                                    msg = "<h5 class='text-success'>Application Update successfully.</h5>";
                                } else {
                                    msg = "<h5 class='text-danger'>Error occurred. Please try again.</h5>";
                                }
                                out.println(msg);
                            }
                        %>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Application Id</th>
                                    <th scope="col">Title</th>
                                    <th scope="col">Category</th>
                                    <th scope="col">Applicant name</th>
                                    <th scope="col">Accept/Reject</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Application app = new Application();
                                    app.setEmployerID(employerId);
                                    List<Application> appls = app.getApplication(DbConnector.getConnection());
                                    for (Application a : appls) {
                                %>
                                <tr>
                                    <td><%= a.getApplicationId()%></td>
                                    <td><%= a.getTitle()%></td>
                                    <td><%= a.getCategory()%></td>
                                    <td><%= a.getApplicantName()%></td>
                                    <td>
                                        <%
                                            String status = a.getAction();
                                        %>
                                        <%
                                            if (status.equals("pending")) {
                                        %>
                                        <button type="button" class="btn btn-outline-primary rounded-pill fixed-size-button" data-bs-toggle="modal" data-bs-target="#exampleModal" data-appid="<%= a.getApplicationId()%>">Pending</button>
                                        <%
                                        } else if (status.equals("Accepted")) {
                                        %>
                                        <button type="button" class="btn btn-success rounded-pill fixed-size-button"style="cursor: context-menu;"><%= status%> </button>
                                        <%
                                        } else {
                                        %>
                                        <button type="button" class="btn btn-danger rounded-pill fixed-size-button"style="cursor: context-menu;"><%= status%> </button>
                                        <%
                                            }
                                        %>

                                    </td>
                                </tr>

                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Application Action</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            Are you sure you want to accept or reject this application?
                                        </div>
                                        <div class="modal-footer">
                                            <form id="acceptForm" action="update.jsp" method="post">
                                                <input type="hidden" name="appid" id="acceptAppId">
                                                <button type="submit" class="btn btn-outline-success">Accept</button>
                                            </form>
                                            <form id="rejectForm" action="updater.jsp" method="post">
                                                <input type="hidden" name="appid" id="rejectAppId">
                                                <button type="submit" class="btn btn-outline-warning">Reject</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%}
                                } else {
                                    response.sendRedirect("index.jsp");
                                }%>
                            </tbody>
                        </table>

                    </div>
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
            var deleteModal = document.getElementById('deleteModal');
            deleteModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var jobId = button.getAttribute('data-jobid');
                var deleteJobId = deleteModal.querySelector('#deleteJobId');
                deleteJobId.value = jobId;
            });
            var exampleModal = document.getElementById('exampleModal');
            exampleModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var appId = button.getAttribute('data-appid');
                var acceptAppId = exampleModal.querySelector('#acceptAppId');
                var rejectAppId = exampleModal.querySelector('#rejectAppId');

                acceptAppId.value = appId;
                rejectAppId.value = appId;
            });
        </script>
        <script>
            function change() {

                document.getElementById('edit').style.display = "none";
                document.getElementById('save').style.display = "inline-block";
                document.getElementById('inputna').disabled = false;
                document.getElementById('inputa').disabled = false;
                document.getElementById('inputu').disabled = false;
                document.getElementById('inputnu').disabled = false;
                document.getElementById('inpute').disabled = false;

            }

            function showpostedvacancies() {
                document.getElementById('company-details').style.display = "none";
                document.getElementById('posted-vacancies').style.display = "block";
                document.getElementById('profile-btn').style.display = "block";
                document.getElementById('vacancies-btn').style.display = "none";
                document.getElementById('application').style.display = "none";
                document.getElementById('company-details').style.display = "none";
                document.getElementById('posted-vacancies').style.display = "block";
                document.getElementById('profile-btn').style.display = "block";
                document.getElementById('vacancies-btn').style.display = "none";
                document.getElementById('application').style.display = "none";
                document.getElementById('edit').style.display = "inline-block";
                document.getElementById('save').style.display = "none";
                document.getElementById('inputna').disabled = true;
                document.getElementById('inputa').disabled = true;
                document.getElementById('inputc').disabled = true;
                document.getElementById('inputu').disabled = true;
                document.getElementById('inputnu').disabled = true;
                document.getElementById('inpute').disabled = true;
            }
            function showporifile() {
                document.getElementById('company-details').style.display = "block";
                document.getElementById('posted-vacancies').style.display = "none";
                document.getElementById('profile-btn').style.display = "none";
                document.getElementById('vacancies-btn').style.display = "block";
                document.getElementById('application').style.display = "none";

            }
            function showapplication() {
                document.getElementById('application').style.display = "block";
                document.getElementById('company-details').style.display = "none";
                document.getElementById('posted-vacancies').style.display = "none";
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>

</html>
