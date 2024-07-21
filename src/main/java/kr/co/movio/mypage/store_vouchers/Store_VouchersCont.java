package kr.co.movio.mypage.store_vouchers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;

import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/mypage/store_vouchers")
public class Store_VouchersCont {

    @Autowired
    private Store_VouchersDAO storeVouchersDAO;

    @GetMapping
    public String showVouchersPage(Model model) {
        List<Store_VouchersDTO> vouchers = storeVouchersDAO.findAll();
        model.addAttribute("vouchers", vouchers);
        return "mypage/store_vouchers";
    }

    @PostMapping("/register")
    @ResponseBody
    public Map<String, Object> registerVoucher(@RequestParam("voucherNumber") String voucherNumber,
                                               @RequestParam("category") String category,
                                               @RequestParam("voucherName") String voucherName) {
        Map<String, Object> response = new HashMap<>();

        // 입력 받은 값을 로그로 출력
        System.out.println("Voucher Number: " + voucherNumber);
        System.out.println("Category: " + category);
        System.out.println("Voucher Name: " + voucherName);

        if (!isValidVoucherNumber(voucherNumber)) {
            response.put("success", false);
            response.put("message", "유효하지 않은 교환권 번호입니다.");
            return response;
        }

        Store_VouchersDTO existingVoucher = storeVouchersDAO.findByOrderNo(voucherNumber);
        if (existingVoucher == null) {
            Store_VouchersDTO newVoucher = new Store_VouchersDTO();
            newVoucher.setOrderNo(voucherNumber);
            newVoucher.setCategory(category);
            newVoucher.setVoucherName(voucherName);
            newVoucher.setExpirationDate(java.sql.Date.valueOf("2025-07-19"));
            newVoucher.setStatus("unused");
            storeVouchersDAO.insertVoucher(newVoucher);

            List<Store_VouchersDTO> vouchers = storeVouchersDAO.findAll();
            String voucherListHtml = vouchers.stream()
                                             .map(v -> "<tr><td>" + v.getCategory() + "</td><td>" + v.getVoucherName() + "</td><td>" + v.getExpirationDate() + "</td><td>" + v.getStatus() + "</td></tr>")
                                             .collect(Collectors.joining());
            response.put("success", true);
            response.put("voucherListHtml", "<table class='table'><thead><tr><th>구분</th><th>교환권명</th><th>유효기간</th><th>사용상태</th></tr></thead><tbody>" + voucherListHtml + "</tbody></table>");
        } else {
            response.put("success", false);
            response.put("message", "유효하지 않은 번호입니다.");
        }
        return response;
    }

    private boolean isValidVoucherNumber(String voucherNumber) {
        return voucherNumber != null && voucherNumber.matches("\\d{18}");
    }
}
