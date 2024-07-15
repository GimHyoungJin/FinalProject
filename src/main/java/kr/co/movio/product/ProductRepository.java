package kr.co.movio.product;

import org.springframework.data.jpa.repository.JpaRepository; // Spring Data JPA의 JpaRepository를 가져옵니다.

public interface ProductRepository extends JpaRepository<Product, String> {
    // Product 엔티티와 관련된 데이터베이스 작업을 처리하기 위해 JpaRepository를 확장합니다.
    // JpaRepository<Product, String>은 Product 엔티티와 그 기본 키 타입이 String임을 나타냅니다.
    // 이 인터페이스는 기본적인 CRUD 작업(create, read, update, delete)을 위한 메서드를 제공합니다.
}
