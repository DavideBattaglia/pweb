package gvarni.unitn.persession;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

//per semplicità alcuni controlli sono stati omessi per non compromettere l'apprendimento

@WebServlet(name = "Persession", value = "/Persession")
public class Persession extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StringBuffer dbOutput = new StringBuffer("<h1>");

        HttpSession session = request.getSession(false);

        if (session != null) {
            // Sessione attiva, procedi con l'estrazione dei dati
            SessionConnection sessionConnection =
                    (SessionConnection) session.getAttribute("sessionconnection");

            Connection conn = sessionConnection.getConnection();

            try {
                Statement stmt = conn.createStatement();
                String sql = "SELECT * FROM MYTABLE";
                ResultSet results = stmt.executeQuery(sql);
                while (results.next()) {
                    dbOutput.append(results.getInt(1)).append(" - ");
                    dbOutput.append(results.getString(2)).append("</h1><h1>");
                }
                dbOutput.append("</h1>");
                results.close();
                stmt.close();
            } catch (SQLException e) {
                dbOutput.append(
                        "<p>" + "Pertransaction.doGet(  ) SQLException: " +
                                e.getMessage() + "</p>");
            }

            // Invio risposta HTML
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<html>");
                out.println("<head>");
                out.println("<title>A Per Transaction Connection</title>");
                out.println("</head>");
                out.println("<body>");
                out.println(dbOutput);
                out.println("<a href=\"./logout\">Esci</a>");
                out.println("</body><html>");
            }

        } else {
            // Sessione inesistente, reindirizza al login
            request.getRequestDispatcher("./end.html").include(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
