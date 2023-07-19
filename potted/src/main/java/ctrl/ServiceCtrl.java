package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class ServiceCtrl {
		@GetMapping("/service")
		public String serviceCtrl() {
			return "service/service";
	}
}
