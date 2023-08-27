<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="it.betacom.dao.ClienteDao" %>
<jsp:useBean id="c" class="it.betacom.bean.Cliente" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="c"/>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Risultato Login</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
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
        <h1 class="display-4">Login...</h1>
        <div class="loader-container mt-4">
            <div class="loader"></div>
        </div>
    </div>
                <%
                boolean accessoEffettuato = ClienteDao.login(c);
                if (accessoEffettuato) {
                    // Azzera il contatore di tentativi falliti se il login ha successo
                    c.setFailedLoginAttempts(0);
                    ClienteDao.updateStatusEnabled(c);
                    session.setAttribute("loggedUser", ClienteDao.getRecordByUsername(c.getUsername()));
                    %>
                    <script>
                        alert('Accesso Effettuato');
                        document.body.classList.add('success');
                        window.location.href = "http://localhost:8080/PetshopWeb/jsp/homepage.jsp";
                    </script>
                    <% 
                } else if (ClienteDao.getRecordByUsername(c.getUsername()).getStatus().equals("D")) {  
                    %>
                    <script>
                        alert('Account disabilitato, contattare l\'amministratore!');
                        window.location.href = "http://localhost:8080/PetshopWeb/index.html";
                    </script>
                    <%    
                } else if (ClienteDao.getRecordByUsername(c.getUsername()).getStatus().equals("A") && c.getFailedLoginAttempts() >= 3) { %>
                    <%  ClienteDao.updateStatusDisabled(c); %>
                    <script>
                        alert('Hai superato il limite massimo di tentativi falliti. Il tuo account è stato disabilitato');
                        window.location.href = "http://localhost:8080/PetshopWeb/index.html";
                    </script>
                    <%
                } else {
                    // Incrementa il contatore di tentativi falliti
                    c.incrementFailedLoginAttempts();
                    %>
                    <script>
                        alert('Accesso Fallito. Tentativi rimanenti: <%= 3 - c.getFailedLoginAttempts() %>');
                        document.body.classList.add('error');
                        // Rimanda alla stessa pagina
                        window.location.href = "http://localhost:8080/PetshopWeb/index.html";
                    </script>
                    <%
                }
                %>
</body>
</html>