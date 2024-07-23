package kr.co.movio.mypage.bookinglist;

import java.util.List;

public interface BookingListService {
    List<BookingListDTO> getBookingList(String memId);
    List<BookingListDTO> getBookingList(String memId, int offset, int limit); // 추가된 메서드
}
