package kr.co.movio.customer.inquiry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/customer")
public class CustomerInquiryCont {

    @Autowired
    private CustomerInquiryService inquiryService;

    @GetMapping("/inquiryForm")
    public ModelAndView showInquiryForm() {
        ModelAndView mav = new ModelAndView("customer/inquiryForm");
        return mav;
    }

    @PostMapping("/submitInquiry")
    public String submitInquiry(CustomerInquiryDTO inquiryDTO) {
        inquiryService.saveInquiry(inquiryDTO);
        return "redirect:/customer/inquiryForm";
    }
}
