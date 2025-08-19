package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QuestionDAO;
import model.Question;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        QuestionDAO qdao = new QuestionDAO();
        List<Question> searchResults = qdao.search(query);
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("searchQuery", query);
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }
}