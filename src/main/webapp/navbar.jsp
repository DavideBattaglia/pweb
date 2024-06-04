<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navbar Bootstrap 5.3.0 Alpha1</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="img/zughri.png" alt="Logo" width="30" height="30" class="d-inline-block align-text-top">
            Logo
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="<%= response.encodeURL("index.jsp") %>">Home</a>
                </li>
                <div class="dropdown">
                    <button class="dropbtn">Eventi
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content">
                        <a href="<%= response.encodeURL("DisplayConcerti") %>">Concerti</a>
                        <a href="<%= response.encodeURL("DisplaySpettacoliTeatrali") %>">Spettacoli teatrali</a>
                        <a href="<%= response.encodeURL("DisplayEventiSportivi") %>">Eventi Sportivi</a>
                        <a href="<%= response.encodeURL("DisplayVisiteGuidate") %>">Visite guidate</a>
                    </div>
                </div>
                <li class="nav-item">
                    <a class="nav-link" href="<%= response.encodeURL("") %>">Contatti</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
