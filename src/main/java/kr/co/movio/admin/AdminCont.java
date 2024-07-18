package kr.co.movio.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.co.movio.member.MemberDAO;
import kr.co.movio.member.MemberDTO;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/members")
public class AdminCont {

    @Autowired
    private MemberDAO memberDAO;

    @GetMapping
    public String getMembers(Model model) {
        model.addAttribute("members", memberDAO.getAllMembers());
        return "admin/members"; // 회원 목록 페이지로 이동
    }

    @GetMapping("/edit")
    public String editMember(@RequestParam("mem_id") String mem_id, Model model) {
        MemberDTO member = memberDAO.findById(mem_id);
        model.addAttribute("member", member);
        return "admin/editMembers"; // 회원 수정 페이지로 이동
    }

    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> addMember(@ModelAttribute MemberDTO member) {
        Map<String, Object> response = new HashMap<>();
        try {
            memberDAO.save(member);
            response.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "회원 추가에 실패했습니다.");
        }
        return response;
    }

    @PostMapping("/update")
    public String updateMember(@ModelAttribute MemberDTO member) {
        memberDAO.updateMember(member);
        return "redirect:/admin/members";
    }

    @PostMapping("/delete")
    public String deleteMember(@RequestParam("mem_id") String mem_id) {
        memberDAO.deleteMember(mem_id);
        return "redirect:/admin/members";
    }
}
