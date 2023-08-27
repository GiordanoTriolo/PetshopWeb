<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout confermato</title>
    <!-- Collegamento ai CSS di Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFA500; /* Colore arancione */
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .content {
            text-align: center;
        }
        .loader-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .loader {
            border: 8px solid #f3f3f3; /* Colore grigio per il bordo */
            border-top: 8px solid #3498db; /* Colore blu per il top del bordo */
            border-radius: 50%;
            width: 50px;
            height: 50px;
            animation: spin 2s linear infinite; /* Animazione di rotazione */
            margin-bottom: 10px;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="content">
        <h1 class="display-4">Utente sloggato</h1>
        <p class="lead">La tua sessione è stata chiusa correttamente. Grazie per aver utilizzato il nostro servizio.</p>
        <div class="loader-container">
            <div class="loader"></div>
        </div>
    </div>
    <script>
        setTimeout(function() {
            window.location.href = "http://localhost:8080/PetshopWeb/jsp/homepage.jsp";
        }, 1000); 
    </script>
</body>
</html>