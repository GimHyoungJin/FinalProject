package kr.co.movio.reservation;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import kr.co.movio.member.MemberDAO;
import kr.co.movio.member.MemberDTO;
import kr.co.movio.movie.MovieDAO;

import kr.co.movio.theater.TheaterDAO;

import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;


import java.util.*;

// 좌석 예매 페이지에 대한 컨트롤러
@Controller
@RequestMapping("/reservation")
public class reservationCont {

    @Autowired
    private MovieDAO movieDao;

    @Autowired 
    private TheaterDAO theaterDao;

    @Autowired
    private MemberDAO memberDao;

    @Autowired
    private reservationDAO reservationDao;

    public reservationCont() {
        System.out.println("----- reservationCont 객체 생성완료");
    }

    // booking.jsp 페이지를 보여주는 엔드포인트
    @GetMapping("/booking")
    public ModelAndView regionlist() {
        ModelAndView mav = new ModelAndView();  
        mav.setViewName("reservation/booking");
        mav.addObject("regions", theaterDao.getAllRegions()); // 모든 지역 데이터를 가져옴
        mav.addObject("regionCounts", theaterDao.RegionsTheaterCounts()); // 지역별 극장수가 몇개인지
        mav.addObject("movies", movieDao.getMovies()); // 모든 영화 데이터를 가져옴
        return mav;
    }

    // 특정 지역과 영화에 해당하는 극장을 조회하는 엔드포인트
    @GetMapping("/booking/theater")
    @ResponseBody
    public List<Map<String, Object>> getTheaters(@RequestParam("region_id") String regionId, 
                                                 @RequestParam("movie_id") String movieId) {
        Map<String, Object> params = new HashMap<>();
        params.put("region_id", regionId);
        params.put("movie_id", movieId);
        return theaterDao.getTheaters(params); // 특정 지역과 영화에 해당하는 극장 목록을 반환
    }

    // 특정 극장의 상영 날짜를 조회하는 엔드포인트
    @GetMapping("/booking/dates")
    @ResponseBody
    public List<Map<String, Object>> getDates(@RequestParam("theater_id") String theaterId, 
                                              @RequestParam("movie_id") String movieId) {
        Map<String, Object> params = new HashMap<>();
        params.put("theater_id", theaterId);
        params.put("movie_id", movieId);
        return theaterDao.getDistinctDatesByTheater(params); // 특정 극장과 영화에 해당하는 상영 날짜 목록을 반환
    }

    // 특정 날짜의 상영 시간을 조회하는 엔드포인트
    @GetMapping("/booking/times")
    @ResponseBody
    public List<Map<String, Object>> getTimes(@RequestParam("theater_id") String theater_id, 
                                              @RequestParam("date") String date, 
                                              @RequestParam("movie_id") String movie_id) {
        System.out.println("Theater ID: " + theater_id); // 디버그용 로그
        System.out.println("Date: " + date); // 디버그용 로그
        System.out.println("Movie ID: " + movie_id); // 디버그용 로그
        Map<String, Object> params = Map.of("theater_id", theater_id, "date", date, "movie_id", movie_id);
        return theaterDao.getMoviesByTheaterAndDate(params); // 특정 극장, 날짜, 영화에 해당하는 상영 시간 목록을 반환
    }

    // moviebooking.jsp 페이지로 이동하는 리다이렉트 엔드포인트
    // 세션에 booking.jsp 페이지에서 선택한 데이터를 담아서 넘긴다.
    // 무조건 로그인해야 해당 페이지로 넘어갈 수 있다. 아니면 405 에러가 뜸.
    @GetMapping("/moviebooking")
    public String movieBooking(HttpSession session, Model model) {
        String memId = (String) session.getAttribute("mem_id");

        // 세션에서 데이터를 가져와 모델에 추가
        model.addAttribute("movieId", session.getAttribute(memId + "_movieId"));
        model.addAttribute("theaterId", session.getAttribute(memId + "_theaterId"));
        model.addAttribute("date", session.getAttribute(memId + "_date"));
        model.addAttribute("time", session.getAttribute(memId + "_time"));
        model.addAttribute("posterUrl", session.getAttribute(memId + "_posterUrl"));
        model.addAttribute("movieTitle", session.getAttribute(memId + "_movieTitle"));
        model.addAttribute("theaterName", session.getAttribute(memId + "_theaterName"));
        model.addAttribute("screenNum", session.getAttribute(memId + "_screenNum"));
        model.addAttribute("screenMovieId", session.getAttribute(memId + "_screenMovieId"));

        // 회원 정보를 가져와 모델에 추가
        MemberDTO member = memberDao.findById(memId);
        model.addAttribute("member", member);

        String theaterId = (String) session.getAttribute(memId + "_theaterId");
        String screenNum = (String) session.getAttribute(memId + "_screenNum");

        // 극장과 상영관 정보를 가져와 모델에 추가
        Map<String, Object> screenInfo = theaterDao.getScreenInfo(theaterId, screenNum);
        model.addAttribute("screenInfo", screenInfo);

        return "reservation/movieBooking";
    }

    // 예약 데이터를 처리하는 엔드포인트
    @PostMapping("/moviebooking")
    public String handleBooking(@RequestBody Map<String, String> bookingData, HttpSession session) {
        String memId = (String) session.getAttribute("mem_id");
        System.out.println("mem_id" + memId);

        // 예약 데이터를 세션에 저장
        String movieId = bookingData.get("movieId");
        String theaterId = bookingData.get("theaterId");
        String date = bookingData.get("date");
        String time = bookingData.get("time");
        String posterUrl = bookingData.get("posterUrl");
        String movieTitle = bookingData.get("movieTitle");
        String theaterName = bookingData.get("theaterName");
        String screenNum = bookingData.get("screenNum");
        String screenMovieId = bookingData.get("screenMovieId");

        // 디버그용 로그 출력
        System.out.println("movieId: " + movieId);
        System.out.println("theaterId: " + theaterId);
        System.out.println("date: " + date);
        System.out.println("time: " + time);
        System.out.println("posterUrl: " + posterUrl);
        System.out.println("movieTitle: " + movieTitle);
        System.out.println("theaterName: " + theaterName);
        System.out.println("screenNum: " + screenNum);
        System.out.println("screenMovieId: " + screenMovieId);

        // 데이터를 세션에 저장
        session.setAttribute(memId + "_movieId", movieId);
        session.setAttribute(memId + "_theaterId", theaterId);
        session.setAttribute(memId + "_date", date);
        session.setAttribute(memId + "_time", time);
        session.setAttribute(memId + "_posterUrl", posterUrl);
        session.setAttribute(memId + "_movieTitle", movieTitle);
        session.setAttribute(memId + "_theaterName", theaterName);
        session.setAttribute(memId + "_screenNum", screenNum);
        session.setAttribute(memId + "_screenMovieId", screenMovieId);

        return "redirect:/reservation/moviebooking";
    }

    // 좌석 상태를 관리하기 위한 동기화된 Map
    private Map<String, Boolean> seatStatus = Collections.synchronizedMap(new HashMap<>());

    // 좌석 상태 업데이트 엔드포인트
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

    // 좌석 상태 조회 엔드포인트 (AJAX 요청용)
    @GetMapping("/seatStatus")
    public ResponseEntity<Map<String, Boolean>> getSeatStatus() {
        return new ResponseEntity<>(seatStatus, HttpStatus.OK);
    }

    // UUID 생성 엔드포인트
    @GetMapping("/generateUUID")
    public ResponseEntity<String> generateUUID() {
        UUID uuid = UUID.randomUUID();
        return new ResponseEntity<>(uuid.toString(), HttpStatus.OK);
    }

    // 예약 정보를 저장하는 엔드포인트
    @PostMapping("/save")
    public ResponseEntity<String> saveReservation(@RequestBody TicketReservationDTO reservationDTO, HttpSession session) {
    	String memId = (String) session.getAttribute("mem_id");
    	String screenMovieId = (String) session.getAttribute(memId + "_screenMovieId");
    	
    	// mem_id를 세션에서 가져와 설정
        reservationDTO.setMem_id(memId);
        reservationDTO.setScreen_movie_id(screenMovieId);
    	
    	reservationDao.saveReservation(reservationDTO);
        return new ResponseEntity<>(reservationDTO.getRes_id(), HttpStatus.OK);
    }

    // 결제 정보를 저장하는 엔드포인트
    @PostMapping("/payment/save")
    public ResponseEntity<String> savePayment(@RequestBody TicketPaymentDTO paymentDTO, HttpSession session) {
        reservationDao.savePayment(paymentDTO);
        session.setAttribute("res_id", paymentDTO.getRes_id()); // res_id 세션에 저장
        return new ResponseEntity<>("Payment saved successfully", HttpStatus.OK);
    }
    
    // 결제 성공 페이지로 리다이렉트
    @GetMapping("/payment/success")
    public String paymentSuccess(HttpSession session, Model model) {
        String resId = (String) session.getAttribute("res_id"); // 세션에서 res_id 가져오기
        if (resId != null) {
            Map<String, Object> reservationDetails = reservationDao.getReservationDetails(resId);
            if (reservationDetails != null) {
                model.addAttribute("reservation", reservationDetails);
            } else {
                //res_id가 null이면 해당 메세지 출력
                System.out.println("No reservation details found for res_id: " + resId);
            }
        } else {
            System.out.println("res_id not found in session.");
        }
        return "reservation/paymentSuccess"; // 결제 성공 JSP 페이지
    }
    
}
