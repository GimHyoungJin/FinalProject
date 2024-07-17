package kr.co.movio.product;

public class ProductDTO {
    
    private String pro_detail_code;
    private String pro_code;
    private String pro_name;
    private String pro_detail;
    private int pro_price;
    private int original_price; // 원래 가격 필드 추가
    private String pro_photo;   // 파일 이름 필드
    private long filesize;
    private String category;    // 카테고리 필드 추가
    private int pro_stock;      // 재고 수량 필드 추가

    // 기본 생성자
    public ProductDTO() {
    }

    // Getter 및 Setter 메서드
    public String getPro_detail_code() {
        return pro_detail_code;
    }

    public void setPro_detail_code(String pro_detail_code) {
        this.pro_detail_code = pro_detail_code;
    }

    public String getPro_code() {
        return pro_code;
    }

    public void setPro_code(String pro_code) {
        this.pro_code = pro_code;
    }

    public String getPro_name() {
        return pro_name;
    }

    public void setPro_name(String pro_name) {
        this.pro_name = pro_name;
    }

    public String getPro_detail() {
        return pro_detail;
    }

    public void setPro_detail(String pro_detail) {
        this.pro_detail = pro_detail;
    }

    public int getPro_price() {
        return pro_price;
    }

    public void setPro_price(int pro_price) {
        this.pro_price = pro_price;
    }

    public int getOriginal_price() {
        return original_price;
    }

    public void setOriginal_price(int original_price) {
        this.original_price = original_price;
    }

    public String getPro_photo() {
        return pro_photo;
    }

    public void setPro_photo(String pro_photo) {
        this.pro_photo = pro_photo;
    }

    public long getFilesize() {
        return filesize;
    }

    public void setFilesize(long filesize) {
        this.filesize = filesize;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getPro_stock() {
        return pro_stock;
    }
    
    public void setPro_stock(int pro_stock) {
        this.pro_stock = pro_stock;
    }

    @Override
    public String toString() {
        return "ProductDTO{" +
                "pro_detail_code='" + pro_detail_code + '\'' +
                ", pro_code='" + pro_code + '\'' +
                ", pro_name='" + pro_name + '\'' +
                ", pro_detail='" + pro_detail + '\'' +
                ", pro_price=" + pro_price +
                ", original_price=" + original_price +
                ", pro_photo='" + pro_photo + '\'' +
                ", filesize=" + filesize +
                ", category='" + category + '\'' +
                ", pro_stock=" + pro_stock +
                '}';
    }
}
