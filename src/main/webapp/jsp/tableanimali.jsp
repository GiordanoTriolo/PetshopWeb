<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="it.betacom.dao.*, it.betacom.bean.*, java.util.*"%>
<%@ page import="it.betacom.bean.Cliente"%>
<%@ page import="it.betacom.bean.Customer"%>
<jsp:useBean id="u" class="it.betacom.bean.Cliente" scope="session"></jsp:useBean>
<jsp:useBean id="a" class="it.betacom.bean.Animale"></jsp:useBean>
<jsp:setProperty property="*" name="u" />
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
	List<Animale> list = AnimaleDao.getAllRecords();
	request.setAttribute("list", list);

	List<Animale> listNonAcquistati = AnimaleDao.getAllRecordsWithNullIdCliente();
	request.setAttribute("listNonAcquistati", listNonAcquistati);

	Cliente clienteLoggato = (Cliente) session.getAttribute("loggedUser");
	%>


	<div class="container" id="generalContainer">
		<div class="row justify-content-start">
			<!-- Utilizzo di justify-content-start -->
			<div class="col">
				<h2 class="display-4" style="color: black;">Tabella degli
					animali</h2>
				<h2>
					Utente
					<%=clienteLoggato.getNome()%>
					<%=clienteLoggato.getCognome()%></h2>
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
						<th>Data di acquisto</th>
						<th>Tipologia</th>
						<th>Prezzo</th>
						<th>ID Cliente</th>
						<th>Proprietario</th>
						<%
						if (clienteLoggato.getRuolo().equals("M")) {
						%>
						<th>Edit</th>
						<th>Delete</th>
						<%
						}
						%>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="a">
						<tr>
							<td>${a.matricola}</td>
							<td>${a.nomeAnimale}</td>
							<td>${a.dataAcquisto}</td>
							<td>${a.tipoAnimale}</td>
							<td>${a.prezzo}</td>
							<td>${a.idCliente}</td>
							<td>${a.proprietario}</td>
							<%
							if (clienteLoggato.getRuolo().equals("M")) {
							%>
							<td><a href="editFormAnimale.jsp?matricola=${a.matricola}" class="btn btn-warning">Edit</a></td>
							<td><a href="deleteAnimale.jsp?matricola=${a.matricola}" class="btn btn-danger">Delete</a></td>
							<%
							}
							%>
						</tr>
					</c:forEach>
				</tbody>
			</table>


			<div class="row justify-content-center">
				<div class="col-md-6 text-center mt-4">
					<h2 class="heading-section">Animali non acquistati</h2>
					<a href="../newAnimale.html" class="btn btn-info">Inserisci
						nuovo animale</a>
				</div>
			</div>


			<table>
				<thead>
					<tr>
						<th>Matricola</th>
						<th>Nome Animale</th>
						<th>Tipologia</th>
						<th>Prezzo</th>
						<%
						if (clienteLoggato.getRuolo().equals("M")) {
						%>
						<th>Edit</th>
						<th>Delete</th>
						<%
						}
						%>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listNonAcquistati}" var="a">
						<tr>
							<td>${a.matricola}</td>
							<td>${a.nomeAnimale}</td>
							<td>${a.tipoAnimale}</td>
							<td>${a.prezzo}</td>
							<%
							if (clienteLoggato.getRuolo().equals("M")) {
							%>
							<td><a href="editFormAnimale.jsp?matricola=${a.matricola}" class="btn btn-warning">Edit</a></td>
							<td><a href="deleteAnimale.jsp?matricola=${a.matricola}" class="btn btn-danger">Delete</a></td>
							<%
							}
							%>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>