<%@ page session="true" %>
<%@page import="app.classes.Employer"%>
<%@page import="jakarta.servlet.http.Part"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="app.classes.DbConnector"%>
<%@page import="app.classes.User"%>
<%@page import="app.classes.Job"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Job Application Status</title>
    </head>
    <body>
        <div class="container mt-5">
            <%
                Integer user_id = (Integer) session.getAttribute("userId");
                User user = new User(user_id);
                user.getDetails(DbConnector.getConnection());

                String message = "";
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String jobIdParam = request.getParameter("jobId");
                    String employerIdParam = request.getParameter("employerId");

                    if (jobIdParam == null || employerIdParam == null) {
                        message = "Required parameters are missing.";
                    } else {
                        Integer jobId = null;
                        Integer employerId = null;
                        try {
                            jobId = Integer.parseInt(jobIdParam);
                            employerId = Integer.parseInt(employerIdParam);
                        } catch (NumberFormatException e) {
                            message = "Invalid job or employer ID.";
                        }

                        if (jobId != null && employerId != null) {
                            Job job = Job.getJobDetails(DbConnector.getConnection(), jobId);
                            if (job != null) {
                                String title = job.getJobTitle();
                                String category = job.getJobCategory();
                                String applicantName = user.getLastname();
                                String action = request.getParameter("action");

                                InputStream inputStream = null;
                                Part filePart = request.getPart("cv");
                                if (filePart != null && filePart.getSize() > 0) {
                                    inputStream = filePart.getInputStream();
                                }

                                try {
                                    Connection conn = DbConnector.getConnection();
                                    String sql = "INSERT INTO application (job_id, employerid, title, category, applicant_name, action, applicant_cv) VALUES (?, ?, ?, ?, ?, ?, ?)";
                                    PreparedStatement statement = conn.prepareStatement(sql);
                                    statement.setInt(1, jobId);
                                    statement.setInt(2, employerId);
                                    statement.setString(3, title);
                                    statement.setString(4, category);
                                    statement.setString(5, applicantName);
                                    statement.setString(6, action);

                                    if (inputStream != null) {
                                        statement.setBlob(7, inputStream);
                                    }

                                    int row = statement.executeUpdate();
                                    if (row > 0) {
                                        message = "CV Submitted";
                                    } else {
                                        message = "Failed to Submit CV";
                                    }
                                } catch (SQLException ex) {
                                    message = "ERROR: " + ex.getMessage();
                                    ex.printStackTrace();
                                }
                            } else {
                                message = "Job not found.";
                            }
                        }
                    }
                }
            %>
            <h2><%= message %></h2>
            <a href="searchJob.jsp" class="btn btn-primary mt-3">Back to Search Job</a>
        </div>
    </body>
</html>
