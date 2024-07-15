package kr.co.movio.order;

import org.springframework.beans.factory.annotation.Autowired; // Spring의 의존성 주입을 위한 어노테이션을 가져옵니다.
import org.springframework.stereotype.Service; // 이 클래스가 서비스 레이어임을 나타냅니다.
import org.springframework.transaction.annotation.Transactional; // 트랜잭션 관리를 위해 가져옵니다.

import java.text.SimpleDateFormat; // 날짜 형식을 지정하기 위해 가져옵니다.
import java.util.Date; // 날짜를 다루기 위해 가져옵니다.
import java.util.HashMap; // 키-값 쌍을 저장하기 위해 가져옵니다.
import java.util.List; // 리스트를 다루기 위해 가져옵니다.
import java.util.Random; // 랜덤 숫자를 생성하기 위해 가져옵니다.

import kr.co.movio.product.Product; // Product 엔티티를 가져옵니다.
import kr.co.movio.product.ProductRepository; // ProductRepository를 가져옵니다.

@Service // 이 클래스가 서비스 레이어임을 나타냅니다.
public class OrderService {

    @Autowired // Spring이 자동으로 OrderDAO 객체를 주입합니다.
    private OrderDAO orderDAO;

    @Autowired // Spring이 자동으로 ProductRepository 객체를 주입합니다.
    private ProductRepository productRepository;
    
    // 주문 번호를 생성하는 메서드
    public String generateOrderNo() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); // 날짜 형식을 "yyyyMMddHHmmss"로 지정합니다.
        String dateStr = sdf.format(new Date()); // 현재 날짜와 시간을 문자열로 변환합니다.
        int randomNum = new Random().nextInt(9000) + 1000; // 1000부터 9999까지의 랜덤 숫자를 생성합니다.
        return dateStr + randomNum; // 날짜 문자열과 랜덤 숫자를 결합하여 주문 번호를 생성합니다.
    }

    @Transactional // 이 메서드가 트랜잭션 내에서 실행됨을 나타냅니다.
    public void placeOrder(OrderDTO order, String memId) {
        // 총 금액 계산
        int totalAmount = orderDAO.totalamount(memId); // 사용자 ID에 대한 총 주문 금액을 계산합니다.
        order.setOrder_total(totalAmount); // OrderDTO 객체에 총 금액을 설정합니다.

        // 주문 번호 생성
        String orderNo = generateOrderNo(); // 주문 번호를 생성합니다.
        order.setOrder_no(orderNo); // OrderDTO 객체에 주문 번호를 설정합니다.

        // 주문 삽입
        orderDAO.orderInsert(order); // OrderDTO 객체를 데이터베이스에 삽입합니다.

        // 주문 상세 삽입
        HashMap<String, String> params = new HashMap<>(); // 주문 상세 정보를 저장할 HashMap을 생성합니다.
        params.put("order_no", orderNo); // 주문 번호를 HashMap에 추가합니다.
        params.put("s_id", memId); // 사용자 ID를 HashMap에 추가합니다.
        orderDAO.orderdetailInsert(params); // 주문 상세 정보를 데이터베이스에 삽입합니다.

        // 재고 수량 감소 로직
        List<HashMap<String, Object>> orderDetails = orderDAO.orderDesc(orderNo); // 주문 번호에 대한 주문 상세 정보를 가져옵니다.
        for (HashMap<String, Object> detail : orderDetails) { // 각 주문 상세 정보를 순회합니다.
            String proDetailCode = (String) detail.get("pro_detail_code"); // 상품 상세 코드를 가져옵니다.
            Integer quantity = (Integer) detail.get("quantity"); // 주문 수량을 가져옵니다.
            
            if (proDetailCode == null || quantity == null) { // 상품 상세 코드나 주문 수량이 없는 경우
                throw new RuntimeException("Invalid order detail data: " + detail); // 예외를 발생시킵니다.
            }

            Product product = productRepository.findById(proDetailCode)
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다.")); // 상품 상세 코드로 상품을 찾습니다.
            if (product.getProStock() >= quantity) { // 상품의 재고가 주문 수량보다 많은 경우
                product.setProStock(product.getProStock() - quantity); // 상품의 재고를 주문 수량만큼 감소시킵니다.
                productRepository.save(product); // 상품 정보를 저장합니다.
            } else {
                throw new RuntimeException("재고가 부족합니다: " + product.getProName()); // 재고가 부족한 경우 예외를 발생시킵니다.
            }
        }
        
        // 장바구니 삭제
        orderDAO.cartDelete(memId); // 사용자의 장바구니를 삭제합니다.
    }

    // 주문 상세 정보를 가져오는 메서드
    public List<HashMap<String, Object>> orderDesc(String orderNo) {
        return orderDAO.orderDesc(orderNo); // 주문 번호에 대한 주문 상세 정보를 반환합니다.
    }

    // 사용자의 총 주문 금액을 계산하는 메서드
    public int totalamount(String memId) {
        return orderDAO.totalamount(memId); // 사용자 ID에 대한 총 주문 금액을 반환합니다.
    }
}
