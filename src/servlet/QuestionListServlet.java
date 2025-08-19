package servlet;

import dao.QuestionDAO;
import model.Question;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

//@WebServlet("/home")
public class QuestionListServlet extends HttpServlet {
    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null){
            resp.sendRedirect("login.html?err=Please+login");
            return;
        }
        String q = req.getParameter("q"); // search query
        List<Question> questions = questionDAO.listAll(q);
        req.setAttribute("questions", questions);
        req.getRequestDispatcher("home.jsp").forward(req, resp);
    }
}