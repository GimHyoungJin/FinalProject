package kr.co.movio.customer.notice;

public class NoticeDTO {
    private int noticeNum;
    private String title;
    private String content;
    private String regdate;
    private String chdate;
    private String kinds;

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

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

    public String getChdate() {
        return chdate;
    }

    public void setChdate(String chdate) {
        this.chdate = chdate;
    }

    public String getKinds() {
        return kinds;
    }

    public void setKinds(String kinds) {
        this.kinds = kinds;
    }

    @Override
    public String toString() {
        return "NoticeDTO{" +
                "noticeNum=" + noticeNum +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", regdate='" + regdate + '\'' +
                ", chdate='" + chdate + '\'' +
                ", kinds='" + kinds + '\'' +
                '}';
    }
}
