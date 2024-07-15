package kr.co.movio.product;

import org.springframework.jdbc.core.RowMapper; // Spring JDBC의 RowMapper 인터페이스를 가져옵니다.

import java.sql.ResultSet; // SQL 쿼리 결과를 나타내기 위해 ResultSet을 가져옵니다.
import java.sql.SQLException; // SQL 예외를 처리하기 위해 SQLException을 가져옵니다.

// Product 엔티티를 매핑하기 위한 RowMapper 구현 클래스
public class ProductRowMapper implements RowMapper<Product> {

    @Override
    public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
        // ResultSet에서 데이터를 추출하여 Product 객체를 생성하고 반환합니다.
        return new Product(
            rs.getString("pro_detail_code"), // ResultSet에서 pro_detail_code 컬럼 값을 추출합니다.
            rs.getString("pro_code"),        // ResultSet에서 pro_code 컬럼 값을 추출합니다.
            rs.getString("pro_name"),        // ResultSet에서 pro_name 컬럼 값을 추출합니다.
            rs.getString("pro_detail"),      // ResultSet에서 pro_detail 컬럼 값을 추출합니다.
            rs.getInt("pro_price"),          // ResultSet에서 pro_price 컬럼 값을 추출합니다.
            rs.getString("pro_photo"),       // ResultSet에서 pro_photo 컬럼 값을 추출합니다.
            rs.getInt("pro_stock")           // ResultSet에서 pro_stock 컬럼 값을 추출합니다.
        );
    }
}
