package kr.co.movio.order;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import kr.co.movio.cart.CartDTO;
import kr.co.movio.product.ProductDTO;
import kr.co.movio.product.ProductDAO;

@Service
@Transactional
public class OrderService {

    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private ProductDAO productDAO;
    
    @Autowired
    private SqlSession sqlSession;

    public String generateOrderNo() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateStr = sdf.format(new Date());
        int randomNum = new Random().nextInt(9000) + 1000;
        return dateStr + randomNum;
    }

    public void placeOrder(OrderDTO order, String memId) {
        try {
            // 장바구니 아이템 가져오기
            List<CartDTO> cartItems = orderDAO.getCartItems(memId);
            System.out.println(cartItems);
            for (CartDTO cartItem : cartItems) {
                String proDetailCode = cartItem.getPro_detail_code();
                int quantity = cartItem.getCart_amount();

                // 제품 정보 가져오기
                ProductDTO product = productDAO.detail(proDetailCode);
                if (product.getPro_stock() >= quantity) {
                    // 재고 업데이트
                	Map<String, Object> params = new HashMap<>();
                    params.put("proDetailCode", proDetailCode);
                    params.put("orderDetailAmount", quantity);
                    productDAO.updateProductStock(params);
                      
                    // 주문 상세 정보 삽입
                    Map<String, Object> params2 = new HashMap<>();
                    params2.put("order_no", order.getOrder_no());
                    params2.put("pro_detail_code", proDetailCode);
                    params2.put("order_detail_amount", quantity);
                    params2.put("order_detail_price", cartItem.getCart_price() * quantity);
                    orderDAO.orderdetailInsert(params2);
                } else {
                    throw new RuntimeException("재고가 부족합니다: " + product.getPro_name());
                }
            }

            // 장바구니 삭제
            orderDAO.cartDelete(memId);
            System.out.println("Cart deleted for member: " + memId);
        } catch (Exception e) {
            System.out.println("Error placing order: " + e.getMessage());
            throw e;
        }
    }

    public List<Map<String, Object>> orderDesc(String orderNo) {
        return orderDAO.orderDesc(orderNo);
    }

    public int totalamount(String memId) {
        return orderDAO.totalamount(memId);
    }

    public void insertPaymentInfo(Map<String, Object> paymentInfo) {
        System.out.println("Inserting payment info: " + paymentInfo);
        orderDAO.insertPaymentInfo(paymentInfo);
    }

    public void orderInsert(OrderDTO orderDto, String memId) {
        orderDAO.orderInsert(orderDto);placeOrder(orderDto, memId);
    }

    public int orderdetailInsert(Map<String, Object> map) {
        System.out.println("Inserting order detail: " + map);
        return orderDAO.orderdetailInsert(map);
    }

    public void cartDelete(String mem_id) {
        System.out.println("Deleting cart for member: " + mem_id);
        orderDAO.cartDelete(mem_id);
    }
    

    public void reduceProductStock(String proDetailCode, int orderDetailAmount) {
        Map<String, Object> params = new HashMap<>();
        params.put("proDetailCode", proDetailCode);
        params.put("orderDetailAmount", orderDetailAmount);

        // 로깅 추가	
        System.out.println("Executing SQL to reduce stock for product: " + proDetailCode + " by amount: " + orderDetailAmount);
        
        productDAO.updateProductStock(params);
    }
}
