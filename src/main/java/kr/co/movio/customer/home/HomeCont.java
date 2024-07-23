package kr.co.movio.customer.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.movio.customer.notice.NoticeDAO;
import java.util.List;
import kr.co.movio.customer.notice.NoticeDTO;

/**
 * HomeCont 클래스는 고객센터 홈 페이지를 처리하는 컨트롤러입니다.
 */
@Controller
@RequestMapping("/customer")
public class HomeCont {

    // NoticeDAO를 주입받아 사용합니다.
    @Autowired
    private NoticeDAO noticeDAO;

    /**
     * 홈 페이지를 보여주는 메서드입니다.
     * 최근 공지사항 목록을 모델에 추가하여 뷰에 전달합니다.
     *
     * @param model 뷰에 데이터를 전달하기 위한 모델 객체
     * @return 홈 페이지를 나타내는 뷰 이름
     */
    @GetMapping("/home")
    public String home(Model model) {
        try {
            // 최근 공지사항 목록을 모델에 추가
            List<NoticeDTO> recentNotices = noticeDAO.getNotices(0, 5); // 최근 5개의 공지사항을 가져옴
            model.addAttribute("noticeList", recentNotices);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "공지사항을 불러오는 중에 문제가 발생했습니다.");
        }
        return "customer/home"; // "customer/home" 뷰를 반환하여 홈 페이지를 표시합니다.
    }
}
