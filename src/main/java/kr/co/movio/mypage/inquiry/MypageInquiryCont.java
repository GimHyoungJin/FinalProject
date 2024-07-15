package kr.co.movio.mypage.inquiry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;

import java.util.List;

@Controller
@RequestMapping("/mypage")
public class MypageInquiryCont {

    @Autowired
    private MypageInquiryService inquiryService;

    @RequestMapping("/inquiry")
    public String getInquiryList(HttpSession session, Model model) {
        String memId = (String) session.getAttribute("mem_id");

        // 세션에서 mem_id를 가져와서 조회
        List<MypageInquiryDTO> inquiry = inquiryService.getInquiriesByMemberId(memId);
        
        // 데이터 확인을 위한 로그 추가
        System.out.println("Inquiries: " + inquiry);

        model.addAttribute("inquiry", inquiry);
        return "mypage/inquiry";
    }
}
