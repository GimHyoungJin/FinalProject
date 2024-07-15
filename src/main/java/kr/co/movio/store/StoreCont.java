package kr.co.movio.store;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequestMapping("/store")
public class StoreCont {

    public StoreCont() {
        System.out.println("-----StoreCont() 객체 생성됨");
    }

    @GetMapping("/list")
    public String showList() {
        return "store/list";  // "WEB-INF/views/store/list.jsp" 파일을 반환
    }
}
