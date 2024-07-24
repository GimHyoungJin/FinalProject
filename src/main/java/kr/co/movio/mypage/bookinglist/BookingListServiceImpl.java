package kr.co.movio.mypage.bookinglist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BookingListServiceImpl implements BookingListService {

    @Autowired
    private BookingListDAO bookingListDAO;

    public List<BookingListDTO> getBookingList(String memId) {
        return bookingListDAO.getBookingList(memId);
    }

    public List<BookingListDTO> getBookingList(String memId, int offset, int limit) {
        return bookingListDAO.getBookingList(memId, offset, limit);
    }

    public List<BookingListDTO> getOrderList(String memId) {
        return bookingListDAO.getOrderList(memId);
    }
}