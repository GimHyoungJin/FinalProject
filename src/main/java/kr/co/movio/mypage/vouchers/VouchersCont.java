package kr.co.movio.mypage.vouchers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
/* 오류 해결 
@Controller

@RequestMapping("/mypage/vouchers")

public class VouchersCont {

    @Autowired
    private VouchersService vouchersService;

    @GetMapping
    public String showVouchersPage(Model model) {
        return "mypage/vouchers"; // JSP 페이지 경로
    }

    @PostMapping("/register")
    public String registerVoucher(@RequestParam("voucherNumber") String voucherNumber, HttpSession session, RedirectAttributes redirectAttributes) {
        String memId = (String) session.getAttribute("mem_id"); // 세션에서 mem_id를 가져옴
        if (memId == null) {
            redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        boolean isValid = vouchersService.validateAndSaveVoucher(voucherNumber, memId);
        if (isValid) {
            redirectAttributes.addFlashAttribute("message", "관람권이 정상적으로 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "유효하지 않거나 이미 사용한 번호입니다.");
        }
        return "redirect:/mypage/vouchers";
    }
}
*/