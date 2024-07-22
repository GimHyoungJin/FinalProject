package kr.co.movio.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import kr.co.movio.cart.CartDTO;
import kr.co.movio.product.ProductDTO;
import kr.co.movio.product.ProductDAO;

@Service
@Transactional // 클래스 레벨에 @Transactional 어노테이션 추가
public class OrderService {

    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private ProductDAO productDAO;

    public String generateOrderNo() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateStr = sdf.format(new Date());
        int randomNum = new Random().nextInt(9000) + 1000;
        return dateStr + randomNum;
    }

    public void placeOrder(OrderDTO order, String memId) {
        try {
            // 총 금액 계산
            int totalAmount = orderDAO.totalamount(memId);
            order.setOrder_total(totalAmount);

            // 주문 번호 생성
            String orderNo = generateOrderNo();
            order.setOrder_no(orderNo);

            // 주문 상태 설정
            order.setOrder_state("P"); // 예: P는 'Processing'을 의미

            System.out.println("Placing order: " + order); // 추가 로그

            // 주문 삽입
            orderDAO.orderInsert(order);
            System.out.println("Order inserted: " + order); // 추가 로그

            // 주문 상세 삽입
            List<CartDTO> cartItems = orderDAO.getCartItems(memId);
            for (CartDTO cartItem : cartItems) {
                String proDetailCode = cartItem.getPro_detail_code();
                int quantity = cartItem.getCart_amount();

                ProductDTO product = productDAO.detail(proDetailCode);
                System.out.println("Product before update: " + product); // 추가 로그

                if (product.getPro_stock() >= quantity) {
                    product.setPro_stock(product.getPro_stock() - quantity);
                    System.out.println("Updating product stock: " + product); // 추가 로그
                    productDAO.updateProductStock(product);
                    System.out.println("Product after update: " + product); // 추가 로그

                    // 주문 상세 정보 삽입
                    HashMap<String, Object> params = new HashMap<>();
                    params.put("order_no", orderNo);
                    params.put("pro_detail_code", proDetailCode);
                    params.put("order_detail_amount", quantity);
                    params.put("order_detail_price", cartItem.getCart_price() * quantity); // 장바구니 가격 * 수량
                    orderDAO.orderdetailInsert(params);
                    System.out.println("Order detail inserted: " + params); // 추가 로그
                } else {
                    throw new RuntimeException("재고가 부족합니다: " + product.getPro_name());
                }
            }

            // 장바구니 삭제
            orderDAO.cartDelete(memId);
            System.out.println("Cart deleted for member: " + memId); // 추가 로그
        } catch (Exception e) {
            System.out.println("Error placing order: " + e.getMessage());
            throw e; // 예외를 다시 던져서 호출한 곳에서 잡을 수 있도록 합니다.
        }
    }

    public List<HashMap<String, Object>> orderDesc(String orderNo) {
        return orderDAO.orderDesc(orderNo);
    }

    public int totalamount(String memId) {
        return orderDAO.totalamount(memId);
    }
}
