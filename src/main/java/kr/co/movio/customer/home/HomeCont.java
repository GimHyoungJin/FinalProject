package kr.co.movio.customer.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.movio.customer.notice.NoticeService;

@Controller
@RequestMapping("/customer")
public class HomeCont {

    @Autowired
    private NoticeService noticeService;

    @GetMapping("/home")
    public String home(Model model) {
        model.addAttribute("noticeList", noticeService.getRecentNotices());
        return "customer/home";
    }
}
