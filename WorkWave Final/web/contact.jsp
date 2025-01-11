<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Contact Us</title>
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/f14985d5db.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="Css/index.css">
         <link rel="stylesheet" href="Css/admin.css">
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="Css/contact.css"> <!-- Make sure to link your CSS file -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <!-----------Navbar--------->
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

        <div class="contact">
            <div class="contact-col">
                <h3>Send us a message <img src="images/msg.png" alt="" /></h3>
                <p>
                    In our Contact section, you can easily reach out to us with any inquiries, feedback, or support needs. Whether you have questions about using our Work Wave, need assistance with your account, or want to provide feedback to help us improve, we're here to help. Fill out the contact form with your details and message, and our dedicated support team will respond promptly. Your satisfaction is our priority, and we strive to provide excellent customer service. Thank you for choosing our Work Wave! We look forward to assisting you.
                </p>
                <ul>
                    <li><i class="fa fa-envelope" aria-hidden="true" style="margin-right: 20px; margin-top: 5px;"></i>info@workwave.com</li>
                    <li><i class="fa fa-phone-square" aria-hidden="true" style="margin-right: 20px; margin-top: 5px;"></i>+9475 5676234</li>
                    <li><i class="fa fa-map-marker" aria-hidden="true" style="margin-right: 20px; margin-top: 5px;"></i>43, Passara Road, Badulla<br> Sri Lanka 90000.
                </ul>
            </div>
            <div class="contact-col">
                <form action="process_contact.jsp" method="post">
                    <label>Your Name</label>
                    <input type="text" name="name" placeholder="Enter Your Name" required>
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="Enter Email Address" required>
                    <label>Write Your Message Here</label>
                    <textarea name="message" rows="6" placeholder="Enter Your Message" required></textarea>
                    <button type="submit" class="btn dark-btn">Submit Now <img src="path/to/arrow.png" alt="" /></button>
                </form>
                <span>
                    <%
                    String result = request.getParameter("result");
                    if (result != null) {
                        out.print(result);
                    }
                    %>
                </span>
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


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
