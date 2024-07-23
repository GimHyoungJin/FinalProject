package kr.co.movio.admin.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService {

    @Autowired
    private AdminNoticeDAO noticeDAO;

    @Override
    // 공지사항 목록 조회
    public List<AdminNoticeDTO> getNotices(int page, int size) {
        int offset = (page - 1) * size;
        return noticeDAO.getNotices(offset, size);
    }

    @Override
    // 총 공지사항 수 조회
    public int getTotalNotices() {
        return noticeDAO.getTotalNotices();
    }

    @Override
    // 공지사항 생성
    public void createNotice(AdminNoticeDTO notice) {
        noticeDAO.createNotice(notice);
    }

    @Override
    // 공지사항 수정
    public void updateNotice(AdminNoticeDTO notice) {
        noticeDAO.updateNotice(notice);
    }

    @Override
    // 공지사항 삭제
    public void deleteNotice(int noticeNum) {
        noticeDAO.deleteNotice(noticeNum);
    }

    @Override
    // 공지사항 상세보기
    public AdminNoticeDTO getNoticeDetail(int noticeNum) {
        return noticeDAO.getNoticeDetail(noticeNum);
    }

    @Override
    // 조회수 증가
    public void increaseViewCount(int noticeNum) {
        noticeDAO.increaseViewCount(noticeNum);
    }
}
