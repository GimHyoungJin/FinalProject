package kr.co.movio.mypage.bookinglist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/mypage/bookinglist")
public class BookingListCont {

    @Autowired
    private BookingListService bookingListService;

    @GetMapping
    public String getBookingList(HttpSession session, Model model) {
        String memId = (String) session.getAttribute("mem_id");
        List<BookingListDTO> bookingList = null;
        List<OrderDetailDTO> orderList = null;
        if (memId != null) {
            bookingList = bookingListService.getBookingList(memId);
            orderList = bookingListService.getOrderList(memId);
        }
        model.addAttribute("bookingList", bookingList);
        model.addAttribute("orderList", orderList);
        model.addAttribute("loggedIn", memId != null);
        return "mypage/bookinglist";
    }
}
