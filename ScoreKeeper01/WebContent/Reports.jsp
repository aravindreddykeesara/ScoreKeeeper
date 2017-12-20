<!DOCTYPE html>
<html>
<head>
  <title>Score Keeper</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="styles/reports.css" type="text/css"/> 
  
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Score table</a>
    </div>
    <ul class="nav navbar-nav">
      <li ><a id="goToAdminHomePage" href="#">Home</a></li>
      <li class="active" ><a id="goToReportsPage" href="#">Reports</a></li>
    </ul>
  </div>
</nav>




</body>

<script>

$('#goToAdminHomePage').on('click',function(e){
	
	
	window.location.href = "index.jsp";
	
	
	
});


</script>
</html>