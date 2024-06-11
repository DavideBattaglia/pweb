<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Crea Nuovo Evento</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<header>
  <%@include file ="navbar.jsp"%>
</header>
<div class="container mt-5">
  <h1>Crea Nuovo Evento</h1>
  <form method="post" action="CreaEventoServlet">
    <div class="mb-3">
      <label for="tipoEvento" class="form-label">Tipo Evento</label>
      <select class="form-control" id="tipoEvento" name="tipoEvento" required>
        <option value="concerti">Concerti</option>
        <option value="eventi sportivi">Eventi Sportivi</option>
        <option value="visite guidate">Visite Guidate</option>
        <option value="spettacoli teatrali">Spettacoli Teatrali</option>
      </select>
    </div>
    <div class="mb-3">
      <label for="nomeEvento" class="form-label">Nome Evento</label>
      <input type="text" class="form-control" id="nomeEvento" name="nomeEvento" required>
    </div>
    <div class="mb-3">
      <label for="dataOra" class="form-label">Data e Ora</label>
      <input type="datetime-local" class="form-control" id="dataOra" name="dataOra" required>
    </div>
    <div class="mb-3">
      <label for="localita" class="form-label">Località</label>
      <input type="text" class="form-control" id="localita" name="localita" required>
    </div>
    <div class="mb-3">
      <label for="postiASedere" class="form-label">Posti a Sedere</label>
      <input type="number" class="form-control" id="postiASedere" name="postiASedere" required>
    </div>
    <div class="mb-3">
      <label for="postiInPiedi" class="form-label">Posti in Piedi</label>
      <input type="number" class="form-control" id="postiInPiedi" name="postiInPiedi" required>
    </div>
    <div class="mb-3">
      <label for="prezzoASedere" class="form-label">Prezzo a Sedere</label>
      <input type="number" step="0.01" class="form-control" id="prezzoASedere" name="prezzoASedere" required>
    </div>
    <div class="mb-3">
      <label for="prezzoInPiedi" class="form-label">Prezzo in Piedi</label>
      <input type="number" step="0.01" class="form-control" id="prezzoInPiedi" name="prezzoInPiedi" required>
    </div>
    <div class="mb-3">
      <label for="immagine" class="form-label">Immagine (URL)</label>
      <input type="text" class="form-control" id="immagine" name="immagine" required>
    </div>
    <div class="mb-3">
      <label for="sale" class="form-label">Sale</label>
      <input type="number" class="form-control" id="sale" name="sale" required>
    </div>
    <button type="submit" class="btn btn-primary">Crea Evento</button>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
