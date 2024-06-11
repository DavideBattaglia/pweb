package com.example.progweb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {

    public void init() throws ServletException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Failed to load JDBC driver.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String DB_URL = "jdbc:derby://localhost:1527/ProgWebDB;create=true";
        String DB_USER = "App";
        String DB_PASSWORD = "admin";
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT * FROM UTENTI WHERE USERNAME = ? AND PASSWORD = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {

                boolean isAdmin = resultSet.getBoolean("IsAdmin");
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                if (isAdmin) { // L'utente è un admin
                    session.setAttribute("isAdmin", true);
                    request.getRequestDispatcher("/welcomeAdmin.jsp").include(request, response); // Redirige verso la pagina admin
                } else { // L'utente non è un admin
                    session.setAttribute("isAdmin", false);
                    request.getRequestDispatcher("/welcome.jsp").include(request, response); // Redirige verso la pagina utente normale
                }
            } else {
                request.getRequestDispatcher("./login.jsp").include(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
