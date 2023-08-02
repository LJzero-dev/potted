package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class ScheduleCtrl {
	@GetMapping("/schedule")
	public String schedule() {
		return "schedule/schedule";
	}
}
