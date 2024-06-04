<%--
  Created by IntelliJ IDEA.
  User: doghr
  Date: 29/05/2024
  Time: 12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">

</head>
<body>
<header>
    <%@include file = "navbar.jsp" %>
</header>

<main>
    <div class="container">
        <h1>Welcome to Zughri events</h1>
        <p>Benvenuti a Zugri Eventi, il tuo portale per vivere al massimo il tuo tempo libero a Trento e dintorni</p>

        <% if (Boolean.TRUE.equals(session.getAttribute("urlRewriting"))) { %>
        <p>Stai navigando con URL rewriting abilitato.</p>
        <% } else { %>
        <p>Stai navigando con i cookie abilitati.</p>
        <% } %>

        <div class="buttons">
            <a href="<%= response.encodeURL("registra.jsp") %>"> <button class="btn">Registra</button></a>
            <a href="<%= response.encodeURL("login.jsp") %>"> <button class="btn">Login</button></a>
        </div>
    </div>
</main>

    <%@include file = "footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
