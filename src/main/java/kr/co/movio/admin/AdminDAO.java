package kr.co.movio.admin;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdminDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "kr.co.movio.admin.AdminDAO";

    public List<AdminDTO> getAllMembers() {
        return sqlSession.selectList(NAMESPACE + ".getAllMembers");
    }

    public AdminDTO selectMemberByUsername(String username) {
        return sqlSession.selectOne(NAMESPACE + ".selectMemberByUsername", username);
    }
}
