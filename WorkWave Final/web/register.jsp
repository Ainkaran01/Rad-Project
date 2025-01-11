<%-- 
    Document   : register
    Created on : Jun 28, 2024, 9:55:32 PM
    Author     : Geeth
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Css/main.css">
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
        <%-- register form --%>
        <div class="container-fluid d-flex justify-content-center" style="margin-top:4rem;">
            <form class="row g-3 col-md-7 p-2" action="registrationaction.jsp" method="post"  id="registrationForm" >
                <h3 class="text-center">Register Form</h3>
                <div class="col-md-6">
                    <label for="inputFirstname" class="form-label">Firstname</label>
                    <input type="text" class="form-control" name="firstname" id="inputFirstname" placeholder="Nisal" required>
                </div>
                <div class="col-md-6">
                    <label for="inputLastname" class="form-label">Lastname</label>
                    <input type="text" class="form-control" name="lastname" id="inputLastname" placeholder="Ranasinghe" required>
                </div>
                <div class="col-md-6">
                    <label for="inputEmail" class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" id="inputEmail" placeholder="Nisalranasinghe@gmail.com" required>
                </div>
                <div class="col-md-6">
                    <label for="inputPhone" class="form-label">Phone No</label>
                    <input type="tel" class="form-control" name="phone" id="inputPhone" placeholder="07XXXXXXXXXX" required>
                </div>
                <div class="col-md-6">
                    <label for="inputCity" class="form-label">City</label>
                    <input type="text" class="form-control" name="city" id="inputCity" placeholder="Aluthgama" required>
                </div>
                <div class="col-md-6">
                    <label for="inputUserType" class="form-label">Usertype</label>
                    <select id="inputUserType" name="usertype" class="form-select" onchange="toggleEmployerFields()">
                        <option value="" selected>Choose...</option>
                        <option value="jobseeker">Job Seeker</option>
                        <option value="employer">Employer</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="inputPassword" class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" id="inputPassword" required>
                </div>
                <div class="col-md-6">
                    <label for="inputRepeatPassword" class="form-label">Repeat Password</label>
                    <input type="password" class="form-control" id="inputRepeatPassword" required>
                </div>

                <%-- Additional fields for Employers --%>
                <div id="employerFields" class="row g-3 col-md-7 p-2 d-none"style="width: auto">
                    <div class="col-md-6">
                        <label for="companyName" class="form-label">Company Name</label>
                        <input type="text" class="form-control" name="companyName" id="companyName" placeholder="Company Name">
                    </div>
                    <div class="col-md-6">
                        <label for="numberOfEmployees" class="form-label">Number of Employees</label>
                        <input type="number" class="form-control" name="numberOfEmployees" id="numberOfEmployees" placeholder="Number of Employees">
                    </div>
                    <div class="col-md-6">
                        <label for="companyEmail" class="form-label">Company Email</label>
                        <input type="email" class="form-control" name="companyEmail" id="companyEmail" placeholder="Company Email">
                    </div>
                    <div class="col-md-6">
                        <label for="companyAddress" class="form-label">Company Address</label>
                        <input type="text" class="form-control" name="companyAddress" id="companyAddress" placeholder="Company Address">
                    </div>
                    <div class="col-md-6">
                        <label for="companyWebsite" class="form-label">Company Website</label>
                        <input type="url" class="form-control" name="companyWebsite" id="companyWebsite" placeholder="Company Website">
                    </div>
                    <div class="col-md-6">
                        <label for="companyLogo" class="form-label">Company Logo</label>
                        <input type="file" class="form-control" name="companyLogo" id="companyLogo" accept="image/*">
                    </div>
                </div>

                <div class="col-12">
                    <button type="submit" class="btn btn-outline-primary sign-in">Sign in</button>
                </div>
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                        function toggleEmployerFields() {
                            var userType = document.getElementById("inputUserType").value;
                            var employerFields = document.getElementById("employerFields");
                            var registrationForm = document.getElementById("registrationForm");
                            if (userType === "employer") {
                                employerFields.classList.remove("d-none");
                                registrationForm.action = "registrationactionemployer.jsp";
                            } else {
                                employerFields.classList.add("d-none");
                                registrationForm.action = "registrationaction.jsp";
                            }
                        }
                        document.getElementById('registrationForm').addEventListener('submit', function (event) {
                            var password = document.getElementById('inputPassword').value;
                            var repeatPassword = document.getElementById('inputRepeatPassword').value;

                            if (password !== repeatPassword) {
                                alert('Passwords do not match.');
                                event.preventDefault(); // Prevent form submission
                            }
                        });
        </script>
    </body>
</html>
