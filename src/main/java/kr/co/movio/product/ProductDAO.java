package kr.co.movio.product;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> list() {
        String sql = "SELECT * FROM product";
        return jdbcTemplate.queryForList(sql);
    }

    public List<Map<String, Object>> search(String productName) {
        String sql = "SELECT * FROM product WHERE pro_name LIKE ?";
        return jdbcTemplate.queryForList(sql, "%" + productName + "%");
    }

    public Map<String, Object> detail(String proDetailCode) {
        String sql = "SELECT * FROM product WHERE pro_detail_code = ?";
        return jdbcTemplate.queryForMap(sql, proDetailCode);
    }

    public boolean update(Map<String, Object> params) {
        String sql = "UPDATE product SET pro_name = ?, pro_detail = ?, pro_price = ?, pro_photo = ?, pro_stock = ? WHERE pro_detail_code = ?";
        int result = jdbcTemplate.update(sql, params.get("pro_name"), params.get("pro_detail"), params.get("pro_price"), params.get("pro_photo"), params.get("pro_stock"), params.get("pro_detail_code"));
        return result > 0;
    }

    public boolean delete(String proDetailCode) {
        String sql = "DELETE FROM product WHERE pro_detail_code = ?";
        int result = jdbcTemplate.update(sql, proDetailCode);
        return result > 0;
    }

    public String getCategoryNameByProCode(String proCode) {
        String sql = "SELECT category_name FROM category WHERE pro_code = ?";
        return jdbcTemplate.queryForObject(sql, new Object[] { proCode }, String.class);
    }

    public int getMaxProDetailCode(String proCode) {
        String sql = "SELECT MAX(CAST(SUBSTRING(pro_detail_code, LENGTH(?) + 1) AS UNSIGNED)) FROM product WHERE pro_code = ?";
        Integer maxCode = jdbcTemplate.queryForObject(sql, new Object[] { proCode, proCode }, Integer.class);
        return (maxCode != null) ? maxCode : 0;
    }
}
