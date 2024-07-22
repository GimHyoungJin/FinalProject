package kr.co.movio.customer.inquiry;

import java.util.List;

// 서비스 인터페이스: 비즈니스 로직을 정의
public interface CustomerInquiryService {
    // 문의 저장
    void saveInquiry(CustomerInquiryDTO inquiryDTO);

    // 문의 번호로 문의 찾기
    CustomerInquiryDTO getInquiryById(String inq_num);

    // 회원 ID로 문의 중복 확인
    boolean checkDuplicateMemberId(String mem_id);

    // 극장 ID로 문의 중복 확인
    boolean checkDuplicateTheaterId(String theater_id);

    // 전체 문의 목록 조회
    List<CustomerInquiryDTO> getAllInquiries();

    // 문의 수정
    void updateInquiry(CustomerInquiryDTO inquiryDTO);

    // 문의 삭제
    void deleteInquiry(String inq_num);

    // 문의 답변 저장
    void saveInquiryDetail(InquiryDetailDTO detailDTO);

    // 문의 번호로 문의 답변 찾기
    List<InquiryDetailDTO> getInquiryDetailsByInquiryId(String inq_num);

    // 키워드로 문의 검색
    List<CustomerInquiryDTO> searchInquiries(String keyword);
}
