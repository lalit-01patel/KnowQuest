package servlet;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

public class QRCodeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing id parameter");
            return;
        }

        try {
            String url = request.getScheme() + "://" +
                    request.getServerName() + ":" +
                    request.getServerPort() +
                    request.getContextPath() + "/question?id=" + id;

            int size = 250;
            BitMatrix matrix = new MultiFormatWriter()
                    .encode(url, BarcodeFormat.QR_CODE, size, size);

            response.setContentType("image/png");
            try (OutputStream out = response.getOutputStream()) {
                MatrixToImageWriter.writeToStream(matrix, "PNG", out);
            }
        } catch (Exception e) {
            throw new ServletException("Error generating QR Code", e);
        }
    }
}