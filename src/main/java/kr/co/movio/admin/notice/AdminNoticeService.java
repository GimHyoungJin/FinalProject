package kr.co.movio.admin.notice;

import java.util.List;

public interface AdminNoticeService {
    // 공지사항 목록 조회
    List<AdminNoticeDTO> getNotices(int page, int size);

    // 총 공지사항 수 조회
    int getTotalNotices();

    // 공지사항 생성
    void createNotice(AdminNoticeDTO notice);

    // 공지사항 수정
    void updateNotice(AdminNoticeDTO notice);

    // 공지사항 삭제
    void deleteNotice(int noticeNum);

    // 공지사항 상세보기
    AdminNoticeDTO getNoticeDetail(int noticeNum);

    // 조회수 증가
    void increaseViewCount(int noticeNum);
}
