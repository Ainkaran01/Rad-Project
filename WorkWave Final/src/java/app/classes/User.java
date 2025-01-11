package app.classes;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class User {

    private int user_id;
    private String firstname;
    private String lastname;
    private String email;
    private String phone;
    private String city;
    String usertype;
    String password;

    public User() {
    }

    public User(int user_id) {
        this.user_id = user_id;
    }
    
     public User(int user_id, String firstname, String lastname, String email, String phone, String city) {
        this.user_id = user_id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.phone = phone;
        this.city = city;
    }


    public User(String firstname, String lastname, String email, String phone, String city) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.phone = phone;
        this.city = city;
    }

    public User(String email, String password,String usertype) {
        this.email = email;
        this.password = MD5.getMd5(password);
        this.usertype=usertype;
    }

    public User(String firstname, String lastname, String email, String phone, String city, String usertype, String password) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.phone = phone;
        this.city = city;
        this.usertype = usertype;
        this.password = MD5.getMd5(password);
    }
    
    

    // Getters and Setters
    public int getUserId() {
        return user_id;
    }

    public void setUserId(int id) {
        this.user_id = id;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getUsertype() {
        return usertype;
    }

    public void setUsertype(String usertype) {
        this.usertype = usertype;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = MD5.getMd5(password);
    }

    // Registration method
  
    public int register(Connection con) {
        try {
            String query = "INSERT INTO user (firstname, lastname, email, phone, city, usertype, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, this.firstname);
            pstmt.setString(2, this.lastname);
            pstmt.setString(3, this.email);
            pstmt.setString(4, this.phone);
            pstmt.setString(5, this.city);
            pstmt.setString(6, this.usertype);
            pstmt.setString(7, this.password);

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }

    
    

    // Authentication method
    public boolean authenticate(Connection con) {
        try {
            String query = "SELECT password,usertype,user_id FROM user WHERE email = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String db_password = rs.getString("password");
                if (db_password.equals(this.password)) {
                    int userId =rs.getInt("user_id");
                    String user_type = rs.getString("usertype");
                    this.setUserId(userId);
                    this.setUsertype(user_type);
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    public User getDetails(Connection con) {
    try {
        String query = "SELECT firstname, lastname, email, phone, city FROM user WHERE user_id = ?"; // Ensure 'id' is correct
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, this.user_id);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            this.firstname = rs.getString("firstname");
            this.lastname = rs.getString("lastname");
            this.email = rs.getString("email");
            this.phone = rs.getString("phone");
            this.city = rs.getString("city");
        return  this;
        } else {
            Logger.getLogger(Employer.class.getName()).log(Level.WARNING, "No employer found with ID: " + this.user_id);
        }
    } catch (SQLException ex) {
        Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
      
    }

return null;
    
    }

    public boolean updatedetails(Connection con) {
        try {
            String query = "UPDATE user SET firstname = ?, lastname = ?, email = ?, phone = ?, city = ? WHERE user_id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.firstname);
            pstmt.setString(2, this.lastname);
            pstmt.setString(3, this.email);
            pstmt.setString(4, this.phone);
            pstmt.setString(5, this.city);
            pstmt.setInt(6, user_id);

            return pstmt.executeUpdate() > 0;
            
        } 
        
        catch (SQLException e) {
            
            return false;
  }


    }

}









