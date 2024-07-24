package kr.co.movio.customer.inquiry;

import java.util.List;

// 서비스 인터페이스: 비즈니스 로직을 정의
public interface CustomerInquiryService {
    // 문의 저장
    void saveInquiry(CustomerInquiryDTO inquiryDTO);

    // 문의 번호로 문의 찾기
    CustomerInquiryDTO getInquiryById(int inqNum);

    // 회원 ID로 문의 중복 확인
    boolean checkDuplicateMemberId(String mem_id);

    // 극장 ID로 문의 중복 확인
    boolean checkDuplicateTheaterId(String theater_id);

    // 전체 문의 목록 조회
    List<CustomerInquiryDTO> getAllInquiries(int page, int pageSize);

    // 전체 문의 수 조회
    int getTotalInquiries();

    // 문의 수정
    void updateInquiry(CustomerInquiryDTO inquiryDTO);

    // 문의 삭제
    void deleteInquiry(int inq_num);

    // 문의 답변 저장
    void saveInquiryDetail(InquiryDetailDTO detailDTO);

    // 문의 번호로 문의 답변 찾기
    List<InquiryDetailDTO> getInquiryDetailsByInquiryId(int inq_num);

    // 키워드로 문의 검색 (페이지네이션 추가)
    List<CustomerInquiryDTO> searchInquiries(String keyword, int page, int pageSize);

    // 키워드로 검색된 전체 문의 수 조회
    int getTotalInquiriesByKeyword(String keyword);
    
    //문의 내역 비밀번호 확인 
   boolean verifyPassword(int inqNum, String password);
   
   //memID로 유저 이름 가져오기
   String getUsernameByMemId(String memId);
   
   //답변다는 쿼리문
   void addReply(InquiryDetailDTO inquriyDetailDTO);
   
   //답변 보여주기
   List<InquiryDetailDTO> getRepliesByInquiryId(int inq_num);
   
        
}
