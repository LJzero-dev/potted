package test;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class TestCtrl {	// 서블릿을 상속받지 않아도 @Controller를 쓰면 서블릿으로 취급받음
	@GetMapping("/test")
	// Get 방식으로 test를 요청할 경우 처리할 메소드를 지정
	// Post 방식의 요청은 @PostMapping 애노테이션 사용
	// "/test" 경로로 들어온 요청을 처리할 메소드로 test() 메소드를 지정
	// get과 post 둘 다를 지정하려면 @RequestMapping("경로")을 사용
	// @RequestMapping[("경로", method=RequestMethod.GET or RequestMethod.POST)]
	public String test(Model model, @RequestParam(value="name", defaultValue="aaa", required=false) String name) {
	// Model : 컨트롤러의 처리 결과를 model에 담아서 뷰에 전달
	// @RequestParam : 요청  url의 파라미터 값을 메소드의 파라미터로 전달
	// defaultValue : name매개변수의 값이 없을 경우 들어갈 기본값. 없으면 null이 들어감
	// required : 필수여부로 true일 경우 name파라미터가 없으면 400 오류 발생하며 기본값은 false
		
		model.addAttribute("greeting", "안녕하세요, " + name);	// 모델의 속성으로 저장 greeting이라는 이름으로, 
		return "test";
		// 컨트롤러의 처리 결과를 보여줄 뷰 이름으로 "test"를 사용하겠다는 의미 - test.jsp
	}
	
	@GetMapping("/test2")
	public String test2(String name, HttpServletRequest request) {
	// 사용자의 요청을 받는 컨트롤러이므로 HttpServletRequest객체도 받아올 수 있음	-- controller이므로 request, response 받을 수 있고 / session도 사용가능
		request.setAttribute("greeting", "안녕하세요2, " + name);
		return "test";
	}
}
