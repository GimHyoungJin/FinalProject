package kr.co.movio.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminCont {

    @Autowired
    private AdminDAO memberDAO;

    @PostMapping("/member/login")
    public String login(@RequestParam("mem_id") String username,
                        @RequestParam("passwd") String password,
                        HttpSession session,
                        Model model) {
        AdminDTO member = memberDAO.selectMemberByUsername(username);
        if (member != null && member.getPassword().equals(password)) {
            session.setAttribute("member", member);
            return "redirect:/admin/members"; // 로그인 성공 후 리디렉션
        } else {
            model.addAttribute("loginError", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "redirect:/"; // 로그인 실패 시 로그인 페이지로 이동
        }
    }

    @GetMapping("/members")
    public String getMembers(Model model, HttpSession session) {
        AdminDTO member = (AdminDTO) session.getAttribute("member");
        if (member != null && member.getGrade() == 0) { // 관리자인 경우
            model.addAttribute("members", memberDAO.getAllMembers());
            return "admin/members";
        } else {
            return "admin/accessDenied"; // 접근 권한이 없는 경우
        }
    }
}
