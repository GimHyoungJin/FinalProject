package kr.co.movio.mypage.profile;

import java.sql.Timestamp;

public class ProfileDTO {
    private String memId;
    private String username;
    private String passwd;
    private String phone;
    private Timestamp regdate;
    private String birth;
    private String gender;
    private String zipcode;
    private String address1;
    private String address2;
    private String smsAgree = "N"; // 기본 값 설정
    private String emailAgree = "N"; // 기본 값 설정
    private int memGrade;

    // Getters and Setters
    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Timestamp getRegdate() {
        return regdate;
    }

    public void setRegdate(Timestamp regdate) {
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

    public String getSmsAgree() {
        return smsAgree;
    }

    public void setSmsAgree(String smsAgree) {
        this.smsAgree = smsAgree;
    }

    public String getEmailAgree() {
        return emailAgree;
    }

    public void setEmailAgree(String emailAgree) {
        this.emailAgree = emailAgree;
    }

    public int getMemGrade() {
        return memGrade;
    }

    public void setMemGrade(int memGrade) {
        this.memGrade = memGrade;
    }

    @Override
    public String toString() {
        return "ProfileDTO [memId=" + memId + ", username=" + username + ", passwd=" + passwd 
                + ", phone=" + phone + ", regdate=" + regdate + ", birth=" + birth + ", gender=" + gender 
                + ", zipcode=" + zipcode + ", address1=" + address1 + ", address2=" + address2 
                + ", smsAgree=" + smsAgree + ", emailAgree=" + emailAgree + ", memGrade=" + memGrade + "]";
    }
}
