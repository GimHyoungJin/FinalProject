package kr.co.movio.customer.inquiry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
// 서비스 구현 클래스: 인터페이스의 메서드를 구현
public class CustomerInquiryServiceImpl implements CustomerInquiryService {

    @Autowired
    private CustomerInquiryDAO inquiryDAO;

    @Override
    // 문의 저장
    public void saveInquiry(CustomerInquiryDTO inquiryDTO) {
        inquiryDAO.save(inquiryDTO);
    }

    @Override
    // 문의 번호로 문의 찾기
    public CustomerInquiryDTO getInquiryById(int inq_num) {
        return inquiryDAO.findById(inq_num);
    }

    @Override
    // 회원 ID로 문의 중복 확인
    public boolean checkDuplicateMemberId(String mem_id) {
        return inquiryDAO.countByMemberId(mem_id) > 0;
    }

    @Override
    // 극장 ID로 문의 중복 확인
    public boolean checkDuplicateTheaterId(String theater_id) {
        return inquiryDAO.countByTheaterId(theater_id) > 0;
    }

    @Override
    // 전체 문의 목록 조회
    public List<CustomerInquiryDTO> getAllInquiries(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return inquiryDAO.findAllInquiries(offset, pageSize);
    }

    @Override
    // 전체 문의 수 조회
    public int getTotalInquiries() {
        return inquiryDAO.getTotalInquiries();
    }

    @Override
    // 문의 수정
    public void updateInquiry(CustomerInquiryDTO inquiryDTO) {
        inquiryDAO.update(inquiryDTO);
    }

    @Override
    // 문의 삭제
    public void deleteInquiry(String inq_num) {
        inquiryDAO.delete(inq_num);
    }

    @Override
    // 문의 답변 저장
    public void saveInquiryDetail(InquiryDetailDTO detailDTO) {
        inquiryDAO.saveInquiryDetail(detailDTO);
    }

    @Override
    // 문의 번호로 문의 답변 찾기
    public List<InquiryDetailDTO> getInquiryDetailsByInquiryId(int inq_num) {
        return inquiryDAO.findInquiryDetailsByInquiryId(inq_num);
    }

    @Override
    // 키워드로 문의 검색 (페이지네이션 추가)
    public List<CustomerInquiryDTO> searchInquiries(String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return inquiryDAO.searchInquiries(keyword, offset, pageSize);
    }

    @Override
    // 키워드로 검색된 전체 문의 수 조회
    public int getTotalInquiriesByKeyword(String keyword) {
        return inquiryDAO.getTotalInquiriesByKeyword(keyword);
    }
    
    @Override
    //문의글에 대한 비밀번호 확인
    public boolean verifyPassword(int inqNum, String password) {
        CustomerInquiryDTO inquiry = inquiryDAO.findByInqNum(inqNum);
        return inquiry != null && inquiry.getPassword().equals(password);
    }
    
    @Override
    //mem_id로 유저 이름 가져오기
    public String getUsernameByMemId(String memId) {
        return inquiryDAO.getUsernameByMemId(memId);
    }
}
