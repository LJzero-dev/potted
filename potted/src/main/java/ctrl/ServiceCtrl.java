package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ServiceCtrl {
	@GetMapping("/service")
	public String noticeList() {
		return "service/noticeList";
	}
}
