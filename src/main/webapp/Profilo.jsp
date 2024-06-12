<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Lista Utenti</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
<header>
  <%@include file = "navbar.jsp" %>
</header>
<h1>Profilo</h1>
<table border="1">
  <tr>
    <th>ID</th>
    <th>Nome</th>
    <th>Cognome</th>
    <th>Data di Nascita</th>
    <th>Email</th>
    <th>Numero di Telefono</th>
    <th>Username</th>
    <th>Password</th>
    <th>Admin</th>
    <th>Numero di Acquisti</th>
  </tr>
  <%
    ResultSet rs = (ResultSet) request.getAttribute("resultSet");
    String user = (String) request.getAttribute("user");
    if (rs != null) {
      while (rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getInt("Id") + "</td>");
        out.println("<td>" + rs.getString("nome") + "</td>");
        out.println("<td>" + rs.getString("cognome") + "</td>");
        out.println("<td>" + rs.getTimestamp("data_nascita") + "</td>");
        out.println("<td>" + rs.getString("email") + "</td>");
        out.println("<td>" + rs.getString("telefono_cellulare") + "</td>");
        out.println("<td>" + rs.getString("username") + "</td>");
        out.println("<td>" + rs.getString("password") + "</td>");
        out.println("<td>" + rs.getInt("acquisti") + "</td>");
        out.println("</tr>");
        out.println("<tr>");
        out.println("<td>");
        out.println("<form method='post' action='ProfiloServlet'>");
        out.println("<input type='hidden' name='Id' value='" + rs.getInt("Id") + "'>");
        out.println("<button type='submit'>Annulla l'iscrizione</button>");
        out.println("</form>");
        out.println("</tr>");
      }
    }
  %>
</table>
<%@include file = "footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
