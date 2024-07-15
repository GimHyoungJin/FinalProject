package kr.co.movio.customer.notice;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeDTO {
    private int noticeNum;   // 공지사항 번호
    private String title;    // 제목
    private String content;  // 내용
    private String regdate;  // 작성일
    private String chdate;   // 수정일
    private String kinds;    // 조회수
}
