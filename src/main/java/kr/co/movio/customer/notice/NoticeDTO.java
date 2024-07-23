package kr.co.movio.customer.notice;

import java.sql.Timestamp;

public class NoticeDTO {
    private int noticeNum;    // 공지사항 번호 (PK)
    private String title;     // 제목
    private String content;   // 내용
    private Timestamp regdate;     // 등록 날짜
    private Timestamp chdate;      // 수정 날짜
    private int viewCount;    // 조회수

    // Getters and Setters
    public int getNoticeNum() {
        return noticeNum;
    }

    public void setNoticeNum(int noticeNum) {
        this.noticeNum = noticeNum;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getRegdate() {
        return regdate;
    }

    public void setRegdate(Timestamp regdate) {
        this.regdate = regdate;
    }

    public Timestamp getChdate() {
        return chdate;
    }

    public void setChdate(Timestamp chdate) {
        this.chdate = chdate;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

	@Override
	public String toString() {
		return "AdminNoticeDTO [noticeNum=" + noticeNum + ", title=" + title + ", content=" + content + ", regdate="
				+ regdate + ", chdate=" + chdate + ", viewCount=" + viewCount + "]";
	}
}
