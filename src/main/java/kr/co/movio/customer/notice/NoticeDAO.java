package kr.co.movio.customer.notice;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class NoticeDAO {

    @Autowired
    private SqlSession sqlSession;

    /**
     * 공지사항 목록을 페이징하여 가져옵니다.
     * 
     * @param offset 가져올 공지사항의 시작 위치
     * @param limit  가져올 공지사항의 개수
     * @return 공지사항 목록
     */
    public List<NoticeDTO> getNotices(int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("notice.getNotices", params);
    }

    /**
     * 특정 ID를 가진 공지사항을 가져옵니다.
     * 
     * @param id 공지사항 ID
     * @return 공지사항 객체
     */
    public NoticeDTO getNoticeById(int id) {
        return sqlSession.selectOne("notice.getNoticeById", id);
    }

    /**
     * 공지사항의 조회수를 증가시킵니다.
     * 
     * @param id 공지사항 ID
     * @return 업데이트된 행의 수
     */
    public int incrementViewCount(int id) {
        return sqlSession.update("notice.incrementViewCount", id);
    }

    /**
     * 전체 공지사항의 개수를 가져옵니다.
     * 
     * @return 전체 공지사항의 개수
     */
    public int countNotices() {
        return sqlSession.selectOne("notice.countNotices");
    }

    /**
     * 최신 공지사항 5개를 가져옵니다.
     * 
     * @return 최신 공지사항 목록
     */
    public List<NoticeDTO> getRecentNotices() {
        return sqlSession.selectList("notice.getRecentNotices");
    }
}
