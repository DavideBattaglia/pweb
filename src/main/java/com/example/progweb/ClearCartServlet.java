package com.example.progweb;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "ClearCartServlet", value = "/clearCartServlet")
public class ClearCartServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:derby://localhost:1527/ProgWebDB";
    private static final String DB_USER = "app";
    private static final String DB_PASS = "apppass";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get username from session
        String username = (String) request.getSession().getAttribute("user");

        if (username != null) {
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                // Prepare statement to update the `Acquisti` field in the `Utenti` table
                String updateAcquistiQuery = "UPDATE Utenti SET Acquisti = Acquisti + (SELECT COUNT(*) FROM Carrello WHERE Username = ?) WHERE Username = ?";
                PreparedStatement updateAcquistiStatement = connection.prepareStatement(updateAcquistiQuery);
                updateAcquistiStatement.setString(1, username);
                updateAcquistiStatement.setString(2, username);
                updateAcquistiStatement.executeUpdate();


                // Prepare statement to delete all items from the cart for the user
                String deleteCartQuery = "DELETE FROM Carrello WHERE Username = ?";
                PreparedStatement deleteCartStatement = connection.prepareStatement(deleteCartQuery);
                deleteCartStatement.setString(1, username);
                deleteCartStatement.executeUpdate();



                // Cart cleared and acquisti updated, redirect to homepage
                response.sendRedirect("conferma.jsp");

            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Username: " + username);
                response.getWriter().write("Errore durante l'acquisto.");
            }
        } else {
            // User not logged in, redirect or display message
            response.sendRedirect("login.jsp");
            // or
            // response.getWriter().write("Devi effettuare il login per acquistare.");
        }
    }
}
