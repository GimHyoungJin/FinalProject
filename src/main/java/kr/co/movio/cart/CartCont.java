package kr.co.movio.cart;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller // 이 클래스가 Spring MVC의 컨트롤러임을 나타냅니다.
@RequestMapping("/cart") // 이 컨트롤러의 모든 요청 매핑은 "/cart"로 시작합니다.
public class CartCont {

    // 기본 생성자
    public CartCont() {
        System.out.println("-----CartCont() 객체 생성됨");
    }

    @Autowired // Spring이 자동으로 의존성을 주입합니다.
    private CartDAO cartDao; // CartDAO 객체를 주입받습니다.

    @PostMapping("/insert") // HTTP POST 요청을 "/cart/insert"에 매핑합니다.
    public String cartInsert(
        @RequestParam("pro_detail_code") String pro_detail_code, // 요청 파라미터에서 "pro_detail_code"를 받습니다.
        @RequestParam("cart_price") int cart_price, // 요청 파라미터에서 "cart_price"를 받습니다.
        @RequestParam("cart_amount") int cart_amount, // 요청 파라미터에서 "cart_amount"를 받습니다.
        HttpSession session, // 현재 HTTP 세션을 주입받습니다.
        RedirectAttributes redirectAttributes // 리다이렉트 시에 사용할 속성을 주입받습니다.
    ) {
        // 세션에서 "mem_id" 값을 가져옵니다.
        String mem_id = (String) session.getAttribute("mem_id");

        // 사용자가 로그인하지 않은 경우
        if (mem_id == null) {
            // 리다이렉트 시 메시지를 추가합니다.
            redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
            // 로그인 페이지로 리다이렉트합니다.
            return "redirect:/login";
        }

        // CartDTO 객체를 생성하고 데이터를 설정합니다.
        CartDTO cartDTO = new CartDTO();
        cartDTO.setMem_id(mem_id); // 사용자 ID를 설정합니다.
        cartDTO.setPro_detail_code(pro_detail_code); // 상품 상세 코드를 설정합니다.
        cartDTO.setCart_price(cart_price); // 장바구니 가격을 설정합니다.
        cartDTO.setCart_amount(cart_amount); // 장바구니 수량을 설정합니다.
        cartDTO.setCart_date(new java.sql.Date(System.currentTimeMillis()).toString()); // 현재 날짜를 설정합니다.

        // CartDAO를 사용하여 장바구니에 항목을 추가합니다.
        cartDao.insert(cartDTO);

        // 장바구니 목록 페이지로 리다이렉트합니다.
        return "redirect:/cart/list";
    }

    @RequestMapping("/list") // HTTP GET 및 POST 요청을 "/cart/list"에 매핑합니다.
    public ModelAndView list(HttpSession session) {
        // 세션에서 "mem_id" 값을 가져옵니다.
        String s_id = (String) session.getAttribute("mem_id");
        ModelAndView mav = new ModelAndView(); // ModelAndView 객체를 생성합니다.
        mav.setViewName("cart/list"); // 뷰 이름을 "cart/list"로 설정합니다.

        // CartDAO를 사용하여 장바구니 목록을 가져옵니다.
        List<CartDTO> cartList = cartDao.list(s_id);
        // CartDAO를 사용하여 장바구니 총 금액을 가져옵니다.
        int totalPrice = cartDao.getTotalPrice(s_id);

        // ModelAndView 객체에 장바구니 목록과 총 금액을 추가합니다.
        mav.addObject("list", cartList);
        mav.addObject("totalPrice", totalPrice);

        // ModelAndView 객체를 반환합니다.
        return mav;
    }

    @GetMapping("/delete") // HTTP GET 요청을 "/cart/delete"에 매핑합니다.
    public String delete(HttpServletRequest req, HttpSession session) {
        // 요청 파라미터에서 "cartno" 값을 가져와서 정수로 변환합니다.
        int cartno = Integer.parseInt(req.getParameter("cartno"));
        // 삭제할 항목을 지정하는 맵을 생성합니다.
        HashMap<String, Object> map = new HashMap<>();
        map.put("cart_no", cartno); // 맵에 "cart_no"를 추가합니다.
        map.put("mem_id", (String) session.getAttribute("mem_id")); // 맵에 "mem_id"를 추가합니다.

        // CartDAO를 사용하여 장바구니에서 항목을 삭제합니다.
        cartDao.delete(map);

        // 장바구니 목록 페이지로 리다이렉트합니다.
        return "redirect:/cart/list";
    }
}
