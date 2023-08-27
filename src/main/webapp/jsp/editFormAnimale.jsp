
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="it.betacom.dao.AnimaleDao, it.betacom.bean.*,java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Updating Animale</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<link rel="stylesheet" href="../css/editform.css">
</head>
<body>

	<%
	String matricola = request.getParameter("matricola");
	Animale a = AnimaleDao.getRecordByMatricola(Integer.parseInt(matricola));
	%>
	<div class="container">
		<form action="editAnimale.jsp" method="post">


			<section class="ftco-section">
				<div class="card-form">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title text-center">Modifica Animale</h5>
							<div class="table-responsive">
								<table class="table">
									<tr>
										<td><input type="hidden" name="matricola"
										value="<%=a.getMatricola()%>" />
									</tr>
									<tr>
										<th>Nome animale</th>
										<td><input type="text" name="nomeAnimale"
											value="<%=a.getNomeAnimale()%>" /></td>
									</tr>
									<tr>
										<th>Tipo</th>
										<td><input type="text" name="tipoAnimale"
											value="<%=a.getTipoAnimale()%>" /></td>
									</tr>
									<tr>
										<th>Prezzo</th>
										<td><input type="text" name="prezzo"
											value="<%=a.getPrezzo()%>" /></td>
									</tr>
									<tr>
										<td colspan="2">
											<button type="submit" class="btn btn-primary">Conferma</button>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</section>
		</form>
	</div>
</body>
</html>
