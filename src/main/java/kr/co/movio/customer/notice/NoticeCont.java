package kr.co.movio.customer.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/customer/noticeList")
public class NoticeCont {

    @Autowired
    private NoticeDAO noticeDAO;

    // 공지사항 목록 조회
    @GetMapping
    public String listNotices(@RequestParam(value = "page", defaultValue = "1") int page,
                              @RequestParam(value = "size", defaultValue = "10") int size,
                              Model model) {
        int offset = (page - 1) * size;
        List<NoticeDTO> notices = noticeDAO.getNotices(offset, size);
        int totalNotices = noticeDAO.getTotalNotices();
        int totalPages = (int) Math.ceil((double) totalNotices / size);
        model.addAttribute("notices", notices);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "customer/noticeList";
    }

    // 공지사항 상세 보기
    @GetMapping("/detail")
    public String detailNotice(@RequestParam("noticeNum") int noticeNum, Model model) {
        noticeDAO.increaseViewCount(noticeNum);  // 조회수 증가
        NoticeDTO notice = noticeDAO.getNoticeDetail(noticeNum);
        model.addAttribute("notice", notice);
        return "customer/noticeDetail";
    }

    // 공지사항 검색
    @GetMapping("/search")
    public String searchNotices(@RequestParam("keyword") String keyword,
                                @RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "10") int size,
                                Model model) {
        int offset = (page - 1) * size;
        List<NoticeDTO> notices = noticeDAO.searchNotices(keyword, offset, size);
        int totalNotices = noticeDAO.getTotalNoticesByKeyword(keyword);
        int totalPages = (int) Math.ceil((double) totalNotices / size);
        model.addAttribute("notices", notices);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);
        return "customer/noticeList";
    }
}
