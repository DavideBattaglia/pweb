package web.gvarni.servletfinal;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import com.google.gson.Gson;

@WebServlet(name = "GetData", value = "/GetAllData")
public class GetAllData extends HttpServlet {
    String dbURL = "jdbc:derby://localhost:1527/ProgWebDB";
    String user = "APP";
    String password = "admin";
    Connection connection = null;

    @Override
    public void init(ServletConfig config) throws ServletException {
        try {
            super.init(config);
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection = DriverManager.getConnection(dbURL, user, password);
        } catch (ClassNotFoundException | NullPointerException | SQLException ex) {
            System.out.println(ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve all city data
        List<City> cities = getAllCities();

        // Convert city list to JSON
        Gson gson = new Gson();
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < cities.size(); i++) {
            City city = cities.get(i);
            json.append(gson.toJson(city));
            if (i < cities.size() - 1) {
                json.append(",");  // Add comma for each object except the last
            }
        }
        json.append("]");

        // Prepare JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        try (PrintWriter out = response.getWriter()) {
            out.println(json);
        }
    }

    private List<City> getAllCities() {
        List<City> cities = new ArrayList<>();

        try (Statement stmt = connection.createStatement();
             ResultSet results = stmt.executeQuery("SELECT * FROM CITIES")) {
            while (results.next()) {
                City city = new City();
                city.setName(results.getString("NAME_CITY"));
                city.setRegion(results.getString("NAME_REGION"));
                city.setArea(results.getFloat("SQRM"));
                city.setPopulation(results.getInt("NUM_PEOPLE"));
                cities.add(city);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }

        return cities;
    }

    @Override
    public void destroy() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }
}
