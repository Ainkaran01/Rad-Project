package app.classes;
import java.sql.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Employer extends User {

    private int employerId;
    private String companyName;
    private int numberOfEmployees;
    private String companyEmail;
    private String companyAddress;
    private String companyWebsite;
    private String companyLogo;
    private int user_id;
    
    public Employer() {
    }

    public Employer(int user_id) {
        this.user_id = user_id;
    }

    
    public Employer(String firstname, String lastname, String email, String phone, String city, String usertype, String password,
            String companyName, int numberOfEmployees, String companyEmail, String companyAddress, String companyWebsite, String companyLogo) {
        super(firstname, lastname, email, phone, city, usertype, password);
        this.companyName = companyName;
        this.numberOfEmployees = numberOfEmployees;
        this.companyEmail = companyEmail;
        this.companyAddress = companyAddress;
        this.companyWebsite = companyWebsite;
        this.companyLogo = companyLogo;
    }
    public Employer(int employerId, String companyName, String companyAddress, String companyWebsite, int numberOfEmployees, String companyEmail) {
        this.employerId = employerId;
        this.companyName = companyName;
        this.companyAddress = companyAddress;
        this.companyWebsite = companyWebsite;
        this.numberOfEmployees = numberOfEmployees;
        this.companyEmail = companyEmail;
    }
    

    public Employer(int employerId, String companyName, int numberOfEmployees, String companyEmail, String companyAddress, String companyWebsite, String companyLogo) {
        this.employerId = employerId;
        this.companyName = companyName;
        this.numberOfEmployees = numberOfEmployees;
        this.companyEmail = companyEmail;
        this.companyAddress = companyAddress;
        this.companyWebsite = companyWebsite;
        this.companyLogo = companyLogo;
    }

    public Employer(String companyName, String companyAddress, int numberOfEmployees, String companyEmail, String companyWebsite, String companyLogo) {
        this.companyName = companyName;
        this.companyAddress = companyAddress;
        this.numberOfEmployees = numberOfEmployees;
        this.companyEmail = companyEmail;
        this.companyWebsite = companyWebsite;
        this.companyLogo = companyLogo;
    }

    public Employer(int employerId, String companyName, String companyAddress, String companyEmail, String companyWebsite, String companyLogo) {
        this.employerId = employerId;
        this.companyName = companyName;
        this.companyAddress = companyAddress;
        this.companyEmail = companyEmail;
        this.companyWebsite = companyWebsite;
        this.companyLogo = companyLogo;
    }

   
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getEmployerId() {
        return employerId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public int getNumberOfEmployees() {
        return numberOfEmployees;
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public void setNumberOfEmployees(int numberOfEmployees) {
        this.numberOfEmployees = numberOfEmployees;
    }

    public void setCompanyEmail(String companyEmail) {
        this.companyEmail = companyEmail;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress;
    }

    public void setCompanyWebsite(String companyWebsite) {
        this.companyWebsite = companyWebsite;
    }

    public void setCompanyLogo(String companyLogo) {
        this.companyLogo = companyLogo;
    }

    public String getCompanyEmail() {
        return companyEmail;
    }

    public String getCompanyWebsite() {
        return companyWebsite;
    }

    public int getUser_id() {
        return user_id;
    }

    public String getCompanyLogo() {
        return companyLogo;
    }

    public boolean register(Connection con, int userId) {
        String employerQuery = "INSERT INTO employers (user_id, company_name, company_address, number_of_employees, company_email, company_website, company_logo) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement employerStmt = con.prepareStatement(employerQuery)) {
            employerStmt.setInt(1, userId);
            employerStmt.setString(2, companyName);
            employerStmt.setString(3, companyAddress);
            employerStmt.setInt(4, numberOfEmployees);
            employerStmt.setString(5, companyEmail);
            employerStmt.setString(6, companyWebsite);
            employerStmt.setString(7, companyLogo);

            return employerStmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Employer.class.getName()).log(Level.SEVERE, "Error registering employer", ex);
            return false;
        }
    }

   
    public void getEmployerDetails(Connection con) {

        try {
            String query = "SELECT * FROM employers WHERE employer_id=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.employerId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {

                this.companyName = rs.getString("company_name");
                this.companyAddress = rs.getString("company_address");
                this.companyWebsite = rs.getString("company_website");
                this.numberOfEmployees = rs.getInt("number_of_employees");
                this.companyEmail = rs.getString("company_email");
                this.companyLogo = rs.getString("company_logo");

            } else {
                // Log or handle the case where no data is returned
                Logger.getLogger(Employer.class.getName()).log(Level.WARNING, "No employer found with ID: " + employerId);
            }
        } catch (SQLException e) {
            Logger.getLogger(Employer.class.getName()).log(Level.SEVERE, "Error fetching employer details", e);
        }

    }

    public static Employer getEmployerDetails(Connection conn, int employerId) {
        Employer employer = null;
        String query = "SELECT * FROM employers WHERE employer_id = ?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, employerId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                employer = new Employer(
                        rs.getInt("employer_id"),
                        rs.getString("company_name"),
                        rs.getString("company_address"),
                        rs.getString("company_email"),
                        rs.getString("company_website"),
                        rs.getString("company_logo")
                );
            }
        } catch (SQLException e) {
        }
        return employer;
    }


 public  void getemployerdetails(Connection conn) {
      
        String query = "SELECT * FROM employers WHERE user_id = ?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1,this.user_id );
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
              
                this.companyName = rs.getString("company_name");
                this.companyAddress = rs.getString("company_address");
                this.companyWebsite = rs.getString("company_website");
                this.numberOfEmployees = rs.getInt("number_of_employees");
                this.companyEmail = rs.getString("company_email");
                this.companyLogo = rs.getString("company_logo");
                this.employerId=rs.getInt("employer_id");
            }
        } catch (SQLException e) {
        }
       
    }
  public boolean updatedetails(Connection con) {
        try {
            String query = "UPDATE employers SET company_name = ?, company_address = ?, company_email = ?, company_website = ?, number_of_employees = ? WHERE employer_id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.companyName);
            pstmt.setString(2, this.companyAddress);
            pstmt.setString(3, this.companyEmail);
            pstmt.setString(4, this.companyWebsite);
            pstmt.setInt(5, this.numberOfEmployees);
            pstmt.setInt(6, this.employerId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
