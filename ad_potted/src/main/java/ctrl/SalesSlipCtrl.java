package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class SalesSlipCtrl {
	@GetMapping("salesSlip")
	public String salesSlip() {
		return "sales/salesSlip";
	}
}
