package com.example.progweb;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;

@WebServlet("/dettaglio_evento")
public class DettaglioEventoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Retrieve eventId from the request parameter
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // Establish database connection (replace with your actual DB connection details)
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_name", "username", "password")) {
            // Prepare and execute SQL query to fetch event details
            String sql = "SELECT * FROM eventi WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, eventId);
            ResultSet resultSet = statement.executeQuery();

            // Check if event exists and extract data
            if (resultSet.next()) {
                String nome = resultSet.getString("NomeEvento");
                String dataOra = resultSet.getString("DataOra");
                String localita = resultSet.getString("Localita");
                String immagine = resultSet.getString("Immagine");
                String descrizione = resultSet.getString("Descrizione");
                double prezzoInPiedi = resultSet.getDouble("PrezzoInPiedi");
                double prezzoASedere = resultSet.getDouble("PrezzoASedere");

                // Create an Event object (replace with your actual Event class if you have one)
                Event evento = new Event(eventId, nome, dataOra, localita, immagine, descrizione, prezzoInPiedi, prezzoASedere);

                // Store event object in request attribute
                request.setAttribute("evento", evento);

                // Forward request to dettaglio_evento.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("dettaglio_evento.jsp");
                dispatcher.forward(request, response);
            } else {
                // Handle event not found (e.g., show an error message)
                response.sendRedirect("eventi_sportivi.jsp"); // Redirect to event list page
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Handle database errors appropriately
            response.sendRedirect("eventi_sportivi.jsp"); // Redirect to event list page
        }
    }
}
