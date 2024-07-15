package kr.co.movio.order;

import java.util.HashMap;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAO {
    
    public OrderDAO() {
        System.out.println("-----OrderDAO() 객체 생성됨");
    }
    
    @Autowired
    private SqlSession sqlSession;
    
    public int totalamount(String memId) {
        return sqlSession.selectOne("kr.co.movio.order.OrderMapper.totalamount", memId);
    }
    
    public void orderInsert(OrderDTO orderdto) {
        sqlSession.insert("kr.co.movio.order.OrderMapper.orderInsert", orderdto);
    }
    
    public int orderdetailInsert(HashMap<String, String> map) {
        return sqlSession.insert("kr.co.movio.order.OrderMapper.orderdetailInsert", map);
    }
    
    public int cartDelete(String s_id) {
        return sqlSession.delete("kr.co.movio.order.OrderMapper.cartDelete", s_id);       
    }
    
    public List<HashMap<String, Object>> orderDesc(String orderNo) {
        return sqlSession.selectList("kr.co.movio.order.OrderMapper.orderDesc", orderNo);
    }
}