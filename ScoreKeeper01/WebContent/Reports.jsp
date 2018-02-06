
<html>
<head>
  <title>Score Keeper</title>
 <!-- Author : Aravind Reddy Keesara -->
<meta charset="utf-8">
  <meta name="Description" content="d3 analysis of player's scores with barchart">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="styles/reports.css" type="text/css"/> 
  
 <script type="text/javascript" src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
   <script src="https://d3js.org/d3.v4.min.js"></script>
  
  
</head>
<body>

<!-- Static navbar -->
    <div class="navbar navbar-inverse navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="index.jsp">ScoreKeeper</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="Reports.jsp">Reports</a></li>
            <li><a href="contact.html">Contact</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>
    

<div class="container">
  <br>
  <br>
  <p>You can analyse the scores in two ways.One is to see the overall score of every player in the game by Selecting the "Compreshensive" tab. Or you can compare the scores of every round between any two players by Selecting the "compare" tab </p>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#Comprehensive">Comprehensive</a></li>
    <li><a data-toggle="tab" href="#Compare">Compare</a></li>
  </ul>
  
  <div class="tab-content">
    <div id="Comprehensive" class="tab-pane fade in active">
      <h3>Overall Score Analysis</h3>
        <p> Make sure to add some player data and scores in Home page to see magic below</p>
        <div class="container text-center" id="barChart"></div>  
    </div>
    <div id="Compare" class="tab-pane fade">
      <h3>Detailed comparision between selected players</h3>
        <p> Make sure to add some player data and scores in Home page to see magic below</p>
        <div class="row text-center">
            <div class="col-sm-4">
           
                <label>Player -1 <img src="images/bluePlayer.png"></label>
                    <select name="PlayerName01" class="form-control" id= "PlayerName01">
                    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     				 <c:forEach items="${Playerdatalist}" var="obj">
     				 <option>${obj.getPlayerName()}</option>
                       
    				 </c:forEach>      
                     </%@>
                        
                </select>
               <br>
            </div>
            <div class="col-sm-4">
            
                <button class="btn btn-primary" type="button" id="chartclick"> compare</button>
            
            </div>
            <div class="col-sm-4">
            <br>
             <label>Player -2 <img src="images/redPlayer.png"></label>
                    <select name="PlayerName02" class="form-control" id= "PlayerName02">
                    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     				 <c:forEach items="${Playerdatalist}" var="obj">
     				 <option>${obj.getPlayerName()}</option>
                       
    				 </c:forEach>      
                     </%@>
                        
                </select>
            </div>
 
        </div>
        
         <div class="container text-right" id="linechart"></div>  
        
    </div>
  </div>
</div>



</body>

<script>

$('#goToAdminHomePage').on('click',function(e){		
	window.location.href = "index.jsp";
});

 
var checkarray = ${Playerdatalist};

    

$('#chartclick').on('click',function(e){	
    
    
    $("#linechart").empty();
    var Playerone = $('#PlayerName01').val();
    var Playertwo = $('#PlayerName02').val();
    var PlayerDataArray01 = [];
    var PlayerDataArray02 = [];
    
    for(var i=0;i<checkarray.length;i++){
        
        console.log("name matched" + Playerone)
        
        if(Playerone === checkarray[i].PlayerName){
            
            console.log(" matched 2" + Playerone)
            
            PlayerDataArray01 = checkarray[i].roundScore;
            
        }
        
        
    }
    
      for(var i=0;i<${Playerdatalist.size()};i++){
        
        if(Playertwo === checkarray[i].PlayerName){
            
            PlayerDataArray02 = checkarray[i].roundScore;
            
        }
        
        
    }
    
    dslinechart(PlayerDataArray01,PlayerDataArray02);
	
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
    

    
function dslinechart(PlayerDataArray01,PlayerDataArray02){
    
  console.log("entered here linecgart");
        
  var basics = dsBarChartBasics();
  
  var margin = basics.margin,
    width = basics.width,
     height = basics.height,
    colorBar = basics.colorBar,
    barPadding = basics.barPadding
    ;
    


var xaxisarray = [];
   
for (var i = 1; i <= PlayerDataArray01.length; i++) {
   xaxisarray.push(i);
 }

class dataclass {
    
   constructor(roundnumber,roundscorevaluePerson01,roundscorevaluePerson02){
       
       this.roundnumber = roundnumber;
       this.roundscorevaluePerson01 = roundscorevaluePerson01;
       this.roundscorevaluePerson02 = roundscorevaluePerson02;
   }
}
  
var arraydata = [];

for(var i = 0;i<PlayerDataArray01.length;i++){ 
    var p = new dataclass(xaxisarray[i],PlayerDataArray01[i],PlayerDataArray02[i]);    
    arraydata.push(p);      
}
    
console.log("arraydata " + JSON.stringify(arraydata));
    
// set the ranges
var x = d3.scaleLinear().range([0, width]);
var y = d3.scaleLinear().range([height, 0]);

// define the line
var valueline = d3.line()
    .x(function(d) { return x(d.roundnumber); })
    .y(function(d) { return y(d.roundscorevaluePerson01); });

var valueline2 = d3.line()
    .x(function(d) { return x(d.roundnumber); })
    .y(function(d) { return y(d.roundscorevaluePerson02); });

var div = d3.select("#linechart").append("div")
    .attr("class", "tooltip")
    .style("opacity", 0);

 //append the svg obgect to the body of the page
// appends a 'group' element to 'svg'
// moves the 'group' element to the top left margin
var svg = d3.select("#linechart").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");

// Get the data


  // scale the range of the data
  x.domain(d3.extent(arraydata, function(d) { return d.roundnumber; }));
  y.domain([0, d3.max(arraydata, function(d) { return Math.max(d.roundscorevaluePerson01,d.roundscorevaluePerson02); })]);

  // add the valueline path.
  svg.append("path")
     .data([arraydata])
     .attr("class", "line")
     .attr("d", valueline);
    
    svg.append("path")
      .data([arraydata])
      .attr("class", "line")
      .style("stroke", "red")
      .attr("d", valueline2);
    
   // add the dots with tooltips
  svg.selectAll("dot")
     .data(arraydata)
   .enter().append("circle")
     .attr("r", 5)
     .attr("cx", function(d) { return x(d.roundnumber); })
     .attr("cy", function(d) { return y(d.roundscorevaluePerson01); })
     .on("mouseover", function(d) {
       div.transition()
         .duration(200)
         .style("opacity", .9);
       div.html("round : " + d.roundnumber + "<br/>" + "score :"+ d.roundscorevaluePerson01)
         .style("left", (d3.event.pageX) + "px")
         .style("top", (d3.event.pageY - 28) + "px");
       })
     .on("mouseout", function(d) {
       div.transition()
         .duration(500)
         .style("opacity", 0);
       });  
  
    //for line 2
    svg.selectAll("dot")
     .data(arraydata)
   .enter().append("circle")
     .attr("r", 5)
     .attr("cx", function(d) { return x(d.roundnumber); })
     .attr("cy", function(d) { return y(d.roundscorevaluePerson02); })
     .on("mouseover", function(d) {
       div.transition()
         .duration(200)
         .style("opacity", .9);
       div.html("round : " + d.roundnumber + "<br/>" + "score :"+ d.roundscorevaluePerson02)
         .style("left", (d3.event.pageX) + "px")
         .style("top", (d3.event.pageY - 28) + "px");
       })
     .on("mouseout", function(d) {
       div.transition()
         .duration(500)
         .style("opacity", 0);
       });  


  // add the X Axis
  svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x));

  // add the Y Axis
  svg.append("g")
      .call(d3.axisLeft(y));


    
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
  
  var yScale = d3.scale.linear()
       .domain([0, d3.max(DataArray, function(d) { return d.PlayerScore; })])
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
      .attr("class", "xAxis");     

}


    
</script>



</html>