<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="c" class="it.betacom.bean.Cliente"></jsp:useBean>
<%@page import="it.betacom.dao.*" %>
<%@page import="it.betacom.bean.*" %>
<jsp:setProperty property="*" name="c"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Ruolo JSP</title>
</head>
<body>
	<%
	Cliente cliente = ClienteDao.getRecordByUsername(request.getParameter("username"));
	%>
	
	
    <%-- Rimuovi il codice di aggiornamento e il redirect --%>
    <% if (cliente.getRuolo().equals("G")) { %>
        <%-- Aggiungi il codice per rendere il cliente Manager --%>
        <% ClienteDao.updateRuoloManager(cliente); %>
        <%-- Mostra il messaggio di conferma usando JavaScript --%>
        <script>
            alert("Ruolo aggiornato a Manager con successo!");
            window.location.href = "table.jsp";
        </script>
    <% } else if (cliente.getRuolo().equals("M")) { %>
        <%-- Aggiungi il codice per rendere il cliente Guest --%>
        <% ClienteDao.updateRuoloGuest(cliente); %>
        <%-- Mostra il messaggio di conferma usando JavaScript --%>
        <script>
            alert("Ruolo aggiornato a Guest con successo!");
            window.location.href = "table.jsp";
        </script>
    <% } %>
</body>
</html>