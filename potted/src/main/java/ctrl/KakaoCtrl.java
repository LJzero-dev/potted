package ctrl;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import svc.KakaoSvc;

@Controller
public class KakaoCtrl {
	private KakaoSvc kakaoSvc;

	public void setKakaoSvc(KakaoSvc kakaoSvc) {
		this.kakaoSvc = kakaoSvc;
	}
	
	@GetMapping("/kakaoLoginProc")
	public String kakaoLoginProc(Model model, String code) throws Exception {
		System.out.println(code);
		String accessToken = kakaoSvc.getAccessToken(code);
		HashMap<String, String> loginInfo = kakaoSvc.getUserInfo(accessToken);
		
		System.out.println("loginInfo : " + loginInfo);
		System.out.println("nickname : " + loginInfo.get("nickname"));
		System.out.println("gender : " + loginInfo.get("gender"));
		System.out.println("birthday : " + loginInfo.get("birthday"));
		
		model.addAttribute("loginInfo", loginInfo);
		
		return "redirect:/";
	}
}
