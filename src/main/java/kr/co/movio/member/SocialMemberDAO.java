package kr.co.movio.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SocialMemberDAO {

    @Autowired
    private SqlSession sqlSession;

    public int countBySocialIdAndProvider(SocialMemberDTO socialMemberDTO) {
        System.out.println("DAO: countsocialIdAndProd 호출됨");
        return sqlSession.selectOne("socialMember.countSocialIdAndProd", socialMemberDTO);
    }

    public int saveSocialMember(SocialMemberDTO socialMemberDTO) {
        System.out.println("DAO: saveSocialMem 호출됨");
        return sqlSession.insert("socialMember.saveSocialMem", socialMemberDTO);
    }
    
   
}