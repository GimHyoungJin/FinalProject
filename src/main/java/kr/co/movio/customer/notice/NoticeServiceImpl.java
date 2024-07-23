package kr.co.movio.customer.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeDAO noticeDAO;

    @Override
    public List<NoticeDTO> getNotices(int offset, int limit) {
        return noticeDAO.getNotices(offset, limit);
    }

    @Override
    public NoticeDTO getNoticeById(int id) {
        return noticeDAO.getNoticeById(id);
    }

    @Override
    public void incrementViewCount(int id) {
        noticeDAO.incrementViewCount(id);
    }

    @Override
    public int countNotices() {
        return noticeDAO.countNotices();
    }

    @Override
    public List<NoticeDTO> getRecentNotices() {
        return noticeDAO.getRecentNotices();
    }
}
