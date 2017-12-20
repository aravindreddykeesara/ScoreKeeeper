package scorekeeper.servletclass;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import scorekeeper.beanclass.PlayerBean;

@WebServlet("/HandlingServlet")
public class HandlingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String url = "/index.jsp"; 
		 System.out.println("enetres herte servlet");
		   String action = request.getParameter("action");
		  
	        System.out.print("actionvalue "+action);
	        if (action == null) {
	            action = "nothing";  // default action
	        }

	        // perform action and set URL to appropriate page
	        if (action.equals("nothing")) {
	            url = "/index.jsp";    // do nothing, index page
	        } 
	        else if(action.equals("addPlayer")) {
	        	
	        	String playername = request.getParameter("addPlayerName");
	        	
	        	HttpSession session =  request.getSession();
	        	ArrayList<PlayerBean> Playerdatalist ;
	        	
	        	if(session.getAttribute("Playerdatalist")==null){
   	 				
	        		Playerdatalist =  new ArrayList<PlayerBean>();
   	 			}
	        	else{
	        		
	        		Playerdatalist = (ArrayList<PlayerBean>) session.getAttribute("Playerdatalist");
	        	}
	        	
	        	
	        	
	            PlayerBean player = new PlayerBean();
	            
	            player.setPlayerName(playername);
	            player.setPlayerScore(0);
	            
	            Playerdatalist.add(player);
	            
	            session.setAttribute("Playerdatalist", Playerdatalist);
	        	
	       
	        	
	        }
	        else if(action.equals("updatePlayerScore")) {
	        	
	        	String playerName =  request.getParameter("PlayerName");
	        	double PlayerUpdateScoreValue =  Double.parseDouble(request.getParameter("PlayerUpdateScoreValue"));
	        	
	        	
	        	ArrayList<PlayerBean> updatedPlayerScoreList = new ArrayList<PlayerBean>();
	        	
	        	HttpSession session =  request.getSession();
                  if(session.getAttribute("Playerdatalist")!=null){
   	 				
                	  updatedPlayerScoreList =  (ArrayList<PlayerBean>) session.getAttribute("Playerdatalist");
                	  System.out.println("arraylist players " + updatedPlayerScoreList);
   	 			}
	        	
                  for(int i=0; i<updatedPlayerScoreList.size();i++){
                	  
                	  if(updatedPlayerScoreList.get(i).getPlayerName().equals(playerName)){
                		  
                		  double currentScore = updatedPlayerScoreList.get(i).getPlayerScore();
                		  
                	      double updatedScore = PlayerUpdateScoreValue + currentScore ;
                	      
                	      updatedPlayerScoreList.get(i).setPlayerScore(updatedScore);
                	      
                	      
                	  }
                	  
                  }
                  
                  session.setAttribute("Playerdatalist", updatedPlayerScoreList);
	        	
	        	
	        	
	        	
	        }
		
		
		
		
	}
	
	
	
	
	
	 
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// TODO Auto-generated method stub
			doPost(request,response);
			
		}

}
