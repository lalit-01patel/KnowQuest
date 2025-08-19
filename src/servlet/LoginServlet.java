package servlet;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

//@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User u = userDAO.findByEmailAndPassword(email, password);
        if (u == null){
            resp.sendRedirect("login.html?err=Invalid+credentials");
            return;
        }
        HttpSession session = req.getSession(true);
        session.setAttribute("user", u);
        resp.sendRedirect("home");
    }
}