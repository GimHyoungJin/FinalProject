package kr.co.movio.customer.terms;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/customer")
public class TermsCont {

    @GetMapping("/terms")
    public String showTermsPage() {
        return "customer/terms";
    }
}
