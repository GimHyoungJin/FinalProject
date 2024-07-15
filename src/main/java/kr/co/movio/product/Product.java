package kr.co.movio.product;

import jakarta.persistence.Entity; // JPA를 사용하여 이 클래스가 엔티티임을 나타냅니다.
import jakarta.persistence.Id; // 이 필드가 기본 키임을 나타냅니다.
import jakarta.persistence.Table; // 이 클래스가 매핑될 데이터베이스 테이블의 이름을 지정합니다.

@Entity // 이 클래스가 JPA 엔티티임을 나타냅니다.
@Table(name = "product") // 이 엔티티가 "product" 테이블과 매핑됨을 나타냅니다.
public class Product {

    @Id // 이 필드가 테이블의 기본 키임을 나타냅니다.
    private String proDetailCode; // 상품 상세 코드
    private String proCode; // 상품 코드
    private String proName; // 상품 이름
    private String proDetail; // 상품 상세 설명
    private int proPrice; // 상품 가격
    private String proPhoto; // 상품 사진 URL
    private int proStock; // 상품 재고

    // 기본 생성자
    public Product() {
    }

    // 모든 필드를 포함한 생성자
    public Product(String proDetailCode, String proCode, String proName, String proDetail, int proPrice, String proPhoto, int proStock) {
        this.proDetailCode = proDetailCode; // 상품 상세 코드 초기화
        this.proCode = proCode; // 상품 코드 초기화
        this.proName = proName; // 상품 이름 초기화
        this.proDetail = proDetail; // 상품 상세 설명 초기화
        this.proPrice = proPrice; // 상품 가격 초기화
        this.proPhoto = proPhoto; // 상품 사진 URL 초기화
        this.proStock = proStock; // 상품 재고 초기화
    }

    // Getters and Setters

    public String getProDetailCode() {
        return proDetailCode; // 상품 상세 코드를 반환합니다.
    }

    public void setProDetailCode(String proDetailCode) {
        this.proDetailCode = proDetailCode; // 상품 상세 코드를 설정합니다.
    }

    public String getProCode() {
        return proCode; // 상품 코드를 반환합니다.
    }

    public void setProCode(String proCode) {
        this.proCode = proCode; // 상품 코드를 설정합니다.
    }

    public String getProName() {
        return proName; // 상품 이름을 반환합니다.
    }

    public void setProName(String proName) {
        this.proName = proName; // 상품 이름을 설정합니다.
    }

    public String getProDetail() {
        return proDetail; // 상품 상세 설명을 반환합니다.
    }

    public void setProDetail(String proDetail) {
        this.proDetail = proDetail; // 상품 상세 설명을 설정합니다.
    }

    public int getProPrice() {
        return proPrice; // 상품 가격을 반환합니다.
    }

    public void setProPrice(int proPrice) {
        this.proPrice = proPrice; // 상품 가격을 설정합니다.
    }

    public String getProPhoto() {
        return proPhoto; // 상품 사진 URL을 반환합니다.
    }

    public void setProPhoto(String proPhoto) {
        this.proPhoto = proPhoto; // 상품 사진 URL을 설정합니다.
    }

    public int getProStock() {
        return proStock; // 상품 재고를 반환합니다.
    }

    public void setProStock(int proStock) {
        this.proStock = proStock; // 상품 재고를 설정합니다.
    }
}
