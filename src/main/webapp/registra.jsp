<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

  <meta charset="UTF-8">
  <title>Registrazione</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

  <link rel="stylesheet" href="styles.css">

</head>

<header>
  <%@include file = "navbar.jsp" %>
</header>

<body>
<div class="container1">
  <h1>Registrazione Utente</h1>
  <form action="./RegistrationServlet" method="post">
    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome" required><br>

    <label for="cognome">Cognome:</label>
    <input type="text" id="cognome" name="cognome" required><br>

    <label for="data_nascita">Data di Nascita (GG/MM/AAAA):</label>
    <input type="date" id="data_nascita" name="data_nascita" required><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br>

    <label for="telefono_cellulare">Telefono Cellulare:</label>
    <input type="tel" id="telefono_cellulare" name="telefono_cellulare" pattern="[0-9]{10}" required><br>

    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br>

    <label for="conferma_password">Conferma Password:</label>
    <input type="password" id="conferma_password" name="conferma_password" required><br>

    <div class="buttons">
      <button onclick="return performRegister()" type="submit"  class="btn" >Registrati</button>
      <p> Già registrato? <a href="<%= response.encodeURL("login.jsp") %>">Accedi</a></p>
    </div>

  </form>
</div>

<%@include file = "footer.html" %>

<script src="./public/js/validation.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
