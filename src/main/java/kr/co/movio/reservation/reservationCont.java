package kr.co.movio.reservation;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.co.movio.movie.MovieDAO;
import kr.co.movio.movie.MovieDTO;
import kr.co.movio.theater.TheaterDAO;
import kr.co.movio.theater.TheaterDTO;

import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;

import java.util.*;

//좌석 예매 페이지에 대한 컨트롤러
@Controller
@RequestMapping("/reservation")
public class reservationCont {

	@Autowired
	private MovieDAO movieDao;
	
	@Autowired 
	private TheaterDAO theaterDao;
	
	
    private final Map<String, Boolean> seatStatus = Collections.synchronizedMap(new HashMap<>());

    // 초기 좌석 상태 설정 (예제용)
    public reservationCont() {
        System.out.println("----- reservationCont 객체 생성완료");
        for (char row = 'A'; row <= 'F'; row++) {
            for (int col = 1; col <= 10; col++) {
                seatStatus.put(row + String.valueOf(col), false); // 모든 좌석을 사용 가능으로 설정
            }
        }
    }

    // 영화 리스트
    @GetMapping("/booking")
    public String reservation(Model model) {
    	List<MovieDTO> movieList = movieDao.getMovies();
    	//List<TheaterDTO> theaterList = theaterDao.getAllTheaters();
    	
    	model.addAttribute("movies", movieList);
    	//model.addAttribute("theaters", theaterList);
        return "reservation/booking";
    }
    
    // 좌석 예매 페이지
    @GetMapping("/moviebooking")
    public String MovieBooking() {
        return "reservation/movieBooking";
    }

    // 좌석 상태 업데이트
    @PostMapping("/updateSeatStatus")
    public ResponseEntity<?> updateSeatStatus(@RequestBody Map<String, Object> request) {
        @SuppressWarnings("unchecked")
        Map<String, List<String>> selectedSeats = (Map<String, List<String>>) request.get("selectedSeats");

        synchronized (seatStatus) {
            // 좌석 상태 업데이트 로직
            for (String category : selectedSeats.keySet()) {
                List<String> seats = selectedSeats.get(category);
                for (String seat : seats) {
                    if (seatStatus.get(seat)) {
                        return new ResponseEntity<>("Seat " + seat + " is already reserved", HttpStatus.CONFLICT);
                    }
                }
            }
            for (String category : selectedSeats.keySet()) {
                List<String> seats = selectedSeats.get(category);
                for (String seat : seats) {
                    seatStatus.put(seat, true); // 해당 좌석을 사용 중으로 설정
                }
            }
        }

        return new ResponseEntity<>("Seat status updated successfully", HttpStatus.OK);
    }

    // 좌석 상태 조회 (AJAX 요청용)
    @GetMapping("/seatStatus")
    public ResponseEntity<Map<String, Boolean>> getSeatStatus() {
        return new ResponseEntity<>(seatStatus, HttpStatus.OK);
    }
}
