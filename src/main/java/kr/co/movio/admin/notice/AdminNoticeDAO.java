package kr.co.movio.admin.notice;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

@Repository
public class AdminNoticeDAO {

    @Autowired
    private SqlSession sqlSession;

    // 공지사항 목록 조회
    public List<AdminNoticeDTO> getNotices(int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", Math.max(offset, 0));  // offset이 음수가 되지 않도록 처리
        params.put("limit", limit);
        return sqlSession.selectList("customerNotice.getNotices", params);
    }

    // 총 공지사항 수 조회
    public int getTotalNotices() {
        return sqlSession.selectOne("customerNotice.getTotalNotices");
    }

    // 공지사항 생성
    public void createNotice(AdminNoticeDTO notice) {
        sqlSession.insert("customerNotice.createNotice", notice);
    }

    // 공지사항 수정
    public void updateNotice(AdminNoticeDTO notice) {
        sqlSession.update("customerNotice.updateNotice", notice);
    }

    // 공지사항 삭제
    public void deleteNotice(int noticeNum) {
        sqlSession.delete("customerNotice.deleteNotice", noticeNum);
    }

    // 공지사항 상세보기
    public AdminNoticeDTO getNoticeDetail(int noticeNum) {
        return sqlSession.selectOne("customerNotice.getNoticeDetail", noticeNum);
    }

    // 조회수 증가
    public void increaseViewCount(int noticeNum) {
        sqlSession.update("customerNotice.increaseViewCount", noticeNum);
    }
}
