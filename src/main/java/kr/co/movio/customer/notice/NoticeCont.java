package kr.co.movio.customer.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class NoticeCont {

    @Autowired
    private NoticeService noticeService;

    @GetMapping("/customer/noticeList")
    public String customerNoticeList(Model model) {
        List<NoticeDTO> notices = noticeService.getRecentNotices();
        model.addAttribute("notices", notices);
        return "customer/noticeList"; // View의 경로 설정
    }
}
