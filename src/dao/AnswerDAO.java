package dao;

import db.DBConnection;
import model.Answer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnswerDAO {

    // List answers for a specific question
    public List<Answer> listByQuestionId(int qid) {
        String sql = """
            SELECT a.id,a.question_id,a.user_id,a.content,a.created_at,
                   a.upvotes,a.downvotes,a.verified,
                   u.name AS answered_by
            FROM answers a JOIN users u ON a.user_id=u.id
            WHERE a.question_id=? ORDER BY a.created_at ASC
        """;
        List<Answer> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, qid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Answer a = new Answer();
                    a.setId(rs.getInt("id"));
                    a.setQuestionId(rs.getInt("question_id"));
                    a.setUserId(rs.getInt("user_id"));
                    a.setContent(rs.getString("content"));
                    a.setCreatedAt(rs.getTimestamp("created_at"));
                    a.setAnsweredByName(rs.getString("answered_by"));
                    a.setUpvotes(rs.getInt("upvotes"));
                    a.setDownvotes(rs.getInt("downvotes"));
                    a.setVerified(rs.getBoolean("verified"));
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    // Create a new answer
    public void create(int questionId, int userId, String content) {
        String sql = "INSERT INTO answers(question_id,user_id,content) VALUES(?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, questionId);
            ps.setInt(2, userId);
            ps.setString(3, content);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Upvote an answer
    public void upvote(int id) {
        String sql = "UPDATE answers SET upvotes = upvotes + 1 WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Downvote an answer
    public void downvote(int id) {
        String sql = "UPDATE answers SET downvotes = downvotes + 1 WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Mark an answer as verified (by teacher)
    public void markVerified(int id) {
        String sql = "UPDATE answers SET verified = 1 WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // List answers by a specific user (for profile page)
    public List<Answer> listByUser(int userId) {
        String sql = """
            SELECT a.id,a.question_id,a.content,a.created_at,
                   a.upvotes,a.downvotes,a.verified,
                   q.title AS question_title
            FROM answers a JOIN questions q ON a.question_id=q.id
            WHERE a.user_id=? ORDER BY a.created_at DESC
        """;
        List<Answer> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Answer a = new Answer();
                    a.setId(rs.getInt("id"));
                    a.setQuestionId(rs.getInt("question_id"));
                    a.setContent(rs.getString("content"));
                    a.setCreatedAt(rs.getTimestamp("created_at"));
                    a.setUpvotes(rs.getInt("upvotes"));
                    a.setDownvotes(rs.getInt("downvotes"));
                    a.setVerified(rs.getBoolean("verified"));
                    a.setQuestionTitle(rs.getString("question_title"));
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM answers";
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