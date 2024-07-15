package kr.co.movio.mypage.vouchers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage/vouchers")
public class VouchersCont {

    @Autowired
    private VoucherService voucherService;

    @GetMapping
    public String showVouchersPage(Model model) {
        return "mypage/vouchers";
    }

    @PostMapping("/register")
    public String registerVoucher(@RequestParam("voucherNumber") String voucherNumber, HttpSession session, RedirectAttributes redirectAttributes) {
        String memId = (String) session.getAttribute("mem_id"); // 세션에서 mem_id를 가져옴
        boolean isValid = voucherService.validateAndSaveVoucher(voucherNumber, memId);
        if (isValid) {
            redirectAttributes.addFlashAttribute("message", "관람권이 성공적으로 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "유효하지 않은 번호입니다.");
        }
        return "redirect:/mypage/vouchers";
    }
}
