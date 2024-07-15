package kr.co.movio.mypage.bookinglist;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BookingListDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<BookingListDTO> getBookingList(String memId) {
        return sqlSession.selectList("bookingList.getBookingList", memId);
    }
}
