package scorekeeper.beanclass;

import java.io.Serializable;
import java.util.ArrayList;

public class PlayerBean implements Serializable {
	
	
	String PlayerName;
	double PlayerScore;
	ArrayList<String> roundScore; 
	
	
	public PlayerBean() {
		
		PlayerName = "";
		PlayerScore = 0;
		roundScore = null;
		
	}
	
	
	public ArrayList<String> getRoundScore() {
		return roundScore;
	}

	public void setRoundScore(ArrayList<String> roundScore) {
		this.roundScore = roundScore;
	}




	public String getPlayerName() {
		return PlayerName;
	}


	public void setPlayerName(String playerName) {
		PlayerName = playerName;
	}


	public double getPlayerScore() {
		return PlayerScore;
	}


	public void setPlayerScore(double playerScore) {
		PlayerScore = playerScore;
	}




	@Override
	public String toString() {
		return "{PlayerName : " + "'" + PlayerName + "'"+ ", PlayerScore :" + PlayerScore + ", roundScore :" + roundScore
				+ "}";
	}


	
	

}
