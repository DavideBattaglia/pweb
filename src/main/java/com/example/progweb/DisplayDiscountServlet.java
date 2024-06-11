package com.example.progweb;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;


@WebServlet(name = "DisplayDiscountServlet", value = "/DisplayDiscountServlet")
public class DisplayDiscountServlet extends HttpServlet {

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
        PreparedStatement statement2 = null;
        ResultSet resultSet = null;
        ResultSet resultSet2 = null;
        try {
            // Connessione al database
            connection = DriverManager.getConnection("jdbc:derby://localhost:1527/ProgWebDB");
            String query = "SELECT * FROM eventi WHERE sconto <> 0";
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            // Imposta il resultSet come attributo della richiesta
            request.setAttribute("resultSet", resultSet);

            String query2 = "SELECT * FROM eventi ORDER BY Click DESC";
            statement2 = connection.prepareStatement(query2);
            resultSet2 = statement2.executeQuery();
            // Imposta il resultSet come attributo della richiesta
            request.setAttribute("resultSet2", resultSet2);


            request.getRequestDispatcher(response.encodeURL("/index.jsp")).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        } finally {
            // Chiude le risorse
            if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    }
}

