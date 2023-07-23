package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductProcInCtrl {
	@GetMapping("/productIn")
	public String index() {
		return "product/productIn";
	}
}
