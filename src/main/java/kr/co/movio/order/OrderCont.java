package kr.co.movio.order;

import org.springframework.beans.factory.annotation.Autowired; // Spring의 의존성 주입을 위한 어노테이션을 가져옵니다.
import org.springframework.stereotype.Controller; // 이 클래스가 Spring MVC의 컨트롤러임을 나타냅니다.
import org.springframework.web.bind.annotation.GetMapping; // HTTP GET 요청을 매핑하기 위해 가져옵니다.
import org.springframework.web.bind.annotation.ModelAttribute; // 모델 속성을 바인딩하기 위해 가져옵니다.
import org.springframework.web.bind.annotation.PostMapping; // HTTP POST 요청을 매핑하기 위해 가져옵니다.
import org.springframework.web.bind.annotation.RequestMapping; // 요청 매핑을 위해 가져옵니다.
import org.springframework.web.servlet.ModelAndView; // 모델과 뷰를 함께 처리하기 위해 가져옵니다.
import jakarta.servlet.http.HttpSession; // HTTP 세션을 처리하기 위해 가져옵니다.

@Controller // 이 클래스가 Spring MVC의 컨트롤러임을 나타냅니다.
@RequestMapping("/order") // 이 컨트롤러의 모든 요청 매핑은 "/order"로 시작합니다.
public class OrderCont {

    // 기본 생성자
    public OrderCont() {
        System.out.println("-----OrderCont() 객체 생성됨");
    }

    @Autowired // Spring이 자동으로 OrderService 객체를 주입합니다.
    OrderService orderService;

    @GetMapping("/orderform") // HTTP GET 요청을 "/order/orderform"에 매핑합니다.
    public String orderForm() {
        return "/order/orderForm"; // "orderForm" JSP 페이지를 반환합니다.
    }

    @PostMapping("/insert") // HTTP POST 요청을 "/order/insert"에 매핑합니다.
    public ModelAndView orderInsert(
        @ModelAttribute OrderDTO orderDto, // 요청 파라미터를 OrderDTO 객체에 바인딩합니다.
        HttpSession session // 현재 HTTP 세션을 주입받습니다.
    ) {
        ModelAndView mav = new ModelAndView(); // ModelAndView 객체를 생성합니다.
        mav.setViewName("/order/msgView"); // 뷰 이름을 "msgView"로 설정합니다.

        String s_id = (String) session.getAttribute("mem_id"); // 세션에서 "mem_id" 값을 가져옵니다.
        if (s_id == null) { // 사용자가 로그인하지 않은 경우
            mav.addObject("msg1", "<img src='../images/fail.png' width='50'>"); // 실패 이미지를 추가합니다.
            mav.addObject("msg2", "<p> 세션이 만료되었습니다. 다시 로그인 해주세요. </p>"); // 오류 메시지를 추가합니다.
            mav.addObject("msg3", "<p><a href='/member/login'> [로그인 페이지로 이동] </a></p>"); // 로그인 페이지 링크를 추가합니다.
            return mav; // ModelAndView 객체를 반환합니다.
        }

        orderDto.setMem_id(s_id); // OrderDTO 객체에 사용자 ID를 설정합니다.

        try {
            orderService.placeOrder(orderDto, s_id); // 주문을 처리합니다.
            mav.addObject("msg1", "<img src='../images/logo/movio logo.png' width='50'>"); // 성공 이미지를 추가합니다.
            mav.addObject("msg2", "<p> 주문이 완료되었습니다 </p>"); // 성공 메시지를 추가합니다.
            mav.addObject("msg3", "<p><a href='/product/list'> [계속쇼핑하기] </a></p>"); // 계속 쇼핑하기 링크를 추가합니다.
        } catch (RuntimeException e) { // 주문 처리 중 오류가 발생한 경우
            mav.addObject("msg1", "<img src='../images/fail.png' width='50'>"); // 실패 이미지를 추가합니다.
            mav.addObject("msg2", "<p>" + e.getMessage() + "</p>"); // 오류 메시지를 추가합니다.
            mav.addObject("msg3", "<p><a href='/product/list'> [다시 시도하기] </a></p>"); // 다시 시도하기 링크를 추가합니다.
        }

        return mav; // ModelAndView 객체를 반환합니다.
    }

}
