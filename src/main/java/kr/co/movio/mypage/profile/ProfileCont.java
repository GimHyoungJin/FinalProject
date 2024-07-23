package kr.co.movio.mypage.profile;

import kr.co.movio.member.MemberDAO;
import kr.co.movio.member.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/mypage/profile")
public class ProfileCont {

    @Autowired
    private MemberDAO memberDAO;

    @GetMapping
    public String getProfile(HttpSession session, Model model) {
        String memId = (String) session.getAttribute("mem_id");
        if (memId != null) {
            MemberDTO member = memberDAO.findById(memId);
            model.addAttribute("profile", member);
        } else {
            model.addAttribute("profile", new MemberDTO());
        }
        return "mypage/profile";
    }

    @PostMapping("/delete")
    public String deleteProfile(@RequestParam("memId") String memId, HttpSession session) {
        memberDAO.softDeleteMember(memId);
        session.invalidate();  // 세션 무효화
        return "redirect:/";  // 홈페이지 경로로 리다이렉트
    }

    @PostMapping
    public String updateProfile(MemberDTO member, HttpSession session, Model model) {
        String memId = (String) session.getAttribute("mem_id");
        member.setMem_id(memId);

        if (memId == null || !memId.equals(member.getMem_id())) {
            model.addAttribute("error", "잘못된 접근입니다.");
            return "mypage/profile";
        }

        try {
            memberDAO.updateMember(member);
            session.setAttribute("updateSuccess", "Y");
        } catch (Exception e) {
            model.addAttribute("error", "프로필 업데이트 중 오류가 발생했습니다.");
            return "mypage/profile";
        }

        return "redirect:/mypage/profile";
    }

  
}
