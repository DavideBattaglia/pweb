<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

  <meta charset="UTF-8">
  <title>Registrazione</title>
  <link rel="stylesheet" href="styles.css">

</head>
<body>
<%@ include file="navbar.html" %>

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
      <p> Già registrato? <a href="login.html">Accedi</a></p>
    </div>

  </form>
</div>


<script src="./public/js/validation.js"></script>
</body>
</html>
