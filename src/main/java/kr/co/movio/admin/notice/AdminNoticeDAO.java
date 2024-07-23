package kr.co.movio.admin.notice;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class AdminNoticeDAO {
    private SqlSessionFactory sqlSessionFactory;

    public AdminNoticeDAO(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }

    // 공지사항 목록 조회
    public List<AdminNoticeDTO> getNotices(int offset, int limit) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            PaginationParams params = new PaginationParams(offset, limit);
            return session.selectList("kr.co.movio.admin.notice.AdminNoticeMapper.getNotices", params);
        }
    }

    // 총 공지사항 수 조회
    public int getTotalNotices() throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("kr.co.movio.admin.notice.AdminNoticeMapper.getTotalNotices");
        }
    }

    // 공지사항 생성
    public void createNotice(AdminNoticeDTO notice) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.insert("kr.co.movio.admin.notice.AdminNoticeMapper.createNotice", notice);
            session.commit();
        }
    }

    // 공지사항 수정
    public void updateNotice(AdminNoticeDTO notice) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.update("kr.co.movio.admin.notice.AdminNoticeMapper.updateNotice", notice);
            session.commit();
        }
    }

    // 공지사항 삭제
    public void deleteNotice(int noticeNum) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.delete("kr.co.movio.admin.notice.AdminNoticeMapper.deleteNotice", noticeNum);
            session.commit();
        }
    }

    // 공지사항 상세보기
    public AdminNoticeDTO getNoticeDetail(int noticeNum) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            return session.selectOne("kr.co.movio.admin.notice.AdminNoticeMapper.getNoticeDetail", noticeNum);
        }
    }

    // 조회수 증가
    public void increaseViewCount(int noticeNum) throws Exception {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            session.update("kr.co.movio.admin.notice.AdminNoticeMapper.increaseViewCount", noticeNum);
            session.commit();
        }
    }

    /**
     * 페이징 처리를 위한 내부 클래스
     * 
     * 이 클래스는 페이징 처리를 위해 필요한 offset과 limit 값을 포함합니다.
     * offset은 조회할 데이터의 시작 위치를 나타내고,
     * limit은 조회할 데이터의 최대 개수를 나타냅니다.
     */
    public static class PaginationParams {
        private int offset; // 조회할 데이터의 시작 위치
        private int limit;  // 조회할 데이터의 최대 개수

        // 생성자
        public PaginationParams(int offset, int limit) {
            this.offset = offset;
            this.limit = limit;
        }

        // Getters and Setters
        public int getOffset() {
            return offset;
        }

        public void setOffset(int offset) {
            this.offset = offset;
        }

        public int getLimit() {
            return limit;
        }

        public void setLimit(int limit) {
            this.limit = limit;
        }
    }
}
