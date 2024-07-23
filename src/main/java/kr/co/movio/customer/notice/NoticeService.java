package kr.co.movio.customer.notice;

import java.util.List;

public interface NoticeService {
    List<NoticeDTO> getNotices(int offset, int limit);
    NoticeDTO getNoticeById(int id);
    void incrementViewCount(int id);
    int countNotices();
    List<NoticeDTO> getRecentNotices();
}
