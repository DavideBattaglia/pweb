package com.example.progweb;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/loadDiscountedEvents")
public class LoadDiscountedEventsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB", "app", "aa");
             PreparedStatement statement = connection.prepareStatement("SELECT * FROM Eventi WHERE sconto <> 0;");
             ResultSet resultSet = statement.executeQuery()) {

            // Set the ResultSet as a request attribute
            request.setAttribute("events", resultSet);

            // Forward request to the JSP for display
            RequestDispatcher dispatcher = request.getRequestDispatcher("aa.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException ex) {
            // Log the exception details
            System.err.println("Error fetching events: " + ex.getMessage());
            // Set a more specific error status code (e.g., 503 Service Unavailable)
            response.setStatus(503);
        }
    }
}
