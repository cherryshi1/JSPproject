package dto;

public class GoodPointDTO {
    
	private String goodpoint_no;
    private String user_id;
	private String movie_no;
	
	
	public String getGoodpoint_no() {
		return goodpoint_no;
	}
	public void setGoodpoint_no(String goodpoint_no) {
		this.goodpoint_no = goodpoint_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getMovie_no() {
		return movie_no;
	}
	public void setMovie_no(String movie_no) {
		this.movie_no = movie_no;
	}
	@Override
	public String toString() {
		return "GoodPointDTO [user_id=" + user_id + ", movie_no=" + movie_no + "]";
	}
	
	
	
	
	
	
	
	
}
