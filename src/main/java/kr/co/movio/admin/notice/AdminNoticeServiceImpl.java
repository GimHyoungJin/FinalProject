package kr.co.movio.admin.notice;

import java.util.List;

public class AdminNoticeServiceImpl implements AdminNoticeService {
    private AdminNoticeDAO noticeDAO;

    public AdminNoticeServiceImpl(AdminNoticeDAO noticeDAO) {
        this.noticeDAO = noticeDAO;
    }

    @Override
    public List<AdminNoticeDTO> getNotices(int page, int size) {
        int offset = (page - 1) * size;
        try {
            return noticeDAO.getNotices(offset, size);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public int getTotalNotices() {
        try {
            return noticeDAO.getTotalNotices();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public void createNotice(AdminNoticeDTO notice) {
        try {
            noticeDAO.createNotice(notice);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateNotice(AdminNoticeDTO notice) {
        try {
            noticeDAO.updateNotice(notice);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteNotice(int noticeNum) {
        try {
            noticeDAO.deleteNotice(noticeNum);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public AdminNoticeDTO getNoticeDetail(int noticeNum) {
        try {
            noticeDAO.increaseViewCount(noticeNum);  // 조회수 증가
            return noticeDAO.getNoticeDetail(noticeNum);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void increaseViewCount(int noticeNum) {
        try {
            noticeDAO.increaseViewCount(noticeNum);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
