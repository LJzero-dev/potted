package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPlantCtrl {
	@GetMapping("/myPlant")
	public String myPlant() {
		return "myPlant";
	}
}
