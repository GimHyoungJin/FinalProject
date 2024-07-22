package kr.co.movio.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class MyPageCont {

    @GetMapping("/mypage")
    public String getMyPage(HttpSession session, Model model) {
        // 세션에서 사용자 정보를 가져와 모델에 추가
        String username = (String) session.getAttribute("username");
        Integer mem_grade = (Integer) session.getAttribute("mem_grade");
       

        // 세션에 값이 없는 경우 기본 값 설정
        if (username == null) {
            username = "강지천";
        }
        if (mem_grade == null) {
            mem_grade = -1; // 알 수 없음
        }
        
        model.addAttribute("username", username);
        model.addAttribute("mem_grade", mem_grade);
      
        return "mypage/mypage"; // JSP 파일 경로를 지정
    }
}
