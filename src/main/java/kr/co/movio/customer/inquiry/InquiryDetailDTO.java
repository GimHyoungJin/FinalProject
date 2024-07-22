package kr.co.movio.customer.inquiry;

public class InquiryDetailDTO {
    private String inqde_num;
    private String inq_num;
    private String inqde_content;
    private String inqde_date;

    // 기본 생성자
    public InquiryDetailDTO() {}

    // Getters and Setters
    public String getInqde_num() {
        return inqde_num;
    }

    public void setInqde_num(String inqde_num) {
        this.inqde_num = inqde_num;
    }

    public String getInq_num() {
        return inq_num;
    }

    public void setInq_num(String inq_num) {
        this.inq_num = inq_num;
    }

    public String getInqde_content() {
        return inqde_content;
    }

    public void setInqde_content(String inqde_content) {
        this.inqde_content = inqde_content;
    }

    public String getInqde_date() {
        return inqde_date;
    }

    public void setInqde_date(String inqde_date) {
        this.inqde_date = inqde_date;
    }

    @Override
    public String toString() {
        return "InquiryDetailDTO [inqde_num=" + inqde_num + ", inq_num=" + inq_num + ", inqde_content=" + inqde_content
                + ", inqde_date=" + inqde_date + "]";
    }
}
