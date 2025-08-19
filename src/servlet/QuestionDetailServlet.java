package servlet;

import dao.AnswerDAO;
import dao.QuestionDAO;
import model.Answer;
import model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

//@WebServlet("/question")
public class QuestionDetailServlet extends HttpServlet {
    private final QuestionDAO questionDAO = new QuestionDAO();
    private final AnswerDAO answerDAO = new AnswerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null){ resp.sendRedirect("home"); return; }

        int id = Integer.parseInt(idStr);
        Question q = questionDAO.findById(id);
        if (q == null){ resp.sendRedirect("home?err=Question+not+found"); return; }

        List<Answer> answers = answerDAO.listByQuestionId(id);
        req.setAttribute("question", q);
        req.setAttribute("answers", answers);
        req.getRequestDispatcher("question.jsp").forward(req, resp);
    }
}