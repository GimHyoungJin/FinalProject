package kr.co.movio.reservation;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

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
	
	//booking.jsp 페이지를 보여주는 엔드포인트
    @GetMapping("/booking")
    public ModelAndView regionlist() {
    	ModelAndView mav = new ModelAndView();    	
    	mav.setViewName("reservation/booking");
    	mav.addObject("regions", theaterDao.getAllRegions());//모든 지역 데이터를 가져옴
    	mav.addObject("regionCounts", theaterDao.RegionsTheaterCounts() );//지역별 극장수가 몇개인지
    	mav.addObject("movies", movieDao.getMovies());//모든 영화 데이터를 가져옴
        return mav;
    }//end
    
    
    /*각 지역별 지점 영화관 목록 가져오는 엔드포인트
    @GetMapping("/booking/theater")
    @ResponseBody 
    public List<Map<String, Object>> theaterlist(@RequestParam("region_id") String region_id) {
    	//System.out.println("------" + region_id);
    	return theaterDao.getTheaters(region_id);
    }//end
    */
    
    @GetMapping("/booking/theater")
    @ResponseBody
    public List<Map<String, Object>> getTheaters(@RequestParam("region_id") String regionId, 
                                                 @RequestParam("movie_id") String movieId) {
        Map<String, Object> params = new HashMap<>();
        params.put("region_id", regionId);
        params.put("movie_id", movieId);
        return theaterDao.getTheaters(params);
    }
    // 특정 극장의 상영 날짜 조회하는 엔드포인트
    @GetMapping("/booking/dates")
    @ResponseBody
    public List<Map<String, Object>> getDates(@RequestParam("theater_id") String theaterId, 
                                              @RequestParam("movie_id") String movieId) {
        Map<String, Object> params = new HashMap<>();
        params.put("theater_id", theaterId);
        params.put("movie_id", movieId);
        return theaterDao.getDistinctDatesByTheater(params);
    }
    
    
    //특정 날짜의 상영 영화 조회하는 엔드포인트
    @GetMapping("/booking/times")
    @ResponseBody
    public List<Map<String, Object>> getTimes(@RequestParam("theater_id") String theater_id, @RequestParam("date") String date, @RequestParam("movie_id") String movie_id) {
    	System.out.println("Theater ID: " + theater_id); // 디버그용 로그
        System.out.println("Date: " + date); // 디버그용 로그
        System.out.println("Movie ID: " + movie_id); // 디버그용 로그
    	Map<String, Object> params = Map.of("theater_id", theater_id, "date", date, "movie_id", movie_id);
        return theaterDao.getMoviesByTheaterAndDate(params);
    }
    
	
    // 좌석 예매 페이지
    @GetMapping("/moviebooking")
    public String MovieBooking() {
        return "reservation/movieBooking";
    }

    private Map<String, Boolean> seatStatus = Collections.synchronizedMap(new HashMap<>());

    // 초기 좌석 상태 설정 (예제용)
    public reservationCont() {
        System.out.println("----- reservationCont 객체 생성완료");
        for (char row = 'A'; row <= 'F'; row++) {
            for (int col = 1; col <= 10; col++) {
                seatStatus.put(row + String.valueOf(col), false); // 모든 좌석을 사용 가능으로 설정
            }
        }
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
