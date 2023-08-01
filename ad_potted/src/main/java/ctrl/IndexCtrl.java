package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class IndexCtrl {
	@GetMapping("/index")
	public String index() {
		return "index";
	}
}
