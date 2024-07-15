package kr.co.movio.mypage.vouchers;

public class VouchersDTO {
    private String voucherNumber;
    private String memId;
    private String expirationDate;
    private boolean used;

    // 기본 생성자
    public VouchersDTO() {
    }

    // 필요한 생성자 추가
    public VouchersDTO(String voucherNumber, String memId) {
        this.voucherNumber = voucherNumber;
        this.memId = memId;
    }

    // getters and setters
    public String getVoucherNumber() {
        return voucherNumber;
    }

    public void setVoucherNumber(String voucherNumber) {
        this.voucherNumber = voucherNumber;
    }

    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    public String getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate;
    }

    public boolean isUsed() {
        return used;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }

    @Override
    public String toString() {
        return "VouchersDTO [voucherNumber=" + voucherNumber + ", memId=" + memId + ", expirationDate=" + expirationDate
                + ", used=" + used + "]";
    }
}
