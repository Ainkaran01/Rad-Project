/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Geeth
 */
public class jobN {

    private int employerId;
    private String jobTitle;
    private String jobCategory;
    private String jobType;
    private String jobLocation;
    private double salary;
    private String jobDescription;

    public jobN() {
    }

    public jobN(int employerId, String jobTitle, String jobCategory, String jobType, String jobLocation, double salary, String jobDescription) {
        this.employerId = employerId;
        this.jobTitle = jobTitle;
        this.jobCategory = jobCategory;
        this.jobType = jobType;
        this.jobLocation = jobLocation;
        this.salary = salary;
        this.jobDescription = jobDescription;
    }
    
    
    
    public int getEmployerId() {
        return employerId;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getJobCategory() {
        return jobCategory;
    }

    public void setJobCategory(String jobCategory) {
        this.jobCategory = jobCategory;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getJobLocation() {
        return jobLocation;
    }

    public void setJobLocation(String jobLocation) {
        this.jobLocation = jobLocation;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public String getJobDescription() {
        return jobDescription;
    }

    public void setJobDescription(String jobDescription) {
        this.jobDescription = jobDescription;
    }

    public boolean save() {
        try (Connection con = DbConnector.getConnection()) {
            String query = "INSERT INTO jobs (employer_id, job_title, job_category, job_type, job_location, salary, job_description) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, employerId);
            ps.setString(2, jobTitle);
            ps.setString(3, jobCategory);
            ps.setString(4, jobType);
            ps.setString(5, jobLocation);
            ps.setDouble(6, salary);
            ps.setString(7, jobDescription);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }
}
