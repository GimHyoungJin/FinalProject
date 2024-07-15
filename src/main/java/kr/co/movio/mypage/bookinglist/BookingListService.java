package kr.co.movio.mypage.bookinglist;

import java.util.List;

public interface BookingListService {
    List<BookingListDTO> getBookingList(String memId);
}
