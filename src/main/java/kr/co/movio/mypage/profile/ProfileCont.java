package kr.co.movio.mypage.profile;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

@Controller
@RequestMapping("/mypage")
public class ProfileCont {

    @GetMapping("/profile")
    public String showProfilePage(Model model) {
        // 필요한 데이터를 모델에 추가
        return "mypage/profile";
    }
}
