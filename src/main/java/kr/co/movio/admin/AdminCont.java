package kr.co.movio.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import kr.co.movio.member.MemberDTO;
import kr.co.movio.member.MemberDAO;

@Controller
@RequestMapping("/admin")
public class AdminCont {

    @Autowired
    private MemberDAO memberDAO;

    @GetMapping("/members")
    public String getMembers(Model model) {
        model.addAttribute("members", memberDAO.getAllMembers());
        return "admin/members"; // 회원 목록 페이지로 이동
    }
    
  

    
    
    
}
