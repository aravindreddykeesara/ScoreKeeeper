
<html>
<head>
  <title>Score Keeper</title>
 <!-- Author : Aravind Reddy Keesara -->
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="styles/reports.css" type="text/css"/> 
  
 <script type="text/javascript" src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
  
  
  
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


    
          <div class="container text-center" id="barChart"></div>  

   


</body>

<script>

$('#goToAdminHomePage').on('click',function(e){		
	window.location.href = "index.jsp";
});

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

var dataArray = [
    <c:forEach items="${Playerdatalist}" var="obj">
    {
        PlayerName :"<c:out value="${obj.getPlayerName()}"/>",
        PlayerScore : "<c:out value="${obj.getPlayerScore()}"/>"
    },
    </c:forEach>
    ];
console.log(" data array = " +  dataArray);


dsBarChart(dataArray);

function dsBarChartBasics() {

    var margin = {top: 30, right: window.innerWidth*0.1, bottom: 50, left: window.innerWidth*0.1},
    width =  (window.innerWidth*0.8*0.9) - margin.left - margin.right,
     height = Math.ceil(window.innerHeight*0.7) - margin.top - margin.bottom,
    colorBar = d3.scale.category20(),
    barPadding = 1
    ;
    
    return {
      margin : margin, 
      width : width, 
      height : height, 
      colorBar : colorBar, 
      barPadding : barPadding
    }     
    ;
}

function dsBarChart(DataArray) {
	
 

	console.log("data arraya value " + DataArray.length);
  
  var basics = dsBarChartBasics();
  
  var margin = basics.margin,
    width = basics.width,
     height = basics.height,
    colorBar = basics.colorBar,
    barPadding = basics.barPadding
    ;
          
  var   xScale = d3.scale.linear()
            .domain([0, DataArray.length])
            .range([0, width])
            ;
            
  // Create linear y scale

// parse easch value of score to int
  DataArray.forEach(function(d) {
            d.PlayerName = d.PlayerName;
           
            d.PlayerScore = parseInt(d.PlayerScore);
        });
  // Purpose: No matter what the data is, the bar should fit into the svg area; bars should not
  // get higher than the svg height. Hence incoming data needs to be scaled to fit into the svg area.  
  var yScale = d3.scale.linear()
      // use the max funtion to derive end point of the domain (max value of the dataset)
      // do not use the min value of the dataset as min of the domain as otherwise you will not see the first bar
       .domain([0, d3.max(DataArray, function(d) { return d.PlayerScore; })])
       // As coordinates are always defined from the top left corner, the y position of the bar
       // is the svg height minus the data value. So you basically draw the bar starting from the top. 
       // To have the y position calculated by the range function
       .range([height, 0])
       ;
  
  //Create SVG element
  
  console.log("max height y axis " + d3.max(DataArray, function(d) { return d.PlayerScore; }));
  
  var svg = d3.select("#barChart")
      .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .attr("id","barChartPlot")
        ;
  
  var plot = svg
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
        ;
  
  //generate random color value 
  function getRandomColor() {
  var lettersUsedForColors = '0123456789ABCDEF';
  var colorValue = '#';
  for (var i = 0; i < 6; i++) {
    colorValue += lettersUsedForColors[Math.floor(Math.random() * 16)];
  }
  return colorValue;
}
              
  plot.selectAll("rect")
       .data(DataArray)
       .enter()
       .append("rect")
      .attr("x", function(d, i) {
          return xScale(i);
      })
       .attr("width", width / DataArray.length - barPadding)   
      .attr("y", function(d) {
          return yScale(d.PlayerScore);
      })  
      .attr("height", function(d) {
          return height-yScale(d.PlayerScore);
      })
      .attr("fill", getRandomColor())
      ;
  
    
  // Add y labels to plot 
  
  plot.selectAll("text")
  .data(DataArray)
  .enter()
  .append("text")
  .text(function(d) {
      return d3.round(d.PlayerScore);
  })
  .attr("text-anchor", "middle")
  // Set x position to the left edge of each bar plus half the bar width
  .attr("x", function(d, i) {
      return (i * (width / DataArray.length)) + ((width / DataArray.length - barPadding) / 2);
  })
  .attr("y", function(d) {
      return yScale(d.PlayerScore)-4;
  })
  .attr("class", "yAxis")
 
  ;
  
  // Add x labels to chart  
  
  var xLabels = svg
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + (margin.top + height)  + ")")
        ;
  
  xLabels.selectAll("text.xAxis")
      .data(DataArray)
      .enter()
      .append("text")
      .text(function(d) { return d.PlayerName;})
      .attr("text-anchor", "middle")
      // Set x position to the left edge of each bar plus half the bar width
               .attr("x", function(d, i) {
                  return (i * (width / DataArray.length)) + ((width / DataArray.length - barPadding) / 2);
               })
      .attr("y", 15)
      .attr("class", "xAxis")
      //.attr("style", "font-size: 12; font-family: Helvetica, sans-serif")
      ;     
   
  // Title
  
  svg.append("text")
    .attr("x", (width + margin.left + margin.right)/2)
    .attr("y", 15)
    .attr("class","title")        
    .attr("text-anchor", "middle")
    .text("Score Analysis")
    ;
}





</script>
</html>