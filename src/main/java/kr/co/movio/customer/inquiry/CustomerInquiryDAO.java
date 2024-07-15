package kr.co.movio.customer.inquiry;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerInquiryDAO {

    @Autowired
    private SqlSession sqlSession;

    public int save(CustomerInquiryDTO inquiry) {
        return sqlSession.insert("customer.save", inquiry);
    }

    public CustomerInquiryDTO findById(String inq_num) {
        return sqlSession.selectOne("customer.findById", inq_num);
    }

    public int countByMemberId(String mem_id) {
        return sqlSession.selectOne("customer.countByMemberId", mem_id);
    }

    public int countByTheaterId(String theater_id) {
        return sqlSession.selectOne("customer.countByTheaterId", theater_id);
    }
}
