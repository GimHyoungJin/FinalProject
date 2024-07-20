package kr.co.movio.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	 
	 //예약된 좌석 정보를 가져오는 쿼리
	 public Map<String, Boolean> getReservedSeats(String screen_movie_id) {
		    List<String> reservedSeats = sqlSession.selectList("ticketreservation.getReservedSeats", screen_movie_id);
		    System.out.println("Reserved Seats: " + reservedSeats);
		    Map<String, Boolean> seatStatus = new HashMap<>();
		    for (String seat : reservedSeats) {
		        seatStatus.put(seat, true);
		    }
		    return seatStatus;
		}
	 
	// screen_id로 총 좌석 수를 조회하는 메서드
	 public Map<String, Object> getTotalSeats(String screen_movie_id) {
	     // screenMovieId로 screen_id를 먼저 조회
	     String screen_id = sqlSession.selectOne("ticketreservation.getScreenIdByScreenMovieId", screen_movie_id);
	     System.out.println("Screen ID: " + screen_id);
	     
	     if (screen_id != null) {
	         Map<String, Object> totalSeats = sqlSession.selectOne("ticketreservation.getTotalSeats", screen_id);
	         System.out.println("Total Seats: " + totalSeats);
	         return totalSeats;
	     } else {
	         System.out.println("No Screen ID found for Screen Movie ID: " + screen_movie_id);
	         return null;
	     }
	 }
}
