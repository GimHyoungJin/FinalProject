package kr.co.movio.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.co.movio.member.MemberDAO;
import kr.co.movio.member.MemberDTO;

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

    @GetMapping("/members/edit")
    public String editMember(@RequestParam("mem_id") String mem_id, Model model) {
        MemberDTO member = memberDAO.findById(mem_id);
        model.addAttribute("member", member);
        return "admin/editMembers"; // 회원 수정 페이지로 이동
    }

    @PostMapping("/members/update")
    public String updateMember(@ModelAttribute MemberDTO member) {
        memberDAO.updateMember(member); // 업데이트 메서드 호출
        return "redirect:/admin/members";
    }

    @PostMapping("/members/delete")
    public String deleteMember(@RequestParam("mem_id") String mem_id) {
        memberDAO.deleteMember(mem_id); // 삭제 메서드 호출
        return "redirect:/admin/members";
    }
}
