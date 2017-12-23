<!DOCTYPE html>
<html>
<head>
  <title>Score Keeper</title>
  <!-- Author : Aravind Reddy Keesara -->
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="styles/index.css" type="text/css"/> 
  
</head>
<body>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Score table</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a id="goToAdminHomePage" href="#">Home</a></li>
      <li><a id="goToReportsPage" href="#">Reports</a></li>
    </ul>
  </div>
</nav>

  
    <div class="container">
  <h2> Player's names and Scores  |  <a href="#" class="btn btn-lg btn-primary" data-toggle="modal" data-target="#addPlayerModal">Add player</a></h2> 
  <br>  
  
  <!--  table to display player names and scores-->  
  <div class="table-responsive">
 	<table class="table">
 	       <thead class="thead-dark">
     			 <tr>
       				 <th>Player Name</th>
       				 <th>Player Score</th>
       				 
     			 </tr>
   			 </thead>
   					
   					 <tbody id="tablebody">
  					  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     					 <c:forEach items="${Playerdatalist}" var="obj">
       			           <tr id = "testrow">
       			     			<td>${obj.getPlayerName()}
       			     			<input  id = "PlayerName" type = "hidden" value="${obj.getPlayerName()}" >
       			     			
       			     			</td>
       							<td>${obj.getPlayerScore()}
       							  <input  id = "PlayerScore" type = "hidden" value="${obj.getPlayerScore()}" >
       							</td>
      							
								<td><input  name="UpdatePlayerScoreValue" id="UpdatePlayerScoreValue" type="number" placeholder="Update score" /></td>
					            <td><a href="#" id = "updatePlayerScore" class="btn btn-lg btn-success padding">Add</a></td>
					            
     			 			 </tr>
   					     </c:forEach>
                                    					 
       			
    				</tbody>
  					</table>
  					
  	</div>
 </div>
  					
 
 <!--  modal for add player button popup -->

<div class="modal fade" id="addPlayerModal" tabindex="-1" role="dialog" aria-labelledby="addPlayerModal" aria-hidden="true">
          <div class="modal-dialog">
         <div class="modal-content">
          <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
             <h4 class="modal-title align" id="addPlayerModalLabel">Add a player</h4>
      </div>
      
    <form action="" method="POST">
        <div class="modal-body">
        
               
                  <div class="form-group">
                    <label>Player Name</label>
                   <input type="text" name="addPlayerPlayerName" id="addPlayerPlayerName" tabindex="1" class="form-control" placeholder="enter player Name" value="">
                </div>
                
                
          <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="submit" id = "addPlayerConfirm" class="btn btn-primary">Add Player</button>
        </div>
        </div>
    </form>
                
        
        
  </div>
  </div>
  </div>
  
  					
  					

</body>

<script type="text/javascript">


$('#addPlayerConfirm').click(function(e){
	
	 var addPlayerName  = $('#addPlayerPlayerName').val();
	 
	 
	 $.ajax({
		   url:"${pageContext.request.contextPath}/HandlingServlet",
		   data:{ action : "addPlayer",
			   addPlayerName : addPlayerName
		   },
		   
		   type: 'post'
           }).done(function (data) {
	   
	     console.log("added sucess");
	 
      }).fail(function (error) {
	   
	  
	   console.log("adding player failure : " + JSON.stringify(error));
	   
     });
	 
	 
	
	
	
});




$('#tablebody').on('click', '#updatePlayerScore', function(e){

	e.preventDefault();
	console.log("enetred update player score ");
	 var currentRow=$(this).closest("tr");
	 var PlayerName =currentRow.find("#PlayerName").val();
	 console.log("player score to be updated  " + PlayerName);
	 var PlayerUpdateScoreValue = currentRow.find("#UpdatePlayerScoreValue").val();
	 
	 $.ajax({
		   url:"${pageContext.request.contextPath}/HandlingServlet",
		   data:{ action : "updatePlayerScore",
			   PlayerName : PlayerName,
			   PlayerUpdateScoreValue : PlayerUpdateScoreValue
		   },
		   
		   type: 'post'
           }).done(function (data) {
	   
        	   window.location.reload();
	     console.log("added sucess");
	 
      }).fail(function (error) {
	   
	  
	   console.log("adding player failure : " + JSON.stringify(error));
	   
     });
	 	
});


$('#goToReportsPage').on('click',function(e){
	
	$.ajax({
		   url:"${pageContext.request.contextPath}/HandlingServlet",
		   data:{ action : "goToReportsPage"
			  
		   },
		   
		   type: 'post'
        }).done(function (data) {
	   
	   window.location.href = "Reports.jsp"
	 
   }).fail(function (error) {
	   
	  
	   console.log(" going to report page failure : " + JSON.stringify(error));
	   
  });
	 
	
	
	
});









</script>
</html>