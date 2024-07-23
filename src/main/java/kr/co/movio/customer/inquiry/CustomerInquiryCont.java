package kr.co.movio.customer.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/customer")
public class CustomerInquiryCont {

    @Autowired
    private CustomerInquiryService inquiryService;

    @GetMapping("/inquiryForm")
    public ModelAndView showInquiryForm(HttpSession session) {
        ModelAndView mav = new ModelAndView("customer/inquiryForm");
        String memId = (String) session.getAttribute("mem_id");
        mav.addObject("mem_id", memId);
        return mav;
    }

    @PostMapping("/submitInquiry")
    public String submitInquiry(CustomerInquiryDTO inquiryDTO, HttpSession session, RedirectAttributes redirectAttributes) {
        String memId = (String) session.getAttribute("mem_id");
        inquiryDTO.setMem_id(memId); // 세션에서 가져온 mem_id 설정
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
    
 // 비밀번호 확인 엔드포인트
    @PostMapping("/verifyPassword")
    @ResponseBody
    public Map<String, Object> verifyPassword(@RequestParam("inq_num") int inqNum, @RequestParam("password") String password) {
        boolean isValid = inquiryService.verifyPassword(inqNum, password);
        Map<String, Object> response = new HashMap<>();
        response.put("valid", isValid);
        return response;
    }
    
    
    // 문의 상세 보기
    @GetMapping("/inquiryDetail")
    public ModelAndView showInquiryDetail(@RequestParam("inq_num") int inqNum, HttpSession session) {
        ModelAndView mav = new ModelAndView("customer/inquiryDetail");

        CustomerInquiryDTO inquiry = inquiryService.getInquiryById(inqNum);
        String memId = inquiry.getMem_id();
        String username = inquiryService.getUsernameByMemId(memId);

        mav.addObject("inquiry", inquiry);
        mav.addObject("username", username);

        return mav;
    }
    
    
    // 문의 수정 폼 보여주기
    @GetMapping("/inquiryEditForm")
    public ModelAndView showInquiryEditForm(int inq_num) {
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
    public String deleteInquiry(int inq_num) {
        inquiryService.deleteInquiry(inq_num);
        return "redirect:/customer/inquiryList";
    }
}
