package kr.co.movio.customer.inquiry;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

@Repository
public class CustomerInquiryDAO {

    @Autowired
    private SqlSession sqlSession;

    // 문의 저장
    public int save(CustomerInquiryDTO inquiry) {
        return sqlSession.insert("customer.save", inquiry);
    }

    // 문의 번호로 문의 찾기
    public CustomerInquiryDTO findById(int inq_num) {
        return sqlSession.selectOne("customer.findById", inq_num);
    }

    // 회원 ID로 문의 수 찾기
    public int countByMemberId(String mem_id) {
        return sqlSession.selectOne("customer.countByMemberId", mem_id);
    }

    // 극장 ID로 문의 수 찾기
    public int countByTheaterId(String theater_id) {
        return sqlSession.selectOne("customer.countByTheaterId", theater_id);
    }

    // 전체 문의 목록 조회
    public List<CustomerInquiryDTO> findAllInquiries(int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", Math.max(offset, 0));  // offset이 음수가 되지 않도록 처리
        params.put("limit", limit);
        return sqlSession.selectList("customer.findAllInquiries", params);
    }

    // 전체 문의 수 조회
    public int getTotalInquiries() {
        return sqlSession.selectOne("customer.getTotalInquiries");
    }

    // 키워드로 문의 검색
    public List<CustomerInquiryDTO> searchInquiries(String keyword, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("offset", Math.max(offset, 0));  // offset이 음수가 되지 않도록 처리
        params.put("limit", limit);
        return sqlSession.selectList("customer.searchInquiries", params);
    }

    // 키워드로 검색된 전체 문의 수 조회
    public int getTotalInquiriesByKeyword(String keyword) {
        return sqlSession.selectOne("customer.getTotalInquiriesByKeyword", keyword);
    }

    // 문의 수정
    public int update(CustomerInquiryDTO inquiry) {
        return sqlSession.update("customer.update", inquiry);
    }

    // 문의 삭제
    public void delete(int inq_num) {
        // inquirydetail 테이블에서 관련 레코드 삭제
        sqlSession.delete("customer.deleteInquiryDetail", inq_num);
        // inquiry 테이블에서 레코드 삭제
        sqlSession.delete("customer.delete", inq_num);
    }

    // 문의 답변 저장
    public int saveInquiryDetail(InquiryDetailDTO detail) {
        return sqlSession.insert("customer.saveInquiryDetail", detail);
    }

    // 문의 번호로 문의 답변 찾기
    public List<InquiryDetailDTO> findInquiryDetailsByInquiryId(int inq_num) {
        return sqlSession.selectList("customer.findInquiryDetailsByInquiryId", inq_num);
    }
    
    //inq_num에 맞는 비밀번호 찾기 
    public CustomerInquiryDTO findByInqNum(int inq_num) {
        return sqlSession.selectOne("customer.findByInqNum", inq_num);
    }
    
    public String getUsernameByMemId(String memId) {
        return sqlSession.selectOne("customer.getUsernameByMemId", memId);
    }
    
    public void addReply(InquiryDetailDTO inquiryDetailDTO) {
        sqlSession.insert("customer.addReply", inquiryDetailDTO);
    }
    
    
    
    public List<InquiryDetailDTO> getRepliesByInquiryId(int inq_num) {
        return sqlSession.selectList("customer.getRepliesByInquiryId", inq_num);
    }
    
    public void updateInquiryStatus(int inq_num, String status) {
        sqlSession.update("customer.updateInquiryStatus", Map.of("inq_num", inq_num, "status", status));
    }
}
