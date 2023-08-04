package ctrl;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import svc.*;
import vo.*;

@Controller
public class MemberInfoCtrl {
	private MemberSvc memberSvc;
	public void setMemberSvc(MemberSvc memberSvc) {
		this.memberSvc = memberSvc;
	}
	
	@GetMapping("memberList")
	public String memberList(Model model) {
		List<MemberInfo> memberList = memberSvc.getMemberList();
		
		model.addAttribute("memberList", memberList);
		return "/member/memberList";
	}
}
