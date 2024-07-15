package kr.co.movio;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller //MVC 패턴의 컨트롤러 역할을 한다.
public class HomeController {
	
	
	//객체 생성 확인을 위한 default Constructor
	public HomeController() {
		System.out.println("-----HomeController() 객체 생성");
	}
	

	//루트 URL "/"에 접속하면 /main으로 리다이렉트되며, /main은 index.jsp를 반환함
	// => http:localhost:8080/ 으로 접속하면 url에 보이는 것은 localhost:8080/main이라는 이야기
	      @RequestMapping("/")
	       public String home() {
	           return "redirect:/main";
	       }
	       
	       @RequestMapping("/main")
	       public String main() {
	           return "index";
	       }
}