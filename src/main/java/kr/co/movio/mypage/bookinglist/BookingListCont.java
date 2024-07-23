package kr.co.movio.mypage.bookinglist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/mypage/bookinglist")
public class BookingListCont {

    @Autowired
    private BookingListService bookingListService;

    @GetMapping
    public String getBookingList(HttpSession session, Model model) {
        // 세션에서 로그인된 사용자 정보 가져오기
        String memId = (String) session.getAttribute("mem_id");
        List<BookingListDTO> bookingList = new ArrayList<>();
        if (memId != null) {
            bookingList = bookingListService.getBookingList(memId);
        }
        model.addAttribute("bookingList", bookingList);
        model.addAttribute("loggedIn", memId != null); // 로그인 여부를 모델에 추가
        return "mypage/bookinglist"; // JSP 파일 경로 (mypage/bookinglist.jsp)
    }

    @GetMapping("/loadMoreBookings")
    @ResponseBody
    public List<BookingListDTO> loadMoreBookings(HttpSession session, @RequestParam("offset") int offset) {
        String memId = (String) session.getAttribute("mem_id");
        if (memId != null) {
            return bookingListService.getBookingList(memId, offset, 5);
        } else {
            return new ArrayList<>();
        }
    }
}
