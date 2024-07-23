package kr.co.movio.customer.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/customer/notice")
public class NoticeCont {

    @Autowired
    private NoticeService noticeService;

    /**
     * 공지사항 목록을 보여주는 메서드입니다.
     *
     * @param page  현재 페이지 번호
     * @param model 뷰에 데이터를 전달하기 위한 모델 객체
     * @return 공지사항 목록 페이지를 나타내는 뷰 이름
     */
    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        int pageSize = 10;
        List<NoticeDTO> notices = noticeService.getNotices((page - 1) * pageSize, pageSize);
        int totalNotices = noticeService.countNotices();
        int totalPages = (int) Math.ceil((double) totalNotices / pageSize);

        model.addAttribute("notices", notices);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "noticeList";
    }

    /**
     * 공지사항 상세 페이지를 보여주는 메서드입니다.
     *
     * @param id    공지사항 ID
     * @param model 뷰에 데이터를 전달하기 위한 모델 객체
     * @return 공지사항 상세 페이지를 나타내는 뷰 이름
     */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") int id, Model model) {
        noticeService.incrementViewCount(id);
        NoticeDTO notice = noticeService.getNoticeById(id);
        model.addAttribute("notice", notice);
        return "noticeDetail"; // noticeDetail.jsp와 연동되도록 설정합니다.
    }
}