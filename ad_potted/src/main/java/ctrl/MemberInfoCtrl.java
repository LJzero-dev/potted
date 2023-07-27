package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import svc.MemberSvc;

@Controller
public class MemberInfoCtrl {
	private MemberSvc memberSvc;
	public void setMemberSvc(MemberSvc memberSvc) {
		this.memberSvc = memberSvc;
	}
	
	@GetMapping("memberList")
	public String memberList() {
		return "/member/memberList";
	}
}
