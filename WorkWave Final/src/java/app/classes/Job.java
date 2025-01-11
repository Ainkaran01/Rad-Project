
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class Job {
    private int jobId;
    private int employerId;
    private String jobTitle;
    private String jobCategory;
    private String jobType;
    private String jobLocation;
    private double salary;
    private String jobDescription;

    public Job() {
    }

    public Job(int jobId,int employerId, String jobTitle, String jobCategory, String jobType, String jobLocation, double salary, String jobDescription) {
        this.jobId = jobId;
        this.employerId = employerId;
        this.jobTitle = jobTitle;
        this.jobCategory = jobCategory;
        this.jobType = jobType;
        this.jobLocation = jobLocation;
        this.salary = salary;
        this.jobDescription = jobDescription;
    }
    public Job(String jobTitle, String jobCategory, String jobType, String jobLocation, double salary, String jobDescription, int jobid) {
        this.jobTitle = jobTitle;
        this.jobCategory = jobCategory;
        this.jobType = jobType;
        this.jobLocation = jobLocation;
        this.salary = salary;
        this.jobDescription = jobDescription;
        this.jobId = jobid;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public int getJobId() {
        return jobId;
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


public List<Job> getJobList(Connection conn, String search) {
        List<Job> JobList = new ArrayList<>();
        String query;
        if (search.equals("")) {
            query = "SELECT * FROM jobs;";
        } else {
            query = "SELECT * FROM jobs WHERE LOWER(job_title) LIKE ? OR LOWER(job_category) LIKE ? OR job_type LIKE ? OR job_location LIKE ?;";
        }
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            if (!search.equals("")) {
                search = '%' + search + '%';
                pstmt.setString(1, search);
                pstmt.setString(2, search);
                pstmt.setString(3, search);
                pstmt.setString(4, search);
            }
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Job job = new Job(
                        rs.getInt("job_id"),
                        rs.getInt("employer_id"),
                        rs.getString("job_title"),
                        rs.getString("job_category"),
                        rs.getString("job_type"),
                        rs.getString("job_location"),
                        rs.getDouble("salary"),
                        rs.getString("job_description")
                );
                JobList.add(job);
            }
        } catch (SQLException e) {
        }
        return JobList;
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
    
    public static Job getJobDetails(Connection conn, int jobId) {
    Job job = null;
    String query = "SELECT * FROM jobs WHERE job_id = ?;";
    try {
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, jobId);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            job = new Job(
                rs.getInt("job_id"),
                rs.getInt("employer_id"),
                rs.getString("job_title"),
                rs.getString("job_category"),
                rs.getString("job_type"),
                rs.getString("job_location"),
                rs.getDouble("salary"),
                rs.getString("job_description")
            );
        }
    } catch (SQLException e) {
    }
    return job;
}
public List<Job> getJobListCompany(Connection con) {
        List<Job> JobList = new ArrayList<>();
        String query="SELECT job_id,job_title,job_category,job_type,job_location,salary,job_description FROM jobs WHERE employer_id=? ";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.employerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Job job = new Job(
                        
                        rs.getString("job_title"),
                        rs.getString("job_category"),
                        rs.getString("job_type"),
                        rs.getString("job_location"),
                        rs.getDouble("salary"),
                        rs.getString("job_description"),
                        rs.getInt("job_id")
                );
                JobList.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return JobList;
    }
public boolean deleteJob(Connection con){
           try {
            String query = "DELETE FROM jobs WHERE job_id=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1,this.jobId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
      
}}