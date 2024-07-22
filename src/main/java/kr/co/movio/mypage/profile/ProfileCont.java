package kr.co.movio.mypage.profile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage/profile")
public class ProfileCont {

    @Autowired
    private ProfileDAO profileDAO;

    @GetMapping
    public String getProfile(HttpSession session, Model model) {
        // 세션에서 로그인된 사용자 정보 가져오기
        String memId = (String) session.getAttribute("mem_id");
        if (memId != null) {
            ProfileDTO profile = profileDAO.getProfileById(memId);
            model.addAttribute("profile", profile);
        } else {
            model.addAttribute("profile", new ProfileDTO());
        }
        return "mypage/profile"; // JSP 파일 경로
    }

    @PostMapping
    public String updateProfile(ProfileDTO profile, HttpSession session, Model model) {
        // 세션에서 로그인된 사용자 정보 가져오기
        String memId = (String) session.getAttribute("mem_id");
        if (memId == null || !memId.equals(profile.getMemId())) {
            model.addAttribute("error", "잘못된 접근입니다.");
            return "mypage/profile";
        }
        
        // 세션에서 가져온 memId를 ProfileDTO 객체에 설정
        profile.setMemId(memId);

        try {
            // 프로필 정보를 데이터베이스에 업데이트
            profileDAO.updateProfile(profile);
        } catch (Exception e) {
            model.addAttribute("error", "프로필 업데이트 중 오류가 발생했습니다.");
            return "mypage/profile";
        }

        return "redirect:/mypage/profile";
    }
}
