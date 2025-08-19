package servlet;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

//@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password"); // TODO: hash later
        String role = req.getParameter("role") != null ? req.getParameter("role") : "STUDENT";

        if (name == null || email == null || password == null || name.isBlank() || email.isBlank() || password.isBlank()){
            resp.sendRedirect("signup.html?err=Please+fill+all+fields");
            return;
        }

        if (userDAO.emailExists(email)) {
            resp.sendRedirect("signup.html?err=Email+already+registered");
            return;
        }

        userDAO.create(name, email, password, role);
        resp.sendRedirect("login.html?msg=Signup+successful.+Please+login");
    }
}