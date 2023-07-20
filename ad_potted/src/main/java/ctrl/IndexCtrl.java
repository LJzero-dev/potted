package ctrl;

import org.springframework.web.bind.annotation.GetMapping;

public class IndexCtrl {
	@GetMapping("/")
	public String index() {
		return "index";
	}
}
