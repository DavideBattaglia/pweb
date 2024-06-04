package com.example.progweb;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
                // Delete all cart records for the current user
                String deleteQuery = "DELETE FROM Carrello WHERE Username = ?";
                PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery);
                deleteStatement.setString(1, username);
                deleteStatement.executeUpdate();

                // Cart is cleared, redirect to carrello.jsp
                response.sendRedirect("conferma.jsp");


            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Username: " + username);
                response.getWriter().write("Errore durante la pulizia del carrello.");
            }
        } else {
            // User not logged in, redirect or display message
            response.sendRedirect("login.jsp"); // Redirect to login page
            // or
            // response.getWriter().write("Devi effettuare il login per visualizzare il tuo carrello.");
        }
    }
}
