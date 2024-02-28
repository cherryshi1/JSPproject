package dto;

public class DcommentDTO {
		private String dcomment;
	    private String nickname;
	    private String content;
	    private String movie;
	    private String id ;
	    
		public String getDcomment() {
			return dcomment;
		}
		public void setDcomment(String dcomment) {
			this.dcomment = dcomment;
		}
		public String getNickname() {
			return nickname;
		}
		public void setNickname(String nickname) {
			this.nickname = nickname;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getMovie() {
			return movie;
		}
		public void setMovie(String movie) {
			this.movie = movie;
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		@Override
		public String toString() {
			return "DcommentDTO [dcomment=" + dcomment + ", nickname=" + nickname + ", content=" + content + ", movie="
					+ movie + ", id=" + id + "]";
		}
		
		
		
	    
	    
		
}
