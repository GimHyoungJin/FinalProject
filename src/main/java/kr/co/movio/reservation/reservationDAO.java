package kr.co.movio.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;

@Repository
public class reservationDAO {

	@Autowired
    private SqlSession sqlSession;
	
	 public void saveReservation(TicketReservationDTO reservation) {
	        sqlSession.insert("ticketreservation.saveReservation", reservation);
	  }
	 
	 public void savePayment(TicketPaymentDTO payment) {
	        sqlSession.insert("ticketreservation.savePayment", payment);
	 }
	
	 public void getReservation(TicketPaymentDTO payment) {
	        sqlSession.insert("ticketreservation.getReservation", payment);
	 }
	 
	 public void getPayment(TicketPaymentDTO payment) {
	        sqlSession.insert("ticketreservation.getPayment", payment);
	 }
	 
	 public Map<String, Object> getReservationDetails(String res_id) {
		    return sqlSession.selectOne("ticketreservation.getReservationDetails", res_id);
	 }
	 
	 /*
	 public Map<String, Boolean> getReservedSeats(String screenMovieId) {
		    Map<String, Boolean> reservedSeats = sqlSession.selectOne("ticketreservation.getReservationDetails", screenMovieId);
		    if (reservedSeats == null) {
		        reservedSeats = new HashMap<>();
		    }
		    return reservedSeats;
		}
	 */
	 
	 public Map<String, Boolean> getReservedSeats(String screenMovieId) {
		    List<String> reservedSeatsList = sqlSession.selectList("ticketreservation.getReservedSeats", screenMovieId);
		    Map<String, Boolean> reservedSeats = new HashMap<>();
		    for (String seat : reservedSeatsList) {
		        reservedSeats.put(seat, true);
		    }
		    return reservedSeats;
		}
	 
	 	// screenMovieId로 screen_id를 조회하는 메서드
	    public String getScreenIdByScreenMovieId(String screenMovieId) {
	        Map<String, Object> result = sqlSession.selectOne("ticketreservation.getScreenIdByScreenMovieId", screenMovieId);
	        return result != null ? (String) result.get("screen_id") : null;
	    }

	    // screen_id로 총 좌석 수를 조회하는 메서드
	    public Map<String, Object> getTotalSeats(String screen_id) {
	        return sqlSession.selectOne("ticketreservation.getTotalSeats", screen_id);
	    }
	    
	    public List<String> getActiveScreenMovieIds() {
	        return sqlSession.selectList("ticketreservation.getActiveScreenMovieIds");
	    }
}
