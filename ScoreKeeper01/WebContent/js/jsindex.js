
   $('#addPlayerConfirm').click(function(e){
    
       e.preventDefault();
	
	 var addPlayerName  = $('#addPlayerPlayerName').val();
	 console.log("netered here");
	 
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
 










