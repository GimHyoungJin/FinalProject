package kr.co.movio.order;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.movio.member.MemberDAO;
import kr.co.movio.member.MemberDTO;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
@RequestMapping("/order")
public class OrderCont {

    private static final Logger logger = Logger.getLogger(OrderCont.class.getName());

    @Autowired
    OrderService orderService;

    @Autowired
    MemberDAO memberDao;

    @GetMapping("/orderform")
    public String orderForm(@RequestParam("totalPrice") int totalPrice, @RequestParam("proName") String proName, HttpServletRequest req, HttpSession session) {
        req.setAttribute("totalPrice", totalPrice);
        req.setAttribute("proName", proName);

        // member 테이블에서 상세정보 가져오기
        MemberDTO memberDto = memberDao.findById((String) session.getAttribute("mem_id"));
        req.setAttribute("useremail", memberDto.getEmail());
        req.setAttribute("username", memberDto.getUsername());

        return "/order/orderForm";
    }

    @PostMapping("/insert")
    @ResponseBody
    public String orderInsert(@RequestBody String inicis, HttpSession session) {
        JSONObject result = new JSONObject();
        logger.info("Received inicis data: " + inicis);

        String s_id = (String) session.getAttribute("mem_id");
        if (s_id == null) {
            result.put("data", "fail");
            return createErrorResponse("세션이 만료되었습니다. 다시 로그인 해주세요.");
        }

        try {
            JSONParser parser = new JSONParser();
            JSONObject jsonObject = (JSONObject) parser.parse(inicis);

            // 데이터 로그 추가
            logger.info("Parsed JSON data: " + jsonObject.toJSONString());

            // 결제 금액 검증
            Object paidAmountObj = jsonObject.get("paid_amount");
            if (paidAmountObj == null) {
                result.put("data", "fail");
                return createErrorResponse("결제 금액이 없습니다. 다시 확인해 주세요.");
            }
            int paidAmount = Integer.parseInt(paidAmountObj.toString());
            if (paidAmount <= 0) {
                result.put("data", "fail");
                return createErrorResponse("결제 금액이 0원입니다. 다시 확인해 주세요.");
            }

            // 주문서 번호 생성
            String orderno = orderService.generateOrderNo();

            // OrderDTO에 세션 아이디, 총 결제 금액, 주문서 번호 추가
            OrderDTO orderDto = new OrderDTO();
            orderDto.setMem_id(s_id);
            orderDto.setOrder_total(paidAmount);
            orderDto.setOrder_no(orderno);
            orderDto.setOrder_state("P"); // 주문 상태 설정 (예: P는 'Processing'을 의미)

            // 트랜잭션 시작
            try {
                orderService.orderInsert(orderDto);

                // 로그 추가
                logger.info("Inserting order with data: " + jsonObject);

                // 이니시스 결제 정보를 productpayment 테이블에 저장
                savePaymentInfo(jsonObject, orderno, s_id);

                // 상품 재고 수량 감소
                String proDetailCode = jsonObject.getOrDefault("pro_detail_code", "").toString();
                int orderDetailAmount = Integer.parseInt(jsonObject.getOrDefault("order_detail_amount", "0").toString());
                if (!proDetailCode.isEmpty() && orderDetailAmount > 0) {
                    // 로그 추가
                    System.out.println("Reducing stock for product: " + proDetailCode + " by amount: " + orderDetailAmount);
                    orderService.reduceProductStock(proDetailCode, orderDetailAmount);
                }

                orderService.cartDelete(s_id);
                String content = order_sendMail(orderDto);

                result.put("data", "success");
                return createSuccessResponse("주문이 완료되었습니다.", content);
            } catch (Exception e) {
                logger.log(Level.SEVERE, "주문 처리 중 오류 발생: " + e.getMessage(), e);
                return createErrorResponse("주문 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        } catch (ParseException e) {
            logger.log(Level.SEVERE, "결제 처리 중 오류 발생: " + e.getMessage(), e);
            return createErrorResponse("결제 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
        }
    }


    private String createErrorResponse(String message) {
        JSONObject response = new JSONObject();
        response.put("status", "error");
        response.put("message", message);
        return response.toJSONString();
    }

    private String createSuccessResponse(String message, String content) {
        JSONObject response = new JSONObject();
        response.put("status", "success");
        response.put("message", message);
        response.put("content", content);
        return response.toJSONString();
    }

    private void savePaymentInfo(JSONObject jsonObject, String orderno, String s_id) {
        Map<String, Object> map = new HashMap<>();
        map.put("gift_id", s_id);
        map.put("order_no", orderno);
        map.put("imp_uid", jsonObject.get("imp_uid"));
        map.put("mer_uid", jsonObject.get("mer_uid"));
        map.put("paid_amount", jsonObject.get("paid_amount"));
        map.put("apply_num", jsonObject.get("apply_num"));
        map.put("buyer_email", jsonObject.get("buyer_email"));
        map.put("buyer_name", jsonObject.get("buyer_name"));
        map.put("pay_method", jsonObject.get("pay_method"));

        String payStatus = jsonObject.getOrDefault("pay_status", "").toString();
        if (payStatus.length() > 255) { // assuming the column length is 255
            payStatus = payStatus.substring(0, 255);
        }
        map.put("pay_status", payStatus);

        map.put("card_information", jsonObject.get("card_information"));

        // 필수 필드 검증
        for (String key : new String[]{"imp_uid", "mer_uid", "paid_amount", "buyer_email", "buyer_name", "pay_method", "pay_status"}) {
            if (map.get(key) == null) {
                logger.severe("필수 결제 정보 누락: " + key);
                throw new RuntimeException("필수 결제 정보가 누락되었습니다: " + key);
            }
        }

        // DB에 행 추가
        orderService.insertPaymentInfo(map);
    }

    private String order_sendMail(OrderDTO orderDto) {
        // 이메일 전송 로직 구현
        return "주문 내역서";
    }

	@GetMapping("/msgView")
	public ModelAndView msgView(@RequestParam("flag") String flag) {
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("/order/msgView");
	    if (flag.equals("fail")) {
	        mav.addObject("msg1", "<img src='../images/logo/movio logo.png' width='50'>");
	        mav.addObject("msg2", "<p> 결제 처리 중 오류가 발생했습니다. 다시 시도해주세요. </p>");
	        mav.addObject("msg3", "<p><a href='#' onclick='showLoginModal()'> [로그인 페이지로 이동] </a></p>");
	        
	    } else if (flag.equals("success")) {
	        mav.addObject("msg1", "<img src='../images/logo/movio logo.png' width='50'>");
	        mav.addObject("msg2", "<p> 주문이 완료되었습니다 </p>");
	        mav.addObject("msg3", "<p><a href='/product/list'> [계속쇼핑하기] </a></p>");
	    }//if end
	    return mav;
	}//end


@GetMapping("/checkLogin")
@ResponseBody
public boolean checkLogin(HttpSession session) {
    String s_id = (String) session.getAttribute("mem_id");
    return s_id != null;
}
}
