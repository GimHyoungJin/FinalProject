package kr.co.movio.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@Controller
@RequestMapping("/order")
public class OrderCont {

    public OrderCont() {
        System.out.println("-----OrderCont() 객체 생성됨");
    }

    @Autowired
    OrderService orderService;

    @GetMapping("/orderform")
    public String orderForm() {
        return "/order/orderForm";
    }

    @PostMapping("/insert")
    public ModelAndView orderInsert(@ModelAttribute OrderDTO orderDto, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/order/msgView");

        String s_id = (String) session.getAttribute("mem_id");
        if (s_id == null) {
            mav.addObject("msg1", "<img src='../images/fail.png' width='50'>");
            mav.addObject("msg2", "<p> 세션이 만료되었습니다. 다시 로그인 해주세요. </p>");
            mav.addObject("msg3", "<p><a href='/member/login'> [로그인 페이지로 이동] </a></p>");
            return mav;
        }

        orderDto.setMem_id(s_id);
        System.out.println("OrderDTO: " + orderDto);  // OrderDTO 디버그 출력

        if (orderDto.getOrder_total() <= 0) {
            mav.addObject("msg1", "<img src='../images/fail.png' width='50'>");
            mav.addObject("msg2", "<p> 결제 금액이 0원입니다. 다시 확인해 주세요. </p>");
            mav.addObject("msg3", "<p><a href='/product/list'> [다시 시도하기] </a></p>");
            return mav;
        }

        try {
            // JSON 데이터 생성
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonOrderDetails = objectMapper.writeValueAsString(orderDto.getOrderDetails());
            String jsonInputString = "{\"totalAmount\": \"" + orderDto.getOrder_total() + "\", \"orderDetails\": " + jsonOrderDetails + "}";

            // 결제 API 호출 예제
            URL url = new URL("https://payment.api/endpoint");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; utf-8");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);

            // JSON 형태로 데이터 전송
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 응답 처리
            int code = conn.getResponseCode();
            if (code == HttpURLConnection.HTTP_OK) {
                orderService.placeOrder(orderDto, s_id);
                mav.addObject("msg1", "<img src='../images/logo/movio logo.png' width='50'>");
                mav.addObject("msg2", "<p> 주문이 완료되었습니다 </p>");
                mav.addObject("msg3", "<p><a href='/product/list'> [계속쇼핑하기] </a></p>");
            } else {
                mav.addObject("msg1", "<img src='../images/fail.png' width='50'>");
                mav.addObject("msg2", "<p>결제 처리 중 오류가 발생했습니다. 다시 시도해주세요.</p>");
                mav.addObject("msg3", "<p><a href='/product/list'> [다시 시도하기] </a></p>");
            }
        } catch (Exception e) {
            mav.addObject("msg1", "<img src='../images/fail.png' width='50'>");
            mav.addObject("msg2", "<p>결제 처리 중 오류가 발생했습니다. 다시 시도해주세요.</p>");
            mav.addObject("msg3", "<p><a href='/product/list'> [다시 시도하기] </a></p>");
            e.printStackTrace();
        }

        System.out.println("mav: " + mav.getModel());

        return mav;
    }

    @GetMapping("/checkLogin")
    @ResponseBody
    public boolean checkLogin(HttpSession session) {
        String s_id = (String) session.getAttribute("mem_id");
        return s_id != null;
    }
}
