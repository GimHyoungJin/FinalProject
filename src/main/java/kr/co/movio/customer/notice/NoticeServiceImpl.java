package kr.co.movio.customer.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeDAO noticeDAO;

    @Override
    public List<NoticeDTO> getRecentNotices() {
        return noticeDAO.getRecentNotices();
    }
}
