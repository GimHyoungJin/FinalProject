package kr.co.movio.customer.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/customer")
public class NoticeCont {

    @Autowired
    private NoticeDAO noticeDAO;

    // 공지사항 목록 조회
    @GetMapping("/noticeList")
    public String listNotices(@RequestParam(value = "page", defaultValue = "1") int page,
                              @RequestParam(value = "size", defaultValue = "10") int size,
                              Model model) {
        try {
            int offset = (page - 1) * size;
            List<NoticeDTO> notices = noticeDAO.getNotices(offset, size);
            int totalNotices = noticeDAO.getTotalNotices();
            int totalPages = (int) Math.ceil((double) totalNotices / size);
            model.addAttribute("notices", notices);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            return "customer/noticeList";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항 목록을 가져오는 중 오류가 발생했습니다.");
            return "error";
        }
    }

    // 공지사항 상세 보기
    @GetMapping("/noticeDetail")
    public String detailNotice(@RequestParam("noticeNum") int noticeNum, Model model) {
    	try {
        noticeDAO.increaseViewCount(noticeNum);  // 조회수 증가
        NoticeDTO notice = noticeDAO.getNoticeDetail(noticeNum);
        model.addAttribute("notice", notice);
        return "customer/noticeDetail";
    	} catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항 상세 정보를 가져오는 중 오류가 발생했습니다.");
            return "error";
        }
    }
    
    // 공지사항 검색
    @GetMapping("/noticeSearch")
    public String searchNotices(@RequestParam("keyword") String keyword,
                                @RequestParam(value = "page", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = "10") int size,
                                Model model) {
    	try {
        int offset = (page - 1) * size;
        List<NoticeDTO> notices = noticeDAO.searchNotices(keyword, offset, size);
        int totalNotices = noticeDAO.getTotalNoticesByKeyword(keyword);
        int totalPages = (int) Math.ceil((double) totalNotices / size);
        model.addAttribute("notices", notices);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);
        return "customer/noticeList";
    	} catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항 검색 중 오류가 발생했습니다.");
            return "error";
        }
    }

    // 공지사항 작성 폼
    @GetMapping("/noticeForm")
    public String createForm() {
        return "customer/noticeForm";
    }

    // 공지사항 생성
    @PostMapping("/noticeCreate")
    public String createNotice(@RequestParam("title") String title,
                               @RequestParam("content") String content,
                               Model model) {
    	try {
        NoticeDTO notice = new NoticeDTO();
        notice.setTitle(title);
        notice.setContent(content);
        notice.setRegdate(new Timestamp(new Date().getTime()));
        noticeDAO.createNotice(notice);
        return "redirect:/customer/noticeList?page=1&size=10";
    	 } catch (Exception e) {
             model.addAttribute("errorMessage", "공지사항 생성 중 오류가 발생했습니다.");
             return "error";
         }
     }

    // 공지사항 수정 폼
    @GetMapping("/noticeUpdateForm")
    public String updateForm(@RequestParam("noticeNum") int noticeNum, Model model) {
    	try {
        NoticeDTO notice = noticeDAO.getNoticeDetail(noticeNum);
        model.addAttribute("notice", notice);
        return "customer/noticeUpdate";
    	} catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항 수정 폼을 가져오는 중 오류가 발생했습니다.");
            return "error";
        }
    }

    // 공지사항 수정
    @PostMapping("/noticeUpdate")
    public String updateNotice(@RequestParam("noticeNum") int noticeNum,
                               @RequestParam("title") String title,
                               @RequestParam("content") String content,
                               Model model) {
    	try {
        NoticeDTO notice = new NoticeDTO();
        notice.setNoticeNum(noticeNum);
        notice.setTitle(title);
        notice.setContent(content);
        notice.setChdate(new Timestamp(new Date().getTime()));
        noticeDAO.updateNotice(notice);
        return "redirect:/customer/noticeList?page=1&size=10";
    	} catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항 수정 중 오류가 발생했습니다.");
            return "error";
        }
    }

    // 공지사항 삭제
    @PostMapping("/noticeDelete")
    public String deleteNotice(@RequestParam("noticeNum") int noticeNum, Model model) {
    	try {
        noticeDAO.deleteNotice(noticeNum);
        return "redirect:/customer/noticeList?page=1&size=10";
    	} catch (Exception e) {
            model.addAttribute("errorMessage", "공지사항 삭제 중 오류가 발생했습니다.");
            return "error";
        }
    }
}
