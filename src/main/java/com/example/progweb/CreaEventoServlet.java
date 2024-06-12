package com.example.progweb;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/CreaEventoServlet")
public class CreaEventoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String tipoEvento = request.getParameter("tipoEvento");
        String nomeEvento = request.getParameter("nomeEvento");
        String dataOra = request.getParameter("dataOra");
        String localita = request.getParameter("localita");
        int postiASedere = Integer.parseInt(request.getParameter("postiASedere"));
        int postiInPiedi = Integer.parseInt(request.getParameter("postiInPiedi"));
        float prezzoASedere = Float.parseFloat(request.getParameter("prezzoASedere"));
        float prezzoInPiedi = Float.parseFloat(request.getParameter("prezzoInPiedi"));
        String immagine = request.getParameter("immagine");
        int Sconto = Integer.parseInt(request.getParameter("Sconto"));

        String sql = "INSERT INTO Eventi (TipoEvento, NomeEvento, DataOra, Localita, PostiASedere, PostiInPiedi, PrezzoASedere, PrezzoInPiedi, Immagine, Sconto, Click) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";

        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB", "app", "aa");) {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, tipoEvento);
            stmt.setString(2, nomeEvento);
            stmt.setTimestamp(3, Timestamp.valueOf(dataOra.replace("T", " ") + ":00"));
            stmt.setString(4, localita);
            stmt.setInt(5, postiASedere);
            stmt.setInt(6, postiInPiedi);
            stmt.setFloat(7, prezzoASedere);
            stmt.setFloat(8, prezzoInPiedi);
            stmt.setString(9, immagine);
            stmt.setInt(10, Sconto);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                request.setAttribute("message", "Evento creato con successo.");
            } else {
                request.setAttribute("message", "Errore nella creazione dell'evento.");
            }
            request.getRequestDispatcher("VisualizzaEventi.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Errore di database: " + e.getMessage());
            request.getRequestDispatcher("VisualizzaEventi.jsp").forward(request, response);
        }
    }
}
