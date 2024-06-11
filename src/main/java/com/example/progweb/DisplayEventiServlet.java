package com.example.progweb;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
@WebServlet("/DisplayEventiServlet")
public class DisplayEventiServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String order = request.getParameter("order");
        String sql = "SELECT * FROM Eventi";
        if ("desc".equals(order)) {
            sql += " ORDER BY Click DESC";
        } else {
            sql += " ORDER BY Id";
        }
        String sqlClicks = "SELECT TipoEvento, SUM(Click) as TotalClicks FROM Eventi GROUP BY TipoEvento";
        Map<String, Integer> clickData = new HashMap<>();

        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB", "app", "aa");) {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            request.setAttribute("resultSet", rs);

            PreparedStatement stmtClicks = connection.prepareStatement(sqlClicks);
            ResultSet rsClicks = stmtClicks.executeQuery();
            while (rsClicks.next()) {
                clickData.put(rsClicks.getString("TipoEvento"), rsClicks.getInt("TotalClicks"));
            }
            request.setAttribute("clickData", clickData);

            request.getRequestDispatcher(response.encodeURL("VisualizzaEventi.jsp")).forward(request, response);

        } catch (SQLException ex) {
            ex.printStackTrace();
            response.sendRedirect("login.jsp");
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String Id = request.getParameter("Id");
        if (Id != null && !Id.isEmpty()) {
            deleteEvent(Id,request,response);
        }

    }

    private void deleteEvent(String Id, HttpServletRequest request, HttpServletResponse response) throws IOException{


        String sql = "DELETE FROM Eventi WHERE Id = ?";
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
            request.getRequestDispatcher(response.encodeURL("VisualizzaEventi.jsp")).forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace(); // Handle database errors appropriately
            response.sendRedirect("VisualizzaEventi.jsp"); // Redirect to event list page
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
