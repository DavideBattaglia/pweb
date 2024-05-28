<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registrazione Utente</title>
    <style>
        .error-message {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h1>Registrazione Utente</h1>

<p class="error-message">ERRORE ERRORE QUETSA PAGINA NON VA</p>
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


    <button type="submit">Registrati</button>
</form>

<%-- Handle password error --%>
<%
    // Get error attribute from request (use a generic message initially)
    String errorMessage = (String) request.getAttribute("passwordError");
    if (errorMessage == null) {
        errorMessage = "Si è verificato un errore PASSWORD";
    }

    // Display error message if present
    if (errorMessage != null) {
%>
<p class="error-message"><%= errorMessage %></p>
<%
    }
%>
</body>
</html>
