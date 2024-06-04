<%--
  Created by IntelliJ IDEA.
  User: doghr
  Date: 01/06/2024
  Time: 14:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*, java.sql.ResultSetMetaData" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Spettacoli Teatrali</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="styles.css">

</head>
<body>

<header>
    <%@include file = "navbar.jsp" %>
</header>

<div class="row text-center">
    <% ResultSet resultSet = (ResultSet) request.getAttribute("resultSet"); %>
    <% while (resultSet.next()) { %>
    <div class="col-md-4">
        <div class="card">
            <div class="card-img-top-container">
                <img class="card-img-top" src="<%= resultSet.getObject(3) %>">
            </div>
            <div class="card-body">
                <h4 class="card-title"><%= resultSet.getObject(1) %></h4>
                <p class="card-text"><%= resultSet.getObject(2) %></p>
                <a href="<%= response.encodeURL("") %>" class="btn btn-primary">Acquista Biglietti</a>
            </div>
        </div>
    </div>
    <% } %>
</div>

<%@include file = "footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
