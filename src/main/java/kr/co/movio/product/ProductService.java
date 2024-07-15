package kr.co.movio.product;

import org.springframework.beans.factory.annotation.Autowired; // Spring의 의존성 주입을 위한 어노테이션을 가져옵니다.
import org.springframework.jdbc.core.JdbcTemplate; // Spring JDBC를 사용하기 위해 JdbcTemplate 클래스를 가져옵니다.
import org.springframework.stereotype.Service; // 이 클래스가 서비스 레이어임을 나타내기 위해 가져옵니다.

import java.util.List; // 리스트를 다루기 위해 가져옵니다.
import java.util.Map; // 키-값 쌍을 저장하기 위해 가져옵니다.

@Service // 이 클래스가 서비스 레이어임을 나타냅니다.
public class ProductService {

    @Autowired // Spring이 자동으로 JdbcTemplate 객체를 주입합니다.
    private JdbcTemplate jdbcTemplate;

    // 주어진 상품 코드를 기준으로 상품 목록을 조회하는 메서드
    public List<Product> getProductsByProCode(String proCode) {
        String sql = "SELECT * FROM product WHERE pro_code = ?"; // SQL 쿼리를 정의합니다.
        return jdbcTemplate.query(sql, new ProductRowMapper(), proCode); // 쿼리를 실행하고 결과를 Product 객체 목록으로 매핑하여 반환합니다.
    }
    
    // 주어진 맵 데이터를 사용하여 새로운 상품을 삽입하는 메서드
    public void insert(Map<String, Object> map) {
        String sql = "INSERT INTO product (pro_detail_code, pro_code, pro_name, pro_detail, pro_price, pro_photo, pro_stock) VALUES (?, ?, ?, ?, ?, ?, ?)"; // SQL 삽입 쿼리를 정의합니다.
        // JdbcTemplate을 사용하여 SQL 삽입 쿼리를 실행합니다. 맵에서 각 필드 값을 가져와서 쿼리의 매개변수로 사용합니다.
        jdbcTemplate.update(sql, 
            map.get("pro_detail_code"), // 맵에서 pro_detail_code 값을 가져와서 첫 번째 매개변수로 사용합니다.
            map.get("pro_code"),        // 맵에서 pro_code 값을 가져와서 두 번째 매개변수로 사용합니다.
            map.get("pro_name"),        // 맵에서 pro_name 값을 가져와서 세 번째 매개변수로 사용합니다.
            map.get("pro_detail"),      // 맵에서 pro_detail 값을 가져와서 네 번째 매개변수로 사용합니다.
            map.get("pro_price"),       // 맵에서 pro_price 값을 가져와서 다섯 번째 매개변수로 사용합니다.
            map.get("pro_photo"),       // 맵에서 pro_photo 값을 가져와서 여섯 번째 매개변수로 사용합니다.
            map.get("pro_stock")        // 맵에서 pro_stock 값을 가져와서 일곱 번째 매개변수로 사용합니다.
        );
    }
}
