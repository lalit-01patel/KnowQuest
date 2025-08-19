package servlet;

import dao.QuestionDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

//@WebServlet("/askQuestion")
public class AskQuestionServlet extends HttpServlet {
    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("user") == null) {
            resp.sendRedirect("login.html?err=Please+login");
            return;
        }

        User u = (User) s.getAttribute("user");
        String title = req.getParameter("title");
        String subject = req.getParameter("subject");
        String content = req.getParameter("content");

        if (title == null || subject == null || content == null ||
                title.isBlank() || subject.isBlank() || content.isBlank()) {
            resp.sendRedirect("ask.jsp?err=All+fields+required");
            return;
        }

        questionDAO.create(u.getId(), title.trim(), content.trim(), subject.trim());
        resp.sendRedirect("home?msg=Question+posted");
    }
}
