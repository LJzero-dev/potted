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
	public String myPlant(@Login MemberInfo mi) {
		System.out.println(mi.getClass());
		System.out.println(mi.getMi_name());
		return "/myPlant/plant_grow_up";
	}
}
