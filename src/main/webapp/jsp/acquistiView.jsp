<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="it.betacom.dao.*, it.betacom.bean.*, java.util.*"%>
<%@ page import="it.betacom.bean.Cliente"%>
<jsp:useBean id="u" class="it.betacom.bean.Cliente" scope="session"></jsp:useBean>
<jsp:useBean id="a" class="it.betacom.bean.Animale"></jsp:useBean>
<jsp:setProperty property="*" name="u" />
<jsp:setProperty property="*" name="a" />



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tabella acquisti</title>
<link rel="stylesheet" href="../css/table.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
</head>

<body style="background-color: orange;">

	<%
	String id_customer = request.getParameter("id");
	List<Animale> list = AnimaleDao.getAllRecordsView(Integer.parseInt(id_customer));
	request.setAttribute("list", list);
	String proprietario = AnimaleDao.getNameByIdCliente(Integer.parseInt(id_customer));
	Cliente clienteLoggato = (Cliente) session.getAttribute("loggedUser");
	%>


	<div class="container" id="generalContainer">
		<div class="row justify-content-start">
			<!-- Utilizzo di justify-content-start -->
			<div class="col">
				<h2 class="display-4" style="color: black;">Tabella degli
					acquisti</h2>
				<h2>
					Acquisti di:
					<%=proprietario%></h2>
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
						<th>Nome animale</th>
						<th>Data di acquisto</th>
						<th>Tipo Animale</th>
						<th>Prezzo</th>
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
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>