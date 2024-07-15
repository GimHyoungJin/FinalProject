package kr.co.movio.product;

public class Product {
    private String proDetailCode;
    private String proCode;
    private String proName;
    private String proDetail;
    private int proPrice;
    private String proPhoto;
    private int proStock;

    // 기본 생성자
    public Product() {}

    // 모든 필드를 포함한 생성자
    public Product(String proDetailCode, String proCode, String proName, String proDetail, int proPrice, String proPhoto, int proStock) {
        this.proDetailCode = proDetailCode;
        this.proCode = proCode;
        this.proName = proName;
        this.proDetail = proDetail;
        this.proPrice = proPrice;
        this.proPhoto = proPhoto;
        this.proStock = proStock;
    }

    // Getters and Setters
    public String getProDetailCode() {
        return proDetailCode;
    }

    public void setProDetailCode(String proDetailCode) {
        this.proDetailCode = proDetailCode;
    }

    public String getProCode() {
        return proCode;
    }

    public void setProCode(String proCode) {
        this.proCode = proCode;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getProDetail() {
        return proDetail;
    }

    public void setProDetail(String proDetail) {
        this.proDetail = proDetail;
    }

    public int getProPrice() {
        return proPrice;
    }

    public void setProPrice(int proPrice) {
        this.proPrice = proPrice;
    }

    public String getProPhoto() {
        return proPhoto;
    }

    public void setProPhoto(String proPhoto) {
        this.proPhoto = proPhoto;
    }

}
