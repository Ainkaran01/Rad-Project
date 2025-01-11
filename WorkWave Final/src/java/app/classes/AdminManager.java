package app.classes;

import java.sql.*;

public class AdminManager {
    
    public static boolean toggleUserStatus(int userId) {
        String sql = "UPDATE user SET status = CASE WHEN status = 'active' THEN 'disabled' ELSE 'active' END WHERE user_id = ? AND usertype != 'admin'";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean toggleJobStatus(int jobId) {
        String sql = "UPDATE jobs SET status = CASE WHEN status = 'active' THEN 'disabled' ELSE 'active' END WHERE job_id = ?";
        try (Connection conn = DbConnector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, jobId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static ResultSet getAllUsers() throws SQLException {
        Connection conn = DbConnector.getConnection();
        String sql = "SELECT * FROM user";
        Statement stmt = conn.createStatement();
        return stmt.executeQuery(sql);
    }

    public static ResultSet getAllJobs() throws SQLException {
        Connection conn = DbConnector.getConnection();
        String sql = "SELECT * FROM jobs";
        Statement stmt = conn.createStatement();
        return stmt.executeQuery(sql);
    }
}