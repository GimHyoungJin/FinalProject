package kr.co.movio.member;

public class MemberDTO {
    private String mem_id;
    private String username;
    private String passwd;
    private String email;
    private String phone;
    private String regdate;
    private String birth;
    private String gender;
    private String zipcode;
    private String address1;
    private String address2;
    private String sms_agree;
    private String email_agree;
    private int mem_grade; // 추가된 속성
    private int is_deleted; // 추가된 속성

    // Getters and Setters
    public String getMem_id() {
        return mem_id;
    }

    public void setMem_id(String mem_id) {
        this.mem_id = mem_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getSms_agree() {
        return sms_agree;
    }

    public void setSms_agree(String sms_agree) {
        this.sms_agree = sms_agree;
    }

    public String getEmail_agree() {
        return email_agree;
    }

    public void setEmail_agree(String email_agree) {
        this.email_agree = email_agree;
    }

    public int getMem_grade() {
        return mem_grade;
    }

    public void setMem_grade(int mem_grade) {
        this.mem_grade = mem_grade;
    }

    public int getIs_deleted() {
        return is_deleted;
    }

    public void setIs_deleted(int is_deleted) {
        this.is_deleted = is_deleted;
    }

    @Override
    public String toString() {
        return "MemberDTO [mem_id=" + mem_id + ", username=" + username + ", passwd=" + passwd + ", email=" + email
                + ", phone=" + phone + ", regdate=" + regdate + ", birth=" + birth + ", gender=" + gender + ", zipcode="
                + zipcode + ", address1=" + address1 + ", address2=" + address2 + ", sms_agree=" + sms_agree
                + ", email_agree=" + email_agree + ", mem_grade=" + mem_grade + ", is_deleted=" + is_deleted + "]";
    }
}
