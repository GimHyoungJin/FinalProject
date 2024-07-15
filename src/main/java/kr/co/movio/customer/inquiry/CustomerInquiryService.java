package kr.co.movio.customer.inquiry;

public interface CustomerInquiryService {
    void saveInquiry(CustomerInquiryDTO inquiryDTO);
    CustomerInquiryDTO getInquiryById(String inq_num);
    boolean checkDuplicateMemberId(String mem_id);
    boolean checkDuplicateTheaterId(String theater_id);
}
