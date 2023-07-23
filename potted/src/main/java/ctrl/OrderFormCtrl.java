package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class OrderFormCtrl {
	@GetMapping("/orderView")
	public String productList() {
		return "order/orderForm";
	}
}
