package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import config.CtrlConfig.Login;
import config.CtrlConfig.LoginRequired;
import vo.MemberInfo;

@Controller
public class MyPlantCtrl {	
	@LoginRequired
	@GetMapping("/myPlant")
	public String myPlant() {
		return "/myPlant/plant_grow_up";
	}
}
