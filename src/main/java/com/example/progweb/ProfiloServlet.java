package com.example.progweb;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

import static java.lang.System.out;

@WebServlet("/ProfiloServlet")
public class ProfiloServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = (String) request.getSession().getAttribute("user");
        String sql = "SELECT * FROM Utenti WHERE username = ?";
        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB", "app", "aa");) {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user);
            ResultSet rs = stmt.executeQuery();
            request.setAttribute("resultSet", rs);
            request.setAttribute("user",user);
            request.getRequestDispatcher(response.encodeURL("Profilo.jsp")).forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace(); // Handle database errors appropriately
            request.getRequestDispatcher(response.encodeURL("login.jsp")).forward(request, response);


        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String Id = request.getParameter("Id");
        if (Id != null && !Id.isEmpty()) {
            deleteProfile(Id,request,response);
        }

    }

    private void deleteProfile(String Id, HttpServletRequest request, HttpServletResponse response) throws IOException{
        String sql = "DELETE FROM Utenti WHERE Id = ?";
        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB", "app", "aa");) {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(Id));
            int rowsDeleted = stmt.executeUpdate();
            String message;
            if (rowsDeleted > 0) {
                message = "Account eliminato correttamente.";
            } else {
                message = "Errore.";
            }
            request.setAttribute("message", message);
            request.getRequestDispatcher(response.encodeURL("end.jsp")).forward(request, response);

        } catch (SQLException ex) {
            ex.printStackTrace(); // Handle database errors appropriately
            response.sendRedirect("end.jsp"); // Redirect to event list page
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
