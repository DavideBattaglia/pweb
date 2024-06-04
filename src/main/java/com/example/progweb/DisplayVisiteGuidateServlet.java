package com.example.progweb;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DisplayVisiteGuidate")
public class DisplayVisiteGuidateServlet extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        try {
            super.init(config);
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException ex) {
            System.out.println(ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            // Connessione al database
            connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB");
            String query = "SELECT NomeEvento, DataOra, Immagine FROM eventi WHERE TipoEvento =?";
            statement = connection.prepareStatement(query);
            statement.setString(1, "visite guidate");
            resultSet = statement.executeQuery();

            // Imposta il resultSet come attributo della richiesta
            request.setAttribute("resultSet", resultSet);
            request.getRequestDispatcher(response.encodeURL("/VisiteGuidate.jsp")).forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            // Chiude le risorse
            if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    }
}
