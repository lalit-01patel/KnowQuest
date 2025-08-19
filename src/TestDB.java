import java.sql.Connection;
import db.DBConnection;

public class TestDB {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("✅ Connected to database successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}