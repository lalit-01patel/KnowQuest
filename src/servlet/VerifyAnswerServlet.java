package servlet;

import dao.AnswerDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

//@WebServlet("/verifyAnswer")
public class VerifyAnswerServlet extends HttpServlet {
    private final AnswerDAO dao = new AnswerDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect("login.html?err=Please+login");
            return;
        }

        User u = (User) s.getAttribute("user");
        if (!"TEACHER".equalsIgnoreCase(u.getRole())) {
            resp.sendRedirect("home?err=Only+teachers+can+verify");
            return;
        }

        int aid = Integer.parseInt(req.getParameter("answerId"));
        int qid = Integer.parseInt(req.getParameter("questionId"));

        dao.markVerified(aid);

        resp.sendRedirect("question?id=" + qid);
    }
}