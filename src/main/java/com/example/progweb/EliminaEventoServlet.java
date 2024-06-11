package com.example.progweb;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "EliminaEventoServlet", value = "/EliminaEventoServlet")
public class EliminaEventoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String Id = request.getParameter("Id");
        String sql = "DELETE FROM Eventi WHERE Id = ?";
        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB", "app", "aa");) {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(Id));
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("Evento eliminato correttamente.");
            } else {
                System.out.println("Nessun evento trovato con l'ID specificato.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Handle database errors appropriately
            System.out.println("eventId SQLerr");
            response.sendRedirect("login.jsp"); // Redirect to event list page
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
