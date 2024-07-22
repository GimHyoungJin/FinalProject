package kr.co.movio.cart;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartCont {

    public CartCont() {
        System.out.println("-----CartCont() 객체 생성됨");
    }

    @Autowired
    private CartDAO cartDao;

    @PostMapping("/insert")
    public String cartInsert(
        @RequestParam("pro_detail_code") String pro_detail_code,
        @RequestParam("pro_name") String pro_name,  // 상품명 추가
        @RequestParam("cart_price") int cart_price,
        @RequestParam("cart_amount") int cart_amount,
        HttpSession session,
        RedirectAttributes redirectAttributes
    ) {
        String mem_id = (String) session.getAttribute("mem_id");

        if (mem_id == null) {
            redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        CartDTO cartDTO = new CartDTO();
        cartDTO.setMem_id(mem_id);
        cartDTO.setPro_detail_code(pro_detail_code);
        cartDTO.setPro_name(pro_name);  // 상품명 설정
        cartDTO.setCart_price(cart_price);
        cartDTO.setCart_amount(cart_amount);
        cartDTO.setCart_date(new java.sql.Date(System.currentTimeMillis()).toString());

        cartDao.insert(cartDTO);

        return "redirect:/cart/list";
    }

    @RequestMapping("/list")
    public ModelAndView list(HttpSession session) {
        String s_id = (String) session.getAttribute("mem_id");
        ModelAndView mav = new ModelAndView();
        mav.setViewName("cart/list");

        List<CartDTO> cartList = cartDao.list(s_id);
        int totalPrice = cartDao.getTotalPrice(s_id);

        mav.addObject("list", cartList);
        mav.addObject("totalPrice", totalPrice);

        return mav;
    }

    @GetMapping("/delete")
    public String delete(HttpServletRequest req, HttpSession session) {
        int cartno = Integer.parseInt(req.getParameter("cartno"));
        HashMap<String, Object> map = new HashMap<>();
        map.put("cart_no", cartno);
        map.put("mem_id", (String) session.getAttribute("mem_id"));

        cartDao.delete(map);

        return "redirect:/cart/list";
    }

    @GetMapping("/items")
    @ResponseBody
    public List<CartDTO> getCartItems(HttpSession session) {
        String mem_id = (String) session.getAttribute("mem_id");
        if (mem_id != null) {
            List<CartDTO> cartItems = cartDao.list(mem_id);
            System.out.println("Fetched Cart Items: " + cartItems); // 디버깅 로그
            return cartItems;
        } else {
            return Collections.emptyList();
        }
    }
}
