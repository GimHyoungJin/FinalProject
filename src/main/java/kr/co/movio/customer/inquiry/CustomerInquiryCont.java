package kr.co.movio.customer.inquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/customer")
public class CustomerInquiryCont {

    @Autowired
    private CustomerInquiryService inquiryService;

    // 문의 작성 폼 보여주기
    @GetMapping("/inquiryForm")
    public ModelAndView showInquiryForm() {
        ModelAndView mav = new ModelAndView("customer/inquiryForm");
        return mav;
    }

    
    @PostMapping("/submitInquiry")
    public String submitInquiry(CustomerInquiryDTO inquiryDTO, RedirectAttributes redirectAttributes) {
        inquiryService.saveInquiry(inquiryDTO);
        redirectAttributes.addFlashAttribute("message", "1:1 문의가 등록되었습니다.");
        return "redirect:/customer/inquiryList";
    }

    // 문의 목록 보여주기
    @GetMapping("/inquiryList")
    public ModelAndView showInquiryList(@RequestParam(value = "page", required = false) Integer page,
                                        @RequestParam(value = "keyword", required = false) String keyword) {
        ModelAndView mav = new ModelAndView("customer/inquiryList");

        // 페이지가 null인 경우 기본값을 설정
        int currentPage = (page != null) ? page : 1;
        int pageSize = 10;  // 한 페이지에 보여줄 항목 수

        List<CustomerInquiryDTO> inquiries;
        int totalInquiries;

        // 검색어가 있는 경우와 없는 경우의 처리를 구분
        if (keyword != null && !keyword.isEmpty()) {
            inquiries = inquiryService.searchInquiries(keyword, (currentPage - 1) * pageSize, pageSize);
            totalInquiries = inquiryService.getTotalInquiriesByKeyword(keyword);
            mav.addObject("keyword", keyword);
        } else {
            inquiries = inquiryService.getAllInquiries((currentPage - 1) * pageSize, pageSize);
            totalInquiries = inquiryService.getTotalInquiries();
        }

        mav.addObject("inquiries", inquiries);

        // 전체 문의 수를 가져와서 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalInquiries / pageSize);

        mav.addObject("currentPage", currentPage);
        mav.addObject("totalPages", totalPages);

        return mav;
    }



    // 문의 상세 보기
    @GetMapping("/inquiryDetail")
    public ModelAndView showInquiryDetail(String inq_num) {
        ModelAndView mav = new ModelAndView("customer/inquiryDetail");
        CustomerInquiryDTO inquiry = inquiryService.getInquiryById(inq_num);
        mav.addObject("inquiry", inquiry);
        return mav;
    }

    // 문의 수정 폼 보여주기
    @GetMapping("/inquiryEditForm")
    public ModelAndView showInquiryEditForm(String inq_num) {
        ModelAndView mav = new ModelAndView("customer/inquiryEditForm");
        CustomerInquiryDTO inquiry = inquiryService.getInquiryById(inq_num);
        mav.addObject("inquiry", inquiry);
        return mav;
    }

    // 문의 수정
    @PostMapping("/editInquiry")
    public String editInquiry(CustomerInquiryDTO inquiryDTO) {
        inquiryService.updateInquiry(inquiryDTO);
        return "redirect:/customer/inquiryDetail?inq_num=" + inquiryDTO.getInq_num();
    }

    // 문의 삭제
    @PostMapping("/deleteInquiry")
    public String deleteInquiry(String inq_num) {
        inquiryService.deleteInquiry(inq_num);
        return "redirect:/customer/inquiryList";
    }
}
