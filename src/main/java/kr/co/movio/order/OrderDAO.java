package kr.co.movio.order;

import java.util.HashMap;
import java.util.List;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.core.RowMapper;

@Repository
public class OrderDAO {
    
    public OrderDAO() {
        System.out.println("-----OrderDAO()객체생성됨");
    }
    
    @Autowired
    SqlSession sqlSession;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public int totalamount(String s_id) {
        Integer result = sqlSession.selectOne("order.totalamount", s_id);
        return result != null ? result : 0;  
    }
    
    public void orderInsert(OrderDTO orderdto) {
        sqlSession.insert("order.orderInsert", orderdto);
    }
    
    public int orderdetailInsert(HashMap<String, String> map) {
        return sqlSession.insert("order.orderdetailInsert", map);
    }
    
    public int cartDelete(String s_id) {
        return sqlSession.delete("order.cartDelete", s_id);       
    }
    
    public List<HashMap<String, Object>> orderDesc(String orderNo) {
        String sql = "SELECT pro_detail_code, order_detail_amount AS quantity " +
                     "FROM orderdetail " +
                     "WHERE order_no = ?";
        return jdbcTemplate.query(sql, new Object[]{orderNo}, new RowMapper<HashMap<String, Object>>() {
            @Override
            public HashMap<String, Object> mapRow(ResultSet rs, int rowNum) throws SQLException {
                HashMap<String, Object> map = new HashMap<>();
                map.put("pro_detail_code", rs.getString("pro_detail_code"));
                map.put("quantity", rs.getInt("quantity"));
                return map;
            }
        });
    }
}
