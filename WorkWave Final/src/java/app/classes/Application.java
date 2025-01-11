/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.classes;

/**
 *
 * @author Nisal Ranasinghe
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Application {

    private int applicationId;
    private String title;
    private String category;
    private String applicantName;
    private String applicantCv;
    private String action;
    private int employerID;

    public void setEmployerID(int employerID) {
        this.employerID = employerID;
    }

    public Application() {

    }

    public Application(int applicationId, String title, String category, String applicantName, String applicantCv, String action) {
        this.applicationId = applicationId;
        this.title = title;
        this.category = category;
        this.applicantName = applicantName;
        this.applicantCv = applicantCv;
        this.action = action;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public String getTitle() {
        return title;
    }

    public String getCategory() {
        return category;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public String getApplicantCv() {
        return applicantCv;
    }

    public String getAction() {
        return action;
    }

    public int getEmployerID() {
        return employerID;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public void setApplicantCv(String applicantCv) {
        this.applicantCv = applicantCv;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public List<Application> getApplication(Connection con) {
        List<Application> applications = new ArrayList<>();
        try {

            String query = "SELECT * FROM `application` WHERE employerid=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, employerID);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Application application = new Application(rs.getInt("application_id"), rs.getString("title"), rs.getString("category"), rs.getString("applicant_name"), rs.getString("applicant_cv"), rs.getString("action"));
                applications.add(application);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Application.class.getName()).log(Level.SEVERE, null, ex);
        }
        return applications;

    }

    public static Application getApplicationDetails(Connection conn, int jobId) {
        Application application = null;
        String query = "SELECT * FROM application WHERE job_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, jobId); // Ensure jobId is an integer
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                application = new Application(
                        rs.getInt("application_id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("applicant_name"),
                        rs.getString("applicant_cv"),
                        rs.getString("action")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exceptions
        }
        return application;
    }

    public boolean updateAction(Connection con) {
        try {
            String query = "UPDATE `application` SET `action`=? WHERE application_id=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, "Accepted");
            pstmt.setInt(2, this.applicationId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Application.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean updateActionr(Connection con) {
        try {
            String query = "UPDATE `application` SET `action`=? WHERE application_id=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, "Rejected");
            pstmt.setInt(2, this.applicationId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Application.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

}
