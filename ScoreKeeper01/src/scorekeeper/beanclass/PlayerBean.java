package scorekeeper.beanclass;

import java.io.Serializable;

public class PlayerBean implements Serializable {
	
	
	String PlayerName;
	double PlayerScore;
	
	
	public PlayerBean() {
		
		PlayerName = "";
		PlayerScore = 0;
		
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
		return "PlayerBean [PlayerName=" + PlayerName + ", PlayerScore=" + PlayerScore + "]";
	}
	
	
	

}
