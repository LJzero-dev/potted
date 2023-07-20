package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginCtrl {
	@GetMapping("/loginForm")
	public String loginForm() {
		return "loginForm";
	}

}
