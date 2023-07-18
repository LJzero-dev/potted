package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginFormCtrl {
	@GetMapping("/loginForm")
	public String loginForm() {
		return "loginForm";
	}

}
