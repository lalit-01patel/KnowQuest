package dao;

import db.DBConnection;
import model.User;

import java.sql.*;

public class UserDAO {
    public boolean emailExists(String email) {
        String sql = "SELECT 1 FROM users WHERE email=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()){
                return rs.next();
            }
        } catch (SQLException e){ throw new RuntimeException(e); }
    }

    public void create(String name, String email, String password, String role){
        String sql = "INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password); // For MVP; later hash with BCrypt
            ps.setString(4, role);
            ps.executeUpdate();
        } catch (SQLException e){ throw new RuntimeException(e); }
    }

    public User findByEmailAndPassword(String email, String password){
        String sql = "SELECT id,name,email,role FROM users WHERE email=? AND password=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()){
                if (rs.next()){
                    return new User(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("role")
                    );
                }
            }
        } catch (SQLException e){ throw new RuntimeException(e); }
        return null;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }
}