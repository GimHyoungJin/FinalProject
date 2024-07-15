package kr.co.movio.customer.notice;

import java.util.List;

public interface NoticeService {
    List<NoticeDTO> getRecentNotices();
}
