package kr.co.movio.admin;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Repository
public class AdminDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<AdminDTO> getAllMembers() {
        return sqlSession.selectList("admin.getAllMembers");
    }

    public void updateMemberStatus(int memberId, String status) {
        Map<String, Object> params = new HashMap<>();
        params.put("memberId", memberId);
        params.put("status", status);
        sqlSession.update("admin.updateMemberStatus", params);
    }
}
