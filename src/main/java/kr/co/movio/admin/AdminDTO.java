package kr.co.movio.admin;

public class AdminDTO {
    private int id;
    private String name;
    private String email;
    private String joinDate;
    private String status;
    private String phone;
    private String birth;
    private String gender;
    private String address;
    private boolean smsOptIn;
    private boolean emailOptIn;
    private int grade;
    private String password; // 추가된 속성

    // 생성자
    public AdminDTO(int id, String name, String email, String joinDate, String status, String phone, String birth, String gender, String address, boolean smsOptIn, boolean emailOptIn, int grade, String password) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.joinDate = joinDate;
        this.status = status;
        this.phone = phone;
        this.birth = birth;
        this.gender = gender;
        this.address = address;
        this.smsOptIn = smsOptIn;
        this.emailOptIn = emailOptIn;
        this.grade = grade;
        this.password = password;
    }

    // Getter와 Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isSmsOptIn() {
        return smsOptIn;
    }

    public void setSmsOptIn(boolean smsOptIn) {
        this.smsOptIn = smsOptIn;
    }

    public boolean isEmailOptIn() {
        return emailOptIn;
    }

    public void setEmailOptIn(boolean emailOptIn) {
        this.emailOptIn = emailOptIn;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
