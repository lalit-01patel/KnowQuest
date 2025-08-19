package servlet;

import dao.AnswerDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

//@WebServlet("/answer")
public class AnswerServlet extends HttpServlet {
    private final AnswerDAO answerDAO = new AnswerDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null){
            resp.sendRedirect("login.html?err=Please+login");
            return;
        }
        User u = (User) s.getAttribute("user");
        String qidStr = req.getParameter("questionId");
        String content = req.getParameter("content");
        if (qidStr == null || content == null || content.isBlank()){
            resp.sendRedirect("home?err=Invalid+answer");
            return;
        }
        int qid = Integer.parseInt(qidStr);
        answerDAO.create(qid, u.getId(), content.trim());
        resp.sendRedirect("question?id=" + qid + "&msg=Answer+added");
    }
}