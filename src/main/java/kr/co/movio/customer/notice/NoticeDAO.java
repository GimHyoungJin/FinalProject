package kr.co.movio.customer.notice;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

@Repository
public class NoticeDAO {

    @Autowired
    private SqlSession sqlSession;

    // 공지사항 목록 조회
    public List<NoticeDTO> getNotices(int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("NoticeMapper.getNotices", params);
    }

    // 총 공지사항 수 조회
    public int getTotalNotices() {
        return sqlSession.selectOne("NoticeMapper.getTotalNotices");
    }

    // 공지사항 상세 조회
    public NoticeDTO getNoticeDetail(int noticeNum) {
        return sqlSession.selectOne("NoticeMapper.getNoticeDetail", noticeNum);
    }

    // 조회수 증가
    public void increaseViewCount(int noticeNum) {
        sqlSession.update("NoticeMapper.increaseViewCount", noticeNum);
    }

    // 공지사항 검색
    public List<NoticeDTO> searchNotices(String keyword, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("NoticeMapper.searchNotices", params);
    }

    // 검색된 총 공지사항 수 조회
    public int getTotalNoticesByKeyword(String keyword) {
        return sqlSession.selectOne("NoticeMapper.getTotalNoticesByKeyword", keyword);
    }

    // 공지사항 생성
    public void createNotice(NoticeDTO notice) {
        sqlSession.insert("NoticeMapper.createNotice", notice);
    }

    // 공지사항 수정
    public void updateNotice(NoticeDTO notice) {
        sqlSession.update("NoticeMapper.updateNotice", notice);
    }

    // 공지사항 삭제
    public void deleteNotice(int noticeNum) {
        sqlSession.delete("NoticeMapper.deleteNotice", noticeNum);
    }
}
