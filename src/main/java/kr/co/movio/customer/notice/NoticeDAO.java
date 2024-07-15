package kr.co.movio.customer.notice;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NoticeDAO {

    @Autowired
    private SqlSession sqlSession;

    // 공지사항 목록을 최신순으로 가져오기
    public List<NoticeDTO> getRecentNotices() {
        return sqlSession.selectList("notice.getRecentNotices");
    }

    // 공지사항 수 카운트
    public int countNotices() {
        return sqlSession.selectOne("notice.countNotices");
    }

    // 공지사항 ID로 공지사항 가져오기
    public NoticeDTO getNoticeById(int noticeNum) {
        return sqlSession.selectOne("notice.getNoticeById", noticeNum);
    }

    // 공지사항 저장
    public int saveNotice(NoticeDTO notice) {
        return sqlSession.insert("notice.saveNotice", notice);
    }

    // 공지사항 업데이트
    public int updateNotice(NoticeDTO notice) {
        return sqlSession.update("notice.updateNotice", notice);
    }

    // 공지사항 삭제
    public int deleteNotice(int noticeNum) {
        return sqlSession.delete("notice.deleteNotice", noticeNum);
    }
}
