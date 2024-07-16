package kr.co.movio.theater;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository // 이 클래스가 Spring의 Repository로 인식되도록 표시
public class TheaterDAO {

    @Autowired // Spring이 자동으로 SqlSession을 주입하도록 설정
    private SqlSession sqlSession;

    // 모든 극장 정보를 가져오는 메서드
    public List<TheaterDTO> getAllTheaters() {
        return sqlSession.selectList("kr.co.movio.theater.TheaterDAO.getAllTheaters");
    }

    // 극장 ID를 통해 특정 극장 정보를 가져오는 메서드
    public TheaterDTO getTheaterById(String theater_id) {
        return sqlSession.selectOne("kr.co.movio.theater.TheaterDAO.getTheaterById", theater_id);
    }

    // 극장 ID를 통해 특정 극장의 상세 정보를 가져오는 메서드
    public List<TheaterInfoDTO> getTheaterInfoByTheaterId(String theater_id) {
        return sqlSession.selectList("kr.co.movio.theater.TheaterDAO.getTheaterInfoByTheaterId", theater_id);
    }
}
