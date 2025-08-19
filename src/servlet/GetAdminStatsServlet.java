package servlet;

import dao.AdminDAO;
import com.google.gson.Gson;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class GetAdminStatsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            AdminDAO dao = new AdminDAO();
            // Example: Fetch stats
            int userCount = dao.getUserCount();
            int questionCount = dao.getQuestionCount();
            int answerCount = dao.getAnswerCount();

            // Pack into JSON
            Stats stats = new Stats(userCount, questionCount, answerCount);
            String json = new Gson().toJson(stats);

            out.print(json);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error fetching admin stats: " + e.getMessage());
        }
    }

    // Inner class to hold data
    class Stats {
        int users;
        int questions;
        int answers;
        Stats(int u, int q, int a) {
            users = u; questions = q; answers = a;
        }
    }
}