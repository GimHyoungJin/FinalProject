package kr.co.movio.order;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.co.movio.cart.CartDTO;

@Repository
public class OrderDAO {

    @Autowired
    private SqlSession sqlSession;

    public int totalamount(String memId) {
        Integer result = sqlSession.selectOne("kr.co.movio.order.OrderMapper.totalamount", memId);
        return result != null ? result : 0;
    }

    public void orderInsert(OrderDTO orderDto) {
        System.out.println("Inserting order: " + orderDto);
        sqlSession.insert("kr.co.movio.order.OrderMapper.orderInsert", orderDto);
    }

    public int orderdetailInsert(Map<String, Object> map) {
        System.out.println("Inserting order detail: " + map);
        return sqlSession.insert("kr.co.movio.order.OrderMapper.orderdetailInsert", map);
    }

    public void cartDelete(String memId) {
        System.out.println("Deleting cart for member: " + memId);
        sqlSession.delete("kr.co.movio.order.OrderMapper.cartDelete", memId);
    }

    public List<Map<String, Object>> orderDesc(String orderNo) {
        return sqlSession.selectList("kr.co.movio.order.OrderMapper.orderDesc", orderNo);
    }

    public List<CartDTO> getCartItems(String memId) {
        return sqlSession.selectList("kr.co.movio.order.OrderMapper.getCartItems", memId);
    }

    public void insertPaymentInfo(Map<String, Object> map) {
        System.out.println("Inserting payment info: " + map);
        sqlSession.insert("kr.co.movio.order.OrderMapper.insertPaymentInfo", map);
    }
    


}
