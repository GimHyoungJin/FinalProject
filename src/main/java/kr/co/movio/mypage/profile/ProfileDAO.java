package kr.co.movio.mypage.profile;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProfileDAO {

    @Autowired
    private SqlSession sqlSession;

    public ProfileDTO getProfileById(String memId) {
        return sqlSession.selectOne("profile.getProfileById", memId);
    }

    public void updateProfile(ProfileDTO profile) {
        sqlSession.update("profile.updateProfile", profile);
    }

    public void insertProfile(ProfileDTO profile) {
        sqlSession.insert("profile.insertProfile", profile);
    }
}
