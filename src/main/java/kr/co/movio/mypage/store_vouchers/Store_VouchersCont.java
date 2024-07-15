package kr.co.movio.mypage.store_vouchers;

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
@RequestMapping("/mypage/store_vouchers")
public class Store_VouchersCont {

    @Autowired
    private Store_VouchersService storeVouchersService;

    @GetMapping
    public String showVouchersPage(Model model) {
        return "mypage/store_vouchers";
    }

    @PostMapping("/register")
    public String registerVoucher(@RequestParam("voucherNumber") String voucherNumber, HttpSession session, RedirectAttributes redirectAttributes) {
        String memId = (String) session.getAttribute("mem_id"); // 세션에서 mem_id를 가져옴
        boolean isValid = storeVouchersService.validateAndSaveVoucher(voucherNumber, memId);
        if (isValid) {
            redirectAttributes.addFlashAttribute("message", "교환권이 성공적으로 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "유효하지 않은 번호입니다.");
        }
        return "redirect:/mypage/store_vouchers";
    }
}
