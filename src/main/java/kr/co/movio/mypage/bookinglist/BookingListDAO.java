package kr.co.movio.mypage.bookinglist;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BookingListDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<BookingListDTO> getBookingList(String memId) {
        return sqlSession.selectList("bookingList.getBookingList", memId);
    }

    public List<BookingListDTO> getBookingList(String memId, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("memId", memId);
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("bookingList.getBookingListWithPagination", params);
    }
    
    public List<BookingListDTO> getOrderList(String memId) {
        return sqlSession.selectList("bookingList.getOrderList", memId);
    }
}
