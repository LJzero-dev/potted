package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuctionCtrl {
	@GetMapping("/auction")
	public String auction() {
		return "auction";
	}
}
