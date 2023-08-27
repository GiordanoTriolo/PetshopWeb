<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page
	import="it.betacom.dao.ClienteDao, it.betacom.bean.*,java.util.*"%>
<%@page
	import="it.betacom.dao.CustomerDao, it.betacom.bean.*,java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
    <%
	Cliente user = (Cliente) session.getAttribute("loggedUser");
    Customer customer = (Customer) session.getAttribute("loggedCustomer");
    
	if (user != null) {
		System.out.println("Nome utente loggato: " + user.getNome());
		System.out.println("Ruolo utente loggato: " + user.getRuolo());
		
		if (user.getId() == 0) {
	        int userId = ClienteDao.getIdByUsername(user.getUsername());
	        user.setId(userId);
	    }
		
		System.out.println("id utente loggato " + user.getId());
	}
	
	boolean isCustomer = false;
	if (customer != null) {
	    System.out.println("Nome utente loggato (Customer): " + customer.getNome());
	    
	    if (customer.getId() == 0) {
	        int customerId = CustomerDao.getIdByUsername(customer.getUsername());
	        customer.setId(customerId);
	    }
	    
	    System.out.println("id cliente loggato " + customer.getId());
	    isCustomer = true;
	}

	boolean isManager = false;
	if (user != null && "M".equals(user.getRuolo())) {
		isManager = true;
	}
	
	boolean isLogged = false;
	if(user != null || customer != null){
		isLogged = true;
	}
	%>
    
    
<!DOCTYPE html>
<html lang="en" class=""><head>
<!-- basic -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- mobile metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<!-- site metas -->
<title>D-pot</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="author" content="">	
<!-- bootstrap css -->
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<!-- style css -->
<link rel="stylesheet" type="text/css" href="../css/style.css">
<!-- Responsive-->
<link rel="stylesheet" href="css/responsive.css">
<!-- fevicon -->
<link rel="icon" href="images/fevicon.png" type="../image/gif">
<!-- Scrollbar Custom CSS -->
<link rel="stylesheet" href="../css/jquery.mCustomScrollbar.min.css">
<!-- Tweaks for older IEs-->
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
<!-- owl stylesheets --> 
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">

	<style type="text/css">
		.fancybox-margin{margin-right:17px;}
	</style>
	<style type="text/css">
		.fancybox-margin{margin-right:17px;}
	</style>
	<style type="text/css">
		.fancybox-margin{margin-right:0px;}
	</style>
</head>
<body>
	<!-- section banner start -->
	<div class="header_section">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-7">
				
			</div>
			<div class="col-md-5">
				<div class="menu_text text-right"> 
					<ul>
						<%if(isLogged == false && isCustomer == true) {%>
						<li class="last" id="registerButton"><a href="../customerRegister.html">Register</a></li>
        				<li class="last" id="loginButton"><a href="../customerLogin.html">Login</a></li>
        				<%} else if(isLogged == false) {%>
						<li class="last" id="registerButton"><a href="../index.html">Register</a></li>
        				<li class="last" id="loginButton"><a href="../login.html">Login</a></li>
        				<%} %>
        				<%if(isLogged) {%>
        				<li class="last" id="logoutButton"><a href="<%=request.getContextPath()%>/sessionservlet">Logout</a></li>
        				<%} %>
						
						<%if(isLogged) {%>
						<li class="active">
						 <div id="myNav" class="overlay">
                            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
                         <div class="overlay-content">
                         	<a href="homepage.jsp">Home</a>
                         	<%if(isCustomer == false){ %>
                            	<a href="table.jsp">Lista utenti</a>
                            	<a href="customerTable.jsp">Lista clienti</a>
                            	<a href="tableanimali.jsp">I nostri animali</a>
                            <%} else if(isCustomer){ %>
                            	<a href="customerTableAnimali.jsp">I nostri animali</a>
                            	<a href="acquistiView.jsp?id=${CustomerDao.getIdByUsername(c.getUsername())}">I tuoi acquisti</a>
                            <%}%>
                          </div>
                        </div>
                         <span style="font-size:30px;cursor:pointer" onclick="openNav()">☰ Menu</span>
                         </li>
                         <%} %>
                    </ul>
                </div>	
            </div>
        </div>
    </div>
		<div class="banner_main">
			<div class="container">
				<div class="ram">
					<div class="row">
					    <div class="col-sm-12">
						    <h1 class="taital">Best Pet Shop</h1>
						    <p class="consectetur_text">Trova il tuo nuovo migliore amico</p>
						    <div class="banner_bt">
						    	
						    </div>
					    </div>
				    </div>
				</div>
				<div class="box">
					
				</div>
			</div>
		</div>
	</div>
	<div class="about_section">
		
	</div>


    <!-- Javascript files-->
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
      <script src="js/jquery-3.0.0.min.js"></script>
      <script src="js/plugin.js"></script>
      <!-- sidebar -->
      <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
      <script src="js/custom.js"></script>
      <!-- javascript --> 
      <script src="js/owl.carousel.js"></script>
      <script src="https:cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
      <script>
      $(document).ready(function(){
      $(".fancybox").fancybox({
         openEffect: "none",
         closeEffect: "none"
         });
         
         $(".zoom").hover(function(){
         
         $(this).addClass('transition');
         }, function(){
         
         $(this).removeClass('transition');
         });
         });
         </script> 


   <script>
    function openNav() {
    document.getElementById("myNav").style.width = "100%";
    }

    function closeNav() {
   document.getElementById("myNav").style.width = "0%";
   }
</script>
     

</body></html>