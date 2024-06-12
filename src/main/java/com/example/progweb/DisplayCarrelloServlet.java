package com.example.progweb;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "DisplayCarrelloServlet", value = "/DisplayCarrelloServlet")
public class DisplayCarrelloServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:derby://localhost:1527/ProgWebDB";
    private static final String DB_USER = "app";
    private static final String DB_PASS = "apppass";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get username from session
        String username = (String) request.getSession().getAttribute("user");

        if (username != null) {
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String cartQuery = "SELECT e.NomeEvento, e.DataOra, e.Localita, c.TipologiaBiglietto, c.Prezzo, e.Sconto" +
                        " FROM Eventi e " +
                        " INNER JOIN Carrello c ON e.Id = c.IdEvento " +
                        " WHERE c.Username = ?";
                PreparedStatement cartStatement = connection.prepareStatement(cartQuery);
                cartStatement.setString(1, username);
                ResultSet resultSet = cartStatement.executeQuery();

                // Get total number of purchases directly from Utenti table
                String acquistiQuery = "SELECT Acquisti FROM Utenti WHERE Username = ?";
                PreparedStatement acquistiStatement = connection.prepareStatement(acquistiQuery);
                acquistiStatement.setString(1, username);
                ResultSet acquistiResult = acquistiStatement.executeQuery();

                int totalAcquisti = 0;
                if (acquistiResult.next()) {
                    totalAcquisti = acquistiResult.getInt("Acquisti");
                }

                // Set the retrieved data, total price (implementation needed), and total acquisti as request attributes
                //request.setAttribute("totalPrice", totalPrice); // Implement price calculation
                request.setAttribute("resultSet", resultSet);
                request.setAttribute("totalAcquisti", totalAcquisti);

                // Forward to carrello.jsp for display
                RequestDispatcher dispatcher = request.getRequestDispatcher(response.encodeURL("/carrello.jsp"));
                dispatcher.forward(request, response);


            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Username: " + username);
                response.getWriter().write("Errore durante il recupero degli eventi dal carrello.");
            }
        } else {
            // User not logged in, redirect or display message
            response.sendRedirect("login.jsp"); // Redirect to login page
            // or
            // response.getWriter().write("Devi effettuare il login per visualizzare il tuo carrello.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
