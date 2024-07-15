package kr.co.movio.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {

    @Autowired
    private SqlSession sqlSession;
    
    public int countById(String mem_id) {
        return sqlSession.selectOne("member.countById", mem_id);
    }

    public int countByEmail(String email) {
        return sqlSession.selectOne("member.countByEmail", email);
    }

    public int countByPhone(String phone) {
        return sqlSession.selectOne("member.countByPhone", phone);
    }

    public MemberDTO findById(String mem_id) {
        return sqlSession.selectOne("member.findById", mem_id);
    }

    public int save(MemberDTO member) {
        return sqlSession.insert("member.save", member);
    }
    
    // 아이디와 이메일 찾기
    public MemberDTO findUserByUsernameAndPhone(MemberDTO memberDTO) {
        return sqlSession.selectOne("member.findUserByUsernameAndPhone", memberDTO);
    }
    
    public MemberDTO findUserByIdEmailAndPhone(MemberDTO memberDTO) {
        return sqlSession.selectOne("member.findUserByIdEmailAndPhone", memberDTO);
    }
    
    //새롭게 설정한 passwd를 다시 DB에 업로드
    public int updatePassword(MemberDTO memberDTO) {
        return sqlSession.update("member.updatePassword", memberDTO);
    }
}