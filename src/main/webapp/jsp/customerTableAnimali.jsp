<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="it.betacom.dao.*, it.betacom.bean.*, java.util.*"%>
<%@ page import="it.betacom.bean.Customer"%>
<jsp:useBean id="c" class="it.betacom.bean.Customer" scope="session"></jsp:useBean>
<jsp:useBean id="a" class="it.betacom.bean.Animale"></jsp:useBean>
<jsp:setProperty property="*" name="c" />
<jsp:setProperty property="*" name="a" />


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Table animali</title>
<link rel="stylesheet" href="../css/table.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
</head>


<body style="background-color: orange;">
	<%
	List<Animale> listNonAcquistati = AnimaleDao.getAllRecordsWithNullIdCliente();
	request.setAttribute("listNonAcquistati", listNonAcquistati);

	Customer customerLoggato = (Customer) session.getAttribute("loggedCustomer");
	System.out.println("nome customer prova " + customerLoggato.getNome() + customerLoggato.getCognome());
	System.out.println("id customer prova " + customerLoggato.getId());
	%>


	<div class="container" id="generalContainer">
		<div class="row justify-content-start">
			<!-- Utilizzo di justify-content-start -->
			<div class="col">
				<h2 class="display-4" style="color: black;">Animali
					acquistabili</h2>
				<h2>
					Cliente
					<%=customerLoggato.getNome()%>
					<%=customerLoggato.getCognome()%></h2>
			</div>
			<div class="col-auto">
				<a href="homepage.jsp" class="btn btn-primary" style="color: white;">Home</a>
			</div>
		</div>

		<div class="container">
			<table>
				<thead>
					<tr>
						<th>Matricola</th>
						<th>Nome Animale</th>
						<th>Tipologia</th>
						<th>Prezzo</th>

						<th>Acquista</th>

					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listNonAcquistati}" var="a">
						<tr>
							<td>${a.matricola}</td>
							<td>${a.nomeAnimale}</td>
							<td>${a.tipoAnimale}</td>
							<td>${a.prezzo}</td>

							<td><a href="buyAnimale.jsp?matricola=${a.matricola}" class="btn btn-info">Acquista</a></td>

						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>



</body>
</html>