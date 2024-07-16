package kr.co.movio.customer.terms;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * TermsCont 클래스는 고객센터의 이용약관 페이지를 처리하는 컨트롤러입니다.
 */
@Controller
@RequestMapping("/customer")
public class TermsCont {

    /**
     * 이용약관 페이지를 보여주는 메서드입니다.
     * 
     * @return 이용약관 페이지를 나타내는 뷰 이름
     */
    @GetMapping("/terms")
    public String showTermsPage() {
        return "customer/terms"; // "customer/terms" 뷰를 반환하여 이용약관 페이지를 표시합니다.
    }
}
