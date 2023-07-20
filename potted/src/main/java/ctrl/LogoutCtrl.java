package ctrl;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;


@Controller
public class LogoutCtrl {
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		// session은 웹서버로 접근하는 순간 웹서버에서 웹브라우저에 부여 
		// 30분이 지나면 session이 없어지는 것이 아니라 다른 세션을 부여함 -> 세션에 있던 데이터들이 날라감
		return "redirect:/";
	}
}
