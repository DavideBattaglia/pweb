package com.example.progweb;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "CarrelloServlet", value = "/carrello")
public class CarrelloServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:derby://localhost:1527/ProgWebDB";
    private static final String DB_USER = "app";
    private static final String DB_PASS = "aa";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Retrieve the event ID, username and ticket type from the request
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String username = (String) request.getSession().getAttribute("user");
        String ticketType = request.getParameter("ticketType");

        if (username != null && eventId > 0 && ticketType != null) {
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                // Retrieve the price based on the event ID and ticket type
                String priceSql = "SELECT ";
                if (ticketType.equals("STANDING")) {
                    priceSql += "PrezzoInPiedi ";
                } else {
                    priceSql += "PrezzoASedere ";
                }
                priceSql += "FROM Eventi WHERE Id = ?";
                PreparedStatement priceStatement = connection.prepareStatement(priceSql);
                priceStatement.setInt(1, eventId);
                ResultSet priceResult = priceStatement.executeQuery();

                if (priceResult.next()) {
                    int price = priceResult.getInt(1);

                    // Insert the new row with retrieved ID, username, event ID, price and ticket type
                    String insertSql = "INSERT INTO Carrello (Id, Username, IdEvento,  TipologiaBiglietto,Prezzo) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement insertStatement = connection.prepareStatement(insertSql);
                    int countId = getNextId(connection);
                    insertStatement.setInt(1, countId);
                    insertStatement.setString(2, username);
                    insertStatement.setInt(3, eventId);
                    insertStatement.setString(4, ticketType);
                    insertStatement.setInt(5, price);
                    insertStatement.executeUpdate();

                    response.getWriter().write("Ticket aggiunto al carrello con successo!");
                } else {
                    response.getWriter().write("Errore: Impossibile recuperare il prezzo del biglietto!");
                }

            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Username: " + username);
                System.out.println("IdProdotto: " + eventId);
                System.out.println("TicketType: " + ticketType);
                response.getWriter().write("Errore durante l'aggiunta del ticket al carrello!");
            }
        } else {
            // Handle invalid username, event ID or missing ticket type
            System.out.println("Username provato: " + username);
            System.out.println("ID evento provato: " + eventId);
            System.out.println("Tipologia biglietto provata: " + ticketType);
            response.getWriter().write("Errore: username, ID evento o tipologia biglietto non validi!");
        }
    }

    private int getNextId(Connection connection) throws SQLException {
        String nextIdSql = "SELECT MAX(id) + 1 AS nextId FROM Carrello";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(nextIdSql);

        if (resultSet.next()) {
            int nextId = resultSet.getInt("nextId");
            if (nextId == 0) {
                // Handle case where no entries exist (start from 1)
                return 1;
            } else {
                return nextId;
            }
        } else {
            // Handle case where no entries exist (start from 1)
            return 1;
        }
    }
}
