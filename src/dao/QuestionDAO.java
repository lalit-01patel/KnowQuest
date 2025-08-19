package dao;

import db.DBConnection;
import model.Question;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {

    public List<Question> listAll(String q) {
        String base = """
            SELECT q.id,q.user_id,q.title,q.content,q.subject,q.created_at,u.name AS asked_by
            FROM questions q JOIN users u ON q.user_id=u.id
        """;
        String where = (q != null && !q.trim().isEmpty())
                ? " WHERE q.title LIKE ? OR q.content LIKE ? OR q.subject LIKE ?"
                : "";
        String order = " ORDER BY q.created_at DESC";
        String sql = base + where + order;

        List<Question> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (!where.isEmpty()) {
                String like = "%" + q.trim() + "%";
                ps.setString(1, like);
                ps.setString(2, like);
                ps.setString(3, like);
            }
            try (ResultSet rs = ps.executeQuery()){
                while (rs.next()){
                    Question qu = new Question();
                    qu.setId(rs.getInt("id"));
                    qu.setUserId(rs.getInt("user_id"));
                    qu.setTitle(rs.getString("title"));
                    qu.setContent(rs.getString("content"));
                    qu.setSubject(rs.getString("subject"));
                    qu.setCreatedAt(rs.getTimestamp("created_at"));
                    qu.setAskedByName(rs.getString("asked_by"));
                    list.add(qu);
                }
            }
        } catch (SQLException e){ throw new RuntimeException(e); }
        return list;
    }

    public Question findById(int id){
        String sql = """
            SELECT q.id,q.user_id,q.title,q.content,q.subject,q.created_at,u.name AS asked_by
            FROM questions q JOIN users u ON q.user_id=u.id
            WHERE q.id=?
        """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()){
                if (rs.next()){
                    Question qu = new Question();
                    qu.setId(rs.getInt("id"));
                    qu.setUserId(rs.getInt("user_id"));
                    qu.setTitle(rs.getString("title"));
                    qu.setContent(rs.getString("content"));
                    qu.setSubject(rs.getString("subject"));
                    qu.setCreatedAt(rs.getTimestamp("created_at"));
                    qu.setAskedByName(rs.getString("asked_by"));
                    return qu;
                }
            }
        } catch (SQLException e){ throw new RuntimeException(e); }
        return null;
    }

    public void create(int userId, String title, String content, String subject){
        String sql = "INSERT INTO questions(user_id,title,content,subject) VALUES(?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, content);
            ps.setString(4, subject);
            ps.executeUpdate();
        } catch (SQLException e){ throw new RuntimeException(e); }
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM questions";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    // List all questions by a specific user (for profile page)
    public List<Question> listAllByUser(int userId) {
        String sql = """
            SELECT q.id,q.user_id,q.title,q.content,q.subject,q.created_at,
                   u.name AS asked_by
            FROM questions q JOIN users u ON q.user_id=u.id
            WHERE q.user_id=? ORDER BY q.created_at DESC
        """;
        List<Question> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Question qu = new Question();
                    qu.setId(rs.getInt("id"));
                    qu.setUserId(rs.getInt("user_id"));
                    qu.setTitle(rs.getString("title"));
                    qu.setContent(rs.getString("content"));
                    qu.setSubject(rs.getString("subject"));
                    qu.setCreatedAt(rs.getTimestamp("created_at"));
                    qu.setAskedByName(rs.getString("asked_by"));
                    list.add(qu);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    // Fixed search method
    public List<Question> search(String query) {
        List<Question> questions = new ArrayList<>();
        String sql = """
            SELECT q.id,q.user_id,q.title,q.content,q.subject,q.created_at,u.name AS asked_by
            FROM questions q JOIN users u ON q.user_id = u.id
            WHERE q.title LIKE ? OR q.content LIKE ?
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            String searchQuery = "%" + query + "%";
            pstmt.setString(1, searchQuery);
            pstmt.setString(2, searchQuery);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Question question = new Question();
                    question.setId(rs.getInt("id"));
                    question.setUserId(rs.getInt("user_id"));
                    question.setTitle(rs.getString("title"));
                    question.setContent(rs.getString("content"));
                    question.setSubject(rs.getString("subject"));
                    question.setCreatedAt(rs.getTimestamp("created_at"));
                    question.setAskedByName(rs.getString("asked_by"));
                    questions.add(question);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }
}