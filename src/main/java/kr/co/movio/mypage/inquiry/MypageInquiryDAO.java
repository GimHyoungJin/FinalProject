package kr.co.movio.mypage.inquiry;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MypageInquiryDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "mypageInquiryMapper";

    public List<MypageInquiryDTO> getInquiriesByMemberId(String memId) {
        // 데이터 확인을 위한 로그 추가
        List<MypageInquiryDTO> inquiry = sqlSession.selectList(NAMESPACE + ".getInquiriesByMemberId", memId);
        System.out.println("DAO Inquiries: " + inquiry);
        return inquiry;
    }
}
