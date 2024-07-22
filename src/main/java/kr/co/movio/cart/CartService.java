package kr.co.movio.cart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    @Autowired
    private CartDAO cartDAO;

    public List<CartDTO> getCartItemsByMemberId(String mem_id) {
        return cartDAO.list(mem_id);
    }
}
