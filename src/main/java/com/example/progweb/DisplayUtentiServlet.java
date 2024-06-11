package com.example.progweb;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DisplayUtentiServlet")
public class DisplayUtentiServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String order = request.getParameter("order");
        String sql = "SELECT * FROM UTENTI";
        if ("desc".equals(order)) {
            sql += " ORDER BY acquisti DESC";
        } else {
            sql += " ORDER BY id";
        }

        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB", "app", "aa");) {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            request.setAttribute("resultSet", rs);
            request.getRequestDispatcher("VisualizzaUtenti.jsp").forward(request, response);

        } catch (SQLException ex) {
            ex.printStackTrace(); // Handle database errors appropriately
            response.sendRedirect("login.jsp"); // Redirect to event list page
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String Id = request.getParameter("Id");
        if (Id != null && !Id.isEmpty()) {
            deleteUtente(Id,request,response);
        }

    }

    private void deleteUtente(String Id, HttpServletRequest request, HttpServletResponse response) throws IOException{
        String sql = "DELETE FROM Utenti WHERE Id = ?";
        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB", "app", "aa");) {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(Id));
            int rowsDeleted = stmt.executeUpdate();
            String message;
            if (rowsDeleted > 0) {
                message = "Utente eliminato correttamente.";
            } else {
                message = "Nessun utente trovato con l'ID specificato.";
            }
            request.setAttribute("message", message);
            request.getRequestDispatcher(response.encodeURL("VisualizzaUtenti.jsp")).forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace(); // Handle database errors appropriately
            response.sendRedirect("VisualizzaUtenti.jsp"); // Redirect to event list page
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
