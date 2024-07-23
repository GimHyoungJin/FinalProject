package kr.co.movio.customer.notice;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class NoticeDAO {
    private SqlSessionFactory sqlSessionFactory;

    public NoticeDAO(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }
    
    //공지사항 목록 조회
    public List<NoticeDTO> getNotices(int offset, int limit) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectList("kr.co.movio.notice.NoticeMapper.getNotices", new PaginationParams(offset, limit));
        }
    }
    //총 공지사항 수 조회
    public int getTotalNotices() throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("kr.co.movio.notice.NoticeMapper.getTotalNotices");
        }
    }
    // 공지사항 수정
    public void createNotice(NoticeDTO notice) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.insert("kr.co.movio.notice.NoticeMapper.createNotice", notice);
            session.commit();
        }
    }
    //공지사항 수정
    public void updateNotice(NoticeDTO notice) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.update("kr.co.movio.notice.NoticeMapper.updateNotice", notice);
            session.commit();
        }
    }
    //공지사항 삭제
    public void deleteNotice(int noticeNum) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.delete("kr.co.movio.notice.NoticeMapper.deleteNotice", noticeNum);
            session.commit();
        }
    }

    public static class PaginationParams {
        private int offset;
        private int limit;

        public PaginationParams(int offset, int limit) {
            this.offset = offset;
            this.limit = limit;
        }

        // Getters and Setters
    }
}
