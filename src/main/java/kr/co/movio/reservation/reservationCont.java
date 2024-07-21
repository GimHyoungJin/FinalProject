package kr.co.movio.reservation;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import kr.co.movio.member.MemberDAO;
import kr.co.movio.member.MemberDTO;
import kr.co.movio.movie.MovieDAO;
import kr.co.movio.theater.TheaterDAO;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

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

    @Autowired
    private SeatWebSocketHandler seatWebSocketHandler;


    public reservationCont() {
        System.out.println("----- reservationCont 객체 생성완료");
    }
    
    private static final Logger logger = LoggerFactory.getLogger(reservationCont.class);
    
    /*
    @PostConstruct
    public void initializeSeatStatus() {
        logger.info("Initializing seat status...");
        List<String> activeScreenMovieIds = reservationDao.getActiveScreenMovieIds();
        for (String screenMovieId : activeScreenMovieIds) {
            Map<String, Boolean> reservedSeats = reservationDao.getReservedSeats(screenMovieId);
            synchronized (seatStatus) {
                seatStatus.putAll(reservedSeats);
            }
        }
        logger.info("Seat status initialization completed.");
    }
	*/
    


    // booking.jsp 페이지를 보여주는 엔드포인트
    @GetMapping("/booking")
    public ModelAndView regionlist() {
        ModelAndView mav = new ModelAndView();  
        mav.setViewName("reservation/booking");
        mav.addObject("regions", theaterDao.getAllRegions());
        mav.addObject("regionCounts", theaterDao.RegionsTheaterCounts());
        mav.addObject("movies", movieDao.getMovies());
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
        return theaterDao.getTheaters(params);
    }

    // 특정 극장의 상영 날짜를 조회하는 엔드포인트
    @GetMapping("/booking/dates")
    @ResponseBody
    public List<Map<String, Object>> getDates(@RequestParam("theater_id") String theaterId, 
                                              @RequestParam("movie_id") String movieId) {
        Map<String, Object> params = new HashMap<>();
        params.put("theater_id", theaterId);
        params.put("movie_id", movieId);
        return theaterDao.getDistinctDatesByTheater(params);
    }

    // 특정 날짜의 상영 시간을 조회하는 엔드포인트
    @GetMapping("/booking/times")
    @ResponseBody
    public List<Map<String, Object>> getTimes(@RequestParam("theater_id") String theater_id, 
                                              @RequestParam("date") String date, 
                                              @RequestParam("movie_id") String movie_id) {
        System.out.println("Theater ID: " + theater_id);
        System.out.println("Date: " + date);
        System.out.println("Movie ID: " + movie_id);
        Map<String, Object> params = Map.of("theater_id", theater_id, "date", date, "movie_id", movie_id);
        return theaterDao.getMoviesByTheaterAndDate(params);
    }

    // moviebooking.jsp 페이지로 이동하는 리다이렉트 엔드포인트
    @GetMapping("/moviebooking")
    public String movieBooking(HttpSession session, Model model) {
        String memId = (String) session.getAttribute("mem_id");

        model.addAttribute("movieId", session.getAttribute(memId + "_movieId"));
        model.addAttribute("theaterId", session.getAttribute(memId + "_theaterId"));
        model.addAttribute("date", session.getAttribute(memId + "_date"));
        model.addAttribute("time", session.getAttribute(memId + "_time"));
        model.addAttribute("posterUrl", session.getAttribute(memId + "_posterUrl"));
        model.addAttribute("movieTitle", session.getAttribute(memId + "_movieTitle"));
        model.addAttribute("theaterName", session.getAttribute(memId + "_theaterName"));
        model.addAttribute("screenNum", session.getAttribute(memId + "_screenNum"));
        model.addAttribute("screenMovieId", session.getAttribute(memId + "_screenMovieId"));

        MemberDTO member = memberDao.findById(memId);
        model.addAttribute("member", member);

        String theaterId = (String) session.getAttribute(memId + "_theaterId");
        String screenNum = (String) session.getAttribute(memId + "_screenNum");

        Map<String, Object> screenInfo = theaterDao.getScreenInfo(theaterId, screenNum);
        model.addAttribute("screenInfo", screenInfo);

        return "reservation/movieBooking";
    }

    // 예약 데이터를 처리하는 엔드포인트
    @PostMapping("/moviebooking")
    public String handleBooking(@RequestBody Map<String, String> bookingData, HttpSession session) {
        String memId = (String) session.getAttribute("mem_id");
        System.out.println("mem_id" + memId);

        String movieId = bookingData.get("movieId");
        String theaterId = bookingData.get("theaterId");
        String date = bookingData.get("date");
        String time = bookingData.get("time");
        String posterUrl = bookingData.get("posterUrl");
        String movieTitle = bookingData.get("movieTitle");
        String theaterName = bookingData.get("theaterName");
        String screenNum = bookingData.get("screenNum");
        String screenMovieId = bookingData.get("screenMovieId");

        System.out.println("movieId: " + movieId);
        System.out.println("theaterId: " + theaterId);
        System.out.println("date: " + date);
        System.out.println("time: " + time);
        System.out.println("posterUrl: " + posterUrl);
        System.out.println("movieTitle: " + movieTitle);
        System.out.println("theaterName: " + theaterName);
        System.out.println("screenNum: " + screenNum);
        System.out.println("screenMovieId: " + screenMovieId);

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

    private final Map<String, Map<String, Boolean>> seatStatusMap = new ConcurrentHashMap<>();
    
    @PostConstruct
    public void initializeSeatStatus() {
        logger.info("Initializing seat status...");
        List<String> activeScreenMovieIds = reservationDao.getActiveScreenMovieIds();
        for (String screenMovieId : activeScreenMovieIds) {
            Map<String, Boolean> reservedSeats = reservationDao.getReservedSeats(screenMovieId);
            updateSeatStatusMap(screenMovieId, reservedSeats);
        }
        logger.info("Seat status initialization completed.");
    }

    @Scheduled(fixedRate = 300000) // 5분마다 실행
    public void updateSeatStatus() {
        logger.info("Updating seat status...");
        List<String> activeScreenMovieIds = reservationDao.getActiveScreenMovieIds();
        for (String screenMovieId : activeScreenMovieIds) {
            Map<String, Boolean> reservedSeats = reservationDao.getReservedSeats(screenMovieId);
            updateSeatStatusMap(screenMovieId, reservedSeats);
        }
        logger.info("Seat status update completed.");
    }

    // 좌석 상태 맵 업데이트
    private void updateSeatStatusMap(String screenMovieId, Map<String, Boolean> reservedSeats) {
        seatStatusMap.put(screenMovieId, new ConcurrentHashMap<>(reservedSeats));
    }
    
    //좌석 상태 업데이트 엔드포인트
    @PostMapping("/updateSeatStatus")
    public ResponseEntity<?> updateSeatStatus(@RequestBody Map<String, Object> request) {
        logger.debug("Received updateSeatStatus request: {}", request);

        @SuppressWarnings("unchecked")
        Map<String, List<String>> selectedSeats = (Map<String, List<String>>) request.get("selectedSeats");
        String screenMovieId = (String) request.get("screenMovieId");

        if (screenMovieId == null) {
            logger.error("ScreenMovieId is null");
            Map<String, Object> response = new HashMap<>();
            response.put("status", "error");
            response.put("message", "ScreenMovieId is null");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }

        List<String> failedUpdates = new ArrayList<>();
        Map<String, Boolean> seatStatus = seatStatusMap.getOrDefault(screenMovieId, new ConcurrentHashMap<>());

        synchronized (seatStatus) {
            for (String category : selectedSeats.keySet()) {
                List<String> seats = selectedSeats.get(category);
                for (String seat : seats) {
                    if (seatStatus.get(seat) != null && seatStatus.get(seat)) {
                        logger.warn("Seat {} is already reserved", seat);
                        Map<String, Object> response = new HashMap<>();
                        response.put("status", "error");
                        response.put("message", "Seat " + seat + " is already reserved");
                        return new ResponseEntity<>(response, HttpStatus.CONFLICT);
                    }
                }
            }

            for (String category : selectedSeats.keySet()) {
                List<String> seats = selectedSeats.get(category);
                for (String seat : seats) {
                    seatStatus.put(seat, true); // 해당 좌석을 사용 중으로 설정
                    try {
                        seatWebSocketHandler.broadcastSeatUpdate(seat, true);
                    } catch (IOException e) {
                        failedUpdates.add(seat);
                        logger.error("Failed to broadcast seat update for seat: {}", seat, e);
                    }
                }
            }

            seatStatusMap.put(screenMovieId, seatStatus);
        }

        Map<String, Object> response = new HashMap<>();
        if (failedUpdates.isEmpty()) {
            response.put("status", "success");
            response.put("message", "All seat statuses updated successfully");
        } else {
            response.put("status", "partial_success");
            response.put("message", "Some seat updates failed to broadcast");
            response.put("failedSeats", failedUpdates);
        }

        return new ResponseEntity<>(response, HttpStatus.OK);
    }
    
    //좌석 상태 조회 엔드포인트
    @GetMapping("/seatStatus")
    public ResponseEntity<Map<String, Object>> getSeatStatus(@RequestParam String screenMovieId) {
        System.out.println("Received request for seatStatus with screenMovieId: " + screenMovieId);

        Map<String, Boolean> currentSeatStatus = reservationDao.getReservedSeats(screenMovieId);
        System.out.println("Current seat status: " + currentSeatStatus);

        // screenMovieId로 screen_id를 먼저 조회
        String screenId = reservationDao.getScreenIdByScreenMovieId(screenMovieId);
        System.out.println("Fetched screenId: " + screenId + " for screenMovieId: " + screenMovieId);

        Map<String, Object> totalSeatsMap = null;
        if (screenId != null) {
            totalSeatsMap = reservationDao.getTotalSeats(screenId);
            System.out.println("Total seats map: " + totalSeatsMap);
        } else {
            System.out.println("No screenId found for screenMovieId: " + screenMovieId);
        }

        // 새로운 좌석 상태 맵 생성
        Map<String, Boolean> seatStatus = seatStatusMap.getOrDefault(screenMovieId, new ConcurrentHashMap<>(currentSeatStatus));

        // null 키가 포함되지 않도록 필터링
        Map<String, Boolean> filteredSeatStatus = seatStatus.entrySet().stream()
            .filter(entry -> entry.getKey() != null)
            .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));

        System.out.println("Filtered seat status: " + filteredSeatStatus);

        Map<String, Object> response = new HashMap<>();
        response.put("seatStatus", filteredSeatStatus);

        // totalSeats가 유효한 경우에만 응답에 추가
        if (totalSeatsMap != null && totalSeatsMap.containsKey("screen_all_seat")) {
            response.put("totalSeats", totalSeatsMap.get("screen_all_seat"));
            System.out.println("Total seats: " + totalSeatsMap.get("screen_all_seat"));
        } else {
            response.put("totalSeats", 0); // 기본값 설정
            System.out.println("No valid total seats found, setting to 0");
        }

        System.out.println("Sending response: " + response);
        return new ResponseEntity<>(response, HttpStatus.OK);
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

        reservationDTO.setMem_id(memId);
        reservationDTO.setScreen_movie_id(screenMovieId);

        reservationDao.saveReservation(reservationDTO);
        return new ResponseEntity<>(reservationDTO.getRes_id(), HttpStatus.OK);
    }

    // 결제 정보를 저장하는 엔드포인트
    @PostMapping("/payment/save")
    public ResponseEntity<String> savePayment(@RequestBody TicketPaymentDTO paymentDTO, HttpSession session) {
        reservationDao.savePayment(paymentDTO);
        session.setAttribute("res_id", paymentDTO.getRes_id());
        return new ResponseEntity<>("Payment saved successfully", HttpStatus.OK);
    }

    // 결제 성공 페이지로 리다이렉트
    @GetMapping("/payment/success")
    public String paymentSuccess(HttpSession session, Model model) {
        String resId = (String) session.getAttribute("res_id");
        if (resId != null) {
            Map<String, Object> reservationDetails = reservationDao.getReservationDetails(resId);
            if (reservationDetails != null) {
                model.addAttribute("reservation", reservationDetails);
            } else {
                System.out.println("No reservation details found for res_id: " + resId);
            }
        } else {
            System.out.println("res_id not found in session.");
        }
        return "reservation/paymentSuccess";
    }
}