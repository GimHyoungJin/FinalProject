package kr.co.movio.mypage.profile;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.sql.Timestamp;

@Repository
public class ProfileDAO {

    @Autowired
    private SqlSession sqlSession;

    public ProfileDTO getProfileById(String memId) {
        return sqlSession.selectOne("profile.getProfileById", memId);
    }

    public ProfileDTO getProfileByEmail(String email) {
        return sqlSession.selectOne("profile.getProfileByEmail", email);
    }

    public void updateProfile(ProfileDTO profile) {
        sqlSession.update("profile.updateProfile", profile);
    }

    public void insertProfile(ProfileDTO profile) {
        // 현재 시간을 regdate로 설정
        profile.setRegdate(new Timestamp(System.currentTimeMillis()));

        // smsAgree와 emailAgree의 기본 값을 설정
        if (profile.getSmsAgree() == null) {
            profile.setSmsAgree("N");
        }
        if (profile.getEmailAgree() == null) {
            profile.setEmailAgree("N");
        }

        sqlSession.insert("profile.insertProfile", profile);
    }
}
