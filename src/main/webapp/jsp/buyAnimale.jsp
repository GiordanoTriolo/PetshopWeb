<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="it.betacom.dao.*, it.betacom.bean.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="it.betacom.bean.Customer" %>
<jsp:useBean id="c" class="it.betacom.bean.Customer" scope="session"></jsp:useBean>
<jsp:useBean id="a" class="it.betacom.bean.Animale"></jsp:useBean>
<jsp:setProperty property="*" name="c" />
<jsp:setProperty property="*" name="a" />

<%
	Customer customerLoggato = (Customer) session.getAttribute("loggedCustomer");
	if (customerLoggato == null) {
		System.out.println("errore lettura del customer" );
	}

    int matricola = Integer.parseInt(request.getParameter("matricola"));
    Animale animaleAcquistato = AnimaleDao.getRecordByMatricola(matricola);

    	System.out.println("id customer " + customerLoggato.toString());
        animaleAcquistato.setIdCliente(customerLoggato.getId());

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String dataAcquistoFormatted = sdf.format(new Date());
        animaleAcquistato.setDataAcquisto(dataAcquistoFormatted);
        
        AnimaleDao.update(animaleAcquistato); 
       
%>
<!DOCTYPE html>
<html lang="en">
<head>

    <script>
        alert("Acquisto riuscito!");
        window.location.href = "acquistiView.jsp?id=<%= CustomerDao.getIdByUsername(c.getUsername()) %>";
    </script>
</head>
<body>
   
</body>
</html>