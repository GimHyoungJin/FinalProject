package kr.co.movio.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

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
            return "redirect:/admin/members"; // 로그인 성공 후 회원 목록 페이지로 리디렉션
        } else {
            model.addAttribute("loginError", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "redirect:/"; // 로그인 실패 시 로그인 페이지로 이동
        }
    }

    @GetMapping("/members")
    public String getMembers(Model model) {
        model.addAttribute("members", memberDAO.getAllMembers());
        return "admin/members"; // 회원 목록 페이지로 이동
    }
}
