package kr.co.movio.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.movio.member.MemberDAO;
import kr.co.movio.member.MemberDTO;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/mypage")
public class MyPageCont {

    @Autowired
    private MemberDAO memberDAO;

    @GetMapping("/mypage")
    public String getMyPage(HttpSession session, Model model) {
        // 세션에서 사용자 정보를 가져와 모델에 추가
        String mem_id = (String) session.getAttribute("mem_id");
        if (mem_id != null) {
            MemberDTO member = memberDAO.findById(mem_id);
            model.addAttribute("username", member.getUsername());
            model.addAttribute("mem_grade", member.getMem_grade());
        } else {
            model.addAttribute("username", "강지천");
            model.addAttribute("mem_grade", -1); // 알 수 없음
        }
      
        return "mypage/mypage"; // JSP 파일 경로를 지정
    }

    @PostMapping("/login")
    public String login(@RequestParam("mem_id") String mem_id, 
                        @RequestParam("passwd") String passwd, 
                        HttpSession session, Model model) {
        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setMem_id(mem_id);
        memberDTO.setPasswd(passwd);

        MemberDTO member = memberDAO.findUserForLogin(memberDTO);

        if (member != null) {
            session.setAttribute("mem_id", member.getMem_id());
            session.setAttribute("username", member.getUsername());
            session.setAttribute("mem_grade", member.getMem_grade());
            return "redirect:/mypage/mypage"; // 로그인 성공 시 마이페이지로 리디렉트
        } else {
            model.addAttribute("error", "로그인 실패");
            return "login"; // 로그인 실패 시 로그인 페이지로 이동
        }
    }
}
