package kr.co.movio.customer.notice;


public class NoticeDTO {
    private int noticeNum;   // 공지사항 번호
    private String title;    // 제목
    private String content;  // 내용
    private String regdate;  // 작성일
    private String chdate;   // 수정일
    private String kinds;    // 조회수
    
    public NoticeDTO() {
    	
    }

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
		return "NoticeDTO [noticeNum=" + noticeNum + ", title=" + title + ", content=" + content + ", regdate="
				+ regdate + ", chdate=" + chdate + ", kinds=" + kinds + "]";
	}
    
}
