package kr.co.movio.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import kr.co.movio.product.ProductDTO;
import kr.co.movio.product.ProductDAO;

@Service
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

    @Transactional
    public void placeOrder(OrderDTO order, String memId) {
        // 총 금액 계산
        int totalAmount = orderDAO.totalamount(memId);
        order.setOrder_total(totalAmount);

        // 주문 번호 생성
        String orderNo = generateOrderNo();
        order.setOrder_no(orderNo);

        // 주문 삽입
        orderDAO.orderInsert(order);

        // 주문 상세 삽입
        HashMap<String, String> params = new HashMap<>();
        params.put("order_no", orderNo);
        params.put("s_id", memId);
        orderDAO.orderdetailInsert(params);

        // 재고 수량 감소 로직
        List<HashMap<String, Object>> orderDetails = orderDAO.orderDesc(orderNo);
        for (HashMap<String, Object> detail : orderDetails) {
            String proDetailCode = (String) detail.get("pro_detail_code");
            Integer quantity = (Integer) detail.get("quantity");

            if (proDetailCode == null || quantity == null) {
                throw new RuntimeException("Invalid order detail data: " + detail);
            }

            ProductDTO product = productDAO.detail(proDetailCode);
            if (product.getPro_stock() >= quantity) {
                product.setPro_stock(product.getPro_stock() - quantity);
                productDAO.updateProductStock(product);
            } else {
                throw new RuntimeException("재고가 부족합니다: " + product.getPro_name());
            }
        }

        // 장바구니 삭제
        orderDAO.cartDelete(memId);
    }

    public List<HashMap<String, Object>> orderDesc(String orderNo) {
        return orderDAO.orderDesc(orderNo);
    }

    public int totalamount(String memId) {
        return orderDAO.totalamount(memId);
    }
}
