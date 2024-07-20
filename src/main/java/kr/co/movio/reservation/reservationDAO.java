package kr.co.movio.reservation;

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
		    return sqlSession.selectOne("getReservationDetails", res_id);
		}
}
