package servlet;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import dao.AnswerDAO;
import dao.QuestionDAO;
import model.Answer;
import model.Question;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ExportPDFServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing id parameter");
            return;
        }

        int id = Integer.parseInt(idParam);

        QuestionDAO qdao = new QuestionDAO();
        Question q = qdao.findById(id);
        if (q == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Question not found");
            return;
        }

        AnswerDAO adao = new AnswerDAO();
        List<Answer> answers = adao.listByQuestionId(id);

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=question_" + id + ".pdf");

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            document.add(new Paragraph("Question: " + q.getTitle()));
            document.add(new Paragraph("Subject: " + q.getSubject()));
            document.add(new Paragraph("Content: " + q.getContent()));
            document.add(new Paragraph(" ")); // blank line

            document.add(new Paragraph("Answers:"));
            for (Answer a : answers) {
                document.add(new Paragraph("- " + a.getAnsweredByName() + ": " + a.getContent()));
            }

            document.close();
        } catch (DocumentException e) {
            throw new ServletException("Error generating PDF", e);
        }
    }
}