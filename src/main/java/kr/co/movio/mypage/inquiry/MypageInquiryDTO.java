package kr.co.movio.mypage.inquiry;

public class MypageInquiryDTO {
    private String inq_num;
    private String mem_id;
    private String theater_id;
    private String inq_type;
    private String inq_title;
    private String inq_content;
    private String inq_date;

    // Getters and Setters
    public String getInq_num() {
        return inq_num;
    }

    public void setInq_num(String inq_num) {
        this.inq_num = inq_num;
    }

    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public String getTheater_id() {
        return theater_id;
    }

    public void setTheater_id(String theater_id) {
        this.theater_id = theater_id;
    }

    public String getInq_type() {
        return inq_type;
    }

    public void setInq_type(String inq_type) {
        this.inq_type = inq_type;
    }

    public String getInq_title() {
        return inq_title;
    }

    public void setInq_title(String inq_title) {
        this.inq_title = inq_title;
    }

    public String getInq_content() {
        return inq_content;
    }

    public void setInq_content(String inq_content) {
        this.inq_content = inq_content;
    }

    public String getInq_date() {
        return inq_date;
    }

    public void setInq_date(String inq_date) {
        this.inq_date = inq_date;
    }

    @Override
    public String toString() {
        return "MypageInquiryDTO [inq_num=" + inq_num + ", mem_id=" + mem_id + ", theater_id=" + theater_id + ", inq_type="
                + inq_type + ", inq_title=" + inq_title + ", inq_content=" + inq_content + ", inq_date=" + inq_date + "]";
    }
}
