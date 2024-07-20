package kr.co.movio.reservation;

public class TicketReservationDTO {
	
	   	private String res_id;
	    private String mem_id;
	    private String screen_movie_id;
	    private String res_seat_info;
	    private int adult;
	    private int teenager;
	    private int child;
	    private int tot_people;
	    
		public String getRes_id() {
			return res_id;
		}
		public void setRes_id(String res_id) {
			this.res_id = res_id;
		}
		public String getMem_id() {
			return mem_id;
		}
		public void setMem_id(String mem_id) {
			this.mem_id = mem_id;
		}
		public String getScreen_movie_id() {
			return screen_movie_id;
		}
		public void setScreen_movie_id(String screen_movie_id) {
			this.screen_movie_id = screen_movie_id;
		}
		public String getRes_seat_info() {
			return res_seat_info;
		}
		public void setRes_seat_info(String res_seat_info) {
			this.res_seat_info = res_seat_info;
		}
		public int getAdult() {
			return adult;
		}
		public void setAdult(int adult) {
			this.adult = adult;
		}
		public int getTeenager() {
			return teenager;
		}
		public void setTeenager(int teenager) {
			this.teenager = teenager;
		}
		public int getChild() {
			return child;
		}
		public void setChild(int child) {
			this.child = child;
		}
		public int getTot_people() {
			return tot_people;
		}
		public void setTot_people(int tot_people) {
			this.tot_people = tot_people;
		}
		
		@Override
		public String toString() {
			return "TicketReservationDTO [res_id=" + res_id + ", mem_id=" + mem_id + ", screen_movie_id="
					+ screen_movie_id + ", res_seat_info=" + res_seat_info + ", adult=" + adult + ", teenager="
					+ teenager + ", child=" + child + ", tot_people=" + tot_people + "]";
		}
    
}
