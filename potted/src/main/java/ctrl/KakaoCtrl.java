package ctrl;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import svc.KakaoSvc;
import vo.MemberInfo;

@Controller
public class KakaoCtrl {
	private KakaoSvc kakaoSvc;

	public void setKakaoSvc(KakaoSvc kakaoSvc) {
		this.kakaoSvc = kakaoSvc;
	}
	
	@GetMapping("/kakaoLoginProc")
	public String kakaoLoginProc(HttpServletRequest request, Model model, String code) throws Exception {
		System.out.println(code);
		String accessToken = kakaoSvc.getAccessToken(code);
		HashMap<String, String> kakaoInfo = kakaoSvc.getUserInfo(accessToken);
		String id = kakaoInfo.get("id");
		String nickname = kakaoInfo.get("nickname");
		String gender = kakaoInfo.get("gender");
		String email = kakaoInfo.get("email");
		String [] mailArr = email.split("@");
		String emailId = "", emailDomain = "";
		for(int i = 0 ; i < mailArr.length ; i++){
			emailId = mailArr[0];
			emailDomain = mailArr[1];
		}
		String birthday = kakaoInfo.get("birthday");
		
		System.out.println("kakaoInfo : " + kakaoInfo);
		System.out.println("nickname : " + kakaoInfo.get("nickname"));
		System.out.println("gender : " + kakaoInfo.get("gender"));
		System.out.println("email : " + kakaoInfo.get("email"));
		System.out.println("birthday : " + kakaoInfo.get("birthday"));
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("gender", gender);
		model.addAttribute("emailId", emailId);
		model.addAttribute("emailDomain", emailDomain);
		model.addAttribute("birthday", birthday);
		
		// 현재 회원의 이메일과 동일한지 여부 검사
		int result = kakaoSvc.isMem(email);
		
		if(result != 1) {
			return "member/joinForm";
		} else {
			MemberInfo loginInfo = kakaoSvc.getLoginInfo(email);
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
			return "redirect:/";
		}
		
	}
}
