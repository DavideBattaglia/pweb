package com.example.logintest;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.UnavailableException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {

    public void init(ServletConfig config)throws ServletException{
        super.init(config);
        try {
           Class.forName("org.apache.derby.jdbc.ClientDriver");
        }catch(ClassNotFoundException e){
           throw new UnavailableException("TransactionConnection.init( ) ClassNotFoundException: " +e.getMessage());
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
            String query = "SELECT * FROM USERS WHERE USERNAME = ? AND PASSWORD = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                response.sendRedirect("welcome.jsp");
            } else {
                response.sendRedirect("login.jsp?error=true");
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
