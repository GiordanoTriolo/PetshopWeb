<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="it.betacom.dao.AnimaleDao" %>
<jsp:useBean id="a" class="it.betacom.bean.Animale"></jsp:useBean>
<jsp:setProperty property="*" name="a"/>

<%
boolean salvataggioEffettuato = false;
int i = AnimaleDao.save(a);
if (i > 0) {
    salvataggioEffettuato = true;
} else {
    salvataggioEffettuato = false;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Risultato Salvataggio</title>
    <style>
        .success {
            background-color: #28a745;
        }

        .error {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <%
    if (salvataggioEffettuato) {
        %>
        <script>
            alert('Salvataggio effettuato');
            document.body.classList.add('success');
            window.location.href = "http://localhost:8080/PetshopWeb/jsp/tableanimali.jsp";
        </script>
        <% 
    } else {
        %>
        <script>
            alert('Salvataggio fallito, verrai reindirizzato alla pagina di inserimento');
            window.location.href = "http://localhost:8080/PetshopWeb/newAnimale.html";
        </script>
        <%
    }
    %>
</body>
</html>