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
        String currentGrade = (String) session.getAttribute("currentGrade");
        Integer points = (Integer) session.getAttribute("points");
        Integer nextGradePoints = (Integer) session.getAttribute("nextGradePoints");

        // 세션에 값이 없는 경우 기본 값 설정
        if (username == null) {
            username = "강지천";
        }
        if (currentGrade == null) {
            currentGrade = "WELCOME";
        }
        if (points == null) {
            points = 0;
        }
        if (nextGradePoints == null) {
            nextGradePoints = 6000;
        }

        model.addAttribute("username", username);
        model.addAttribute("currentGrade", currentGrade);
        model.addAttribute("points", points);
        model.addAttribute("nextGradePoints", nextGradePoints);

        return "mypage/mypage"; // JSP 파일 경로를 지정
    }
}
