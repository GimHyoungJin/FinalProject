package kr.co.movio.admin.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin/notices")
public class AdminNoticeCont {

    @Autowired
    private AdminNoticeService noticeService;

    // 공지사항 목록 조회
    @GetMapping
    public String listNotices(@RequestParam(value = "page", defaultValue = "1") int page,
                              @RequestParam(value = "size", defaultValue = "10") int size,
                              Model model) {
        try {
            List<AdminNoticeDTO> notices = noticeService.getNotices(page, size);
            int totalNotices = noticeService.getTotalNotices();
            int totalPages = (int) Math.ceil((double) totalNotices / size);
            model.addAttribute("notices", notices);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항을 불러오는 중에 문제가 발생했습니다.");
        }
        return "admin/adminNoticeList";
    }

    // 공지사항 상세보기
    @GetMapping("/detail")
    public String detailNotice(@RequestParam("noticeNum") int noticeNum, Model model) {
        try {
            noticeService.increaseViewCount(noticeNum);  // 조회수 증가
            AdminNoticeDTO notice = noticeService.getNoticeDetail(noticeNum);
            model.addAttribute("notice", notice);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항을 불러오는 중에 문제가 발생했습니다.");
        }
        return "admin/adminNoticeDetail";
    }

    // 공지사항 작성 폼
    @GetMapping("/createForm")
    public String createForm() {
        return "admin/adminNoticeForm";
    }

    // 공지사항 생성
    @PostMapping("/create")
    public String createNotice(@RequestParam("title") String title,
                               @RequestParam("content") String content,
                               Model model) {
        try {
            AdminNoticeDTO notice = new AdminNoticeDTO();
            notice.setTitle(title);
            notice.setContent(content);
            notice.setRegdate(new Timestamp(new Date().getTime()));
            noticeService.createNotice(notice);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항을 생성하는 중에 문제가 발생했습니다.");
            return "admin/adminNoticeForm";
        }
        return "redirect:/admin/notices?page=1&size=10";
    }

    // 공지사항 수정 폼
    @GetMapping("/updateForm")
    public String updateForm(@RequestParam("noticeNum") int noticeNum, Model model) {
        try {
            AdminNoticeDTO notice = noticeService.getNoticeDetail(noticeNum);
            model.addAttribute("notice", notice);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항을 불러오는 중에 문제가 발생했습니다.");
            return "admin/adminNoticeList";
        }
        return "admin/adminNoticeUpdate";
    }

    // 공지사항 수정
    @PostMapping("/update")
    public String updateNotice(@RequestParam("noticeNum") int noticeNum,
                               @RequestParam("title") String title,
                               @RequestParam("content") String content,
                               Model model) {
        try {
            AdminNoticeDTO notice = new AdminNoticeDTO();
            notice.setNoticeNum(noticeNum);
            notice.setTitle(title);
            notice.setContent(content);
            notice.setChdate(new Timestamp(new Date().getTime()));
            noticeService.updateNotice(notice);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항을 수정하는 중에 문제가 발생했습니다.");
            return "admin/adminNoticeUpdate";
        }
        return "redirect:/admin/notices?page=1&size=10";
    }

    // 공지사항 삭제
    @PostMapping("/delete")
    public String deleteNotice(@RequestParam("noticeNum") int noticeNum, Model model) {
        try {
            noticeService.deleteNotice(noticeNum);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항을 삭제하는 중에 문제가 발생했습니다.");
            return "admin/adminNoticeDetail";
        }
        return "redirect:/admin/notices?page=1&size=10";
    }
}

