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
    public CustomerInquiryDTO findById(String inq_num) {
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
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("customer.findAllInquiries", params);
    }

    // 전체 문의 수 조회
    public int getTotalInquiries() {
        return sqlSession.selectOne("customer.getTotalInquiries");
    }

    // 키워드로 문의 검색
    public List<CustomerInquiryDTO> searchInquiries(String keyword) {
        return sqlSession.selectList("customer.searchInquiries", keyword);
    }

    // 문의 수정
    public int update(CustomerInquiryDTO inquiry) {
        return sqlSession.update("customer.update", inquiry);
    }

    // 문의 삭제
    public int delete(String inq_num) {
        return sqlSession.delete("customer.delete", inq_num);
    }

    // 문의 답변 저장
    public int saveInquiryDetail(InquiryDetailDTO detail) {
        return sqlSession.insert("customer.saveInquiryDetail", detail);
    }

    // 문의 번호로 문의 답변 찾기
    public List<InquiryDetailDTO> findInquiryDetailsByInquiryId(String inq_num) {
        return sqlSession.selectList("customer.findInquiryDetailsByInquiryId", inq_num);
    }
}
