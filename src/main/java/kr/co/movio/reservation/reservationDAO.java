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
	
	 //예약 정보를 DB에 저장하는 메소드
	 public void saveReservation(TicketReservationDTO reservation) {
	        sqlSession.insert("ticketreservation.saveReservation", reservation);
	  }
	 
	 //결제 정보를 DB에 저장하는 메소드
	 public void savePayment(TicketPaymentDTO payment) {
	        sqlSession.insert("ticketreservation.savePayment", payment);
	 }
	
	 //사용자의 결제 정보로 예약 정보를 조회함
	 public void getReservation(TicketPaymentDTO payment) {
	        sqlSession.insert("ticketreservation.getReservation", payment);
	 }
	 
	 //결제 정보 조회
	 public void getPayment(TicketPaymentDTO payment) {
	        sqlSession.insert("ticketreservation.getPayment", payment);
	 }
	 
	 //예약 ID로 예약 세부 정보를 조회
	 public Map<String, Object> getReservationDetails(String res_id) {
		    return sqlSession.selectOne("ticketreservation.getReservationDetails", res_id);
	 }
	 
	 //상영 영화 ID로 예약된 좌석 목록을 조회하여 좌석 상태를 반환
	 public Map<String, Boolean> getReservedSeats(String screenMovieId) {
		    List<String> reservedSeatsList = sqlSession.selectList("ticketreservation.getReservedSeats", screenMovieId);
		    Map<String, Boolean> reservedSeats = new HashMap<>();
		    for (String seat : reservedSeatsList) {
		        reservedSeats.put(seat, true);
		    }
		    return reservedSeats;
		}
	 
	 	//상영 영화 ID로 상영관 ID를 조회
	    public String getScreenIdByScreenMovieId(String screenMovieId) {
	        Map<String, Object> result = sqlSession.selectOne("ticketreservation.getScreenIdByScreenMovieId", screenMovieId);
	        return result != null ? (String) result.get("screen_id") : null;
	    }

	    //상영관 ID로 총 좌석 수를 조회
	    public Map<String, Object> getTotalSeats(String screen_id) {
	        return sqlSession.selectOne("ticketreservation.getTotalSeats", screen_id);
	    }
	    
	    //현재 활성화된 상영 영화 ID 목록을 조회하는 메소드
	    public List<String> getActiveScreenMovieIds() {
	        return sqlSession.selectList("ticketreservation.getActiveScreenMovieIds");
	    }
	    
	    //영화 ID로 총 관객 수를 조회하는 메소드
	    public int getTotalAudience(String movieId) {
	        Integer result = sqlSession.selectOne("reservation.getTotalAudience", movieId);
	        return result != null ? result : 0;
	    }

	    //영화 ID로 영화의 평균 평점을 조회하는 메소드
	    public double getRating(String movieId) {
	        Double result = sqlSession.selectOne("reservation.getRating", movieId);
	        return result != null ? result : 0.0;
	    }

	    //영화 ID로 예매율을 조회하는 메소드
	    public double getMovieGrade(String movieId) {
	        Double result = sqlSession.selectOne("reservation.getMovieGrade", movieId);
	        return result != null ? result : 0.0;
	    }
	    
	    // 예약 ID로 예약 정보를 조회하는 메소드 추가
	    public TicketReservationDTO getReservationById(String reservationId) {
	        return sqlSession.selectOne("reservation.getReservationById", reservationId);
	    }
	    
	    //사용자별 영화 등록 여부를 확인하는 메소드
	    public boolean isMovieRegisteredByUser(String movieId, String memId) {
	        Map<String, String> params = new HashMap<>();
	        params.put("movieId", movieId);
	        params.put("memId", memId);
	        Integer count = sqlSession.selectOne("reservation.isMovieRegisteredByUser", params);
	        return count != null && count > 0;
	    }
	    
	    //본 영화 등록 여부를 확인하는 메소드
	    public boolean isRegistered(String movieId, String memId) {
	        Map<String, String> params = new HashMap<>();
	        params.put("movieId", movieId);
	        params.put("memId", memId);
	        Integer count = sqlSession.selectOne("reservation.isRegistered", params);
	        return count != null && count > 0;
	    }
}
