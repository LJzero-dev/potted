package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import config.CtrlConfig.*;

@Controller
public class MemberCtrl {
	
	@LoginRequired
	@GetMapping ("/mypage")
	public String mypage() {
		return "member/mypage";
	}
	

	@LoginRequired
	@GetMapping ("/orderInfo")
	public String orderInfo() {
		return "member/orderInfo";
	}
}
