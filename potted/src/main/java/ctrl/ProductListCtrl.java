package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class ProductListCtrl {
	@GetMapping("/productList")
	public String productList() {
		return "product/productList";
	}

}
