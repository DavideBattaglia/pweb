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
                // Get details of events and tickets from the cart
                String cartQuery = "SELECT e.NomeEvento, e.DataOra, e.Localita, c.TipologiaBiglietto, c.Prezzo " +
                        "FROM Eventi e " +
                        "INNER JOIN Carrello c ON e.Id = c.IdEvento " +
                        "WHERE c.Username = ?";
                PreparedStatement cartStatement = connection.prepareStatement(cartQuery);
                cartStatement.setString(1, username);
                ResultSet resultSet = cartStatement.executeQuery();

                // Set the retrieved data and total price as request attributes
                //request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("resultSet", resultSet);


                // Forward to carrello.jsp for display
                RequestDispatcher dispatcher = request.getRequestDispatcher("/carrello.jsp");
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
}
