package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class SetbannerCtrl {
	@GetMapping("/setbanner")
	public String setbanner() {
		return "banner/setbanner";
	}
}
