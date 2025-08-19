package servlet;

import dao.AnswerDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

//@WebServlet("/vote")
public class VoteServlet extends HttpServlet {
    private final AnswerDAO dao = new AnswerDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int aid = Integer.parseInt(req.getParameter("answerId"));
        int qid = Integer.parseInt(req.getParameter("questionId"));
        String type = req.getParameter("type");

        if ("up".equals(type)) dao.upvote(aid);
        else if ("down".equals(type)) dao.downvote(aid);

        resp.sendRedirect("question?id=" + qid);
    }
}