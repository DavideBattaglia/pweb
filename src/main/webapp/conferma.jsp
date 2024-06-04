<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>Conferma Ordine</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>

<header>
  <%@include file = "navbar.jsp" %>
</header>

<div class="container mt-5">
  <h1>Conferma Ordine</h1>
  <p style="text-align: center; color: darkgreen"><strong>Il tuo ordine e andato a buon fine!</strong></p>
  <div class="container1">
    <div class="event-buttons">
      <button class="btn btn-primary" onclick="goToEvents()">Visualizza Eventi</button>
      <button class="btn btn-primary" onclick="goToMusicEvents()">Visualizza Eventi Musicali</button>
      <button class="btn btn-primary" onclick="goToSportEvents()">Visualizza Eventi Sportivi</button>
      <button class="btn btn-primary" onclick="goToTheaterEvents()">Visualizza Eventi Teatrali</button>
    </div>

    <button class="btn btn-danger mt-3" onclick="logout()">Logout</button>
  </div>
  <script>
    function goToEvents() {
      window.location.href = "events.jsp"; // Replace with the actual URL for events.jsp
    }

    function goToMusicEvents() {
      window.location.href = "events-music.jsp"; // Replace with the actual URL for events-music.jsp
    }

    function goToSportEvents() {
      window.location.href = "events-sport.jsp"; // Replace with the actual URL for events-sport.jsp
    }

    function goToTheaterEvents() {
      window.location.href = "events-theater.jsp"; // Replace with the actual URLs for events-theater.jsp
    }

    function logout() {
      window.location.href = "logout.jsp"; // Replace with the actual URL for logout.jsp
    }
  </script>
</div>

<%@include file = "footer.html" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
