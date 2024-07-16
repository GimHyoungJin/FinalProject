package kr.co.movio.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import jakarta.servlet.http.HttpSession;

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
    public ModelAndView orderInsert(
        @ModelAttribute OrderDTO orderDto,
        HttpSession session
    ) {
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
        System.out.println("OrderDTO: " + orderDto);

        try {
            orderService.placeOrder(orderDto, s_id);
            mav.addObject("msg1", "<img src='../images/logo/movio logo.png' width='50'>");
            mav.addObject("msg2", "<p> 주문이 완료되었습니다 </p>");
            mav.addObject("msg3", "<p><a href='/product/list'> [계속쇼핑하기] </a></p>");
        } catch (RuntimeException e) {
            mav.addObject("msg1", "<img src='../images/fail.png' width='50'>");
            mav.addObject("msg2", "<p>" + e.getMessage() + "</p>");
            mav.addObject("msg3", "<p><a href='/product/list'> [다시 시도하기] </a></p>");
            e.printStackTrace();  // 전체 스택 추적을 출력
        }

        System.out.println("mav: " + mav.getModel());

        return mav;
    }
}
