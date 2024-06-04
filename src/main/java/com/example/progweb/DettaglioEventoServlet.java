package com.example.progweb;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;

@WebServlet("/dettaglioEvento")
public class DettaglioEventoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Retrieve eventId from the request parameter
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // Establish database connection (replace with your actual DB connection details)
        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB", "app", "aa")) {
            // Prepare and execute SQL query to fetch event details
            String sql = "SELECT * FROM eventi WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, eventId);
            ResultSet resultSet = statement.executeQuery();

            // Check if event exists
            if (resultSet.next()) {
                // No need to create an Event object here (optional)
                request.setAttribute("Id", resultSet.getString("Id"));
                request.setAttribute("nomeEvento", resultSet.getString("NomeEvento"));
                request.setAttribute("dataOra", resultSet.getString("DataOra"));
                request.setAttribute("localita", resultSet.getString("Localita"));
                request.setAttribute("immagine", resultSet.getString("Immagine"));
                request.setAttribute("prezzoInPiedi", resultSet.getDouble("PrezzoInPiedi"));
                request.setAttribute("prezzoASedere", resultSet.getDouble("PrezzoASedere"));

                // Forward request to dettaglio_evento.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("dettaglio_evento.jsp");
                dispatcher.forward(request, response);
            } else {
                // Handle event not found (e.g., show an error message)
                System.out.println("eventId: " + eventId);
                response.sendRedirect("eventi_sportivi.jsp"); // Redirect to event list page
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Handle database errors appropriately
            System.out.println("eventId SQLerr: " + eventId);
            response.sendRedirect("eventi_sportivi.jsp"); // Redirect to event list page
        }
    }
}
