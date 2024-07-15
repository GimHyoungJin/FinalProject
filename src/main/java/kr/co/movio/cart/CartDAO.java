package kr.co.movio.cart;

import java.util.HashMap;
import java.util.List;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.session.SqlSession;

@Repository
public class CartDAO {

    public CartDAO() {
        System.out.println("-----CartDAO() 객체 생성됨");
    }

    @Autowired
    SqlSession sqlSession;
    
    public void insert(CartDTO dto) {
        sqlSession.insert("cart.insert", dto);
    }

    public List<CartDTO> list(String s_id) {
        return sqlSession.selectList("cart.list", s_id);
    }

    public void delete(HashMap<String, Object> map) {
        sqlSession.delete("cart.delete", map);
    }

    public int getTotalPrice(String mem_id) {
        Integer totalPrice = sqlSession.selectOne("cart.totalPrice", mem_id);
        return totalPrice != null ? totalPrice : 0;
    }
}