package kr.co.movio.theater;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

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
    
    //지역이름 가져오는 거
	public List<Map<String, Object>> getAllRegions(){
		return sqlSession.selectList("kr.co.movio.theater.TheaterDAO.getAllRegions");
	}//list end
	
	//지역에 맞는 극장 이름 가져오기
	public List<Map<String, Object>> getTheaters(String region_id){
		return sqlSession.selectList("kr.co.movio.theater.TheaterDAO.getTheaters", region_id);
		
	}//list end
	
	//각 지역별로 몇개의 지점이 있는지 카운팅하여 데이터를 가져옴
	public List<Map<String, Object>> RegionsTheaterCounts(){
		return sqlSession.selectList("kr.co.movio.theater.TheaterDAO.RegionsTheaterCounts");
	}//list end
	
	//특정 극장의 상영 날짜 조회 
	public List<Map<String, Object>> getDistinctDatesByTheater(String theater_id){
		return sqlSession.selectList("kr.co.movio.theater.TheaterDAO.getDistinctDatesByTheater", theater_id);
	}//list end
		
	//특정 날짜의 상영 영화 조회
	public List<Map<String, Object>> getMoviesByTheaterAndDate(Map<String, Object> params){
		return sqlSession.selectList("kr.co.movio.theater.TheaterDAO.getMoviesByTheaterAndDate", params);
	}//list end
}
