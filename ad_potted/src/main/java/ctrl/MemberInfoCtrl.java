package ctrl;

import java.util.List;

import javax.servlet.http.*;
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
	public String memberList(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 5;
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage"));
		
		List<MemberInfo> memberList = memberSvc.getMemberList(cpage, psize);

		rcnt = memberSvc.getMemberCount();

		pcnt = rcnt / psize;	if(rcnt % psize > 0)	pcnt++;
		spage = (cpage - 1) / bsize * bsize + 1;
		PageInfo pi = new PageInfo();
		pi.setBsize(bsize);			pi.setCpage(cpage);
		pi.setPcnt(pcnt);			pi.setPsize(psize);
		pi.setRcnt(rcnt);			pi.setSpage(spage);
		
		model.addAttribute("pi", pi);
		request.setAttribute("memberList", memberList);
		return "/member/memberList";
	}
	
	@GetMapping("/memberDetail")
	public String memberDetail(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String miid = request.getParameter("miid");
		
		MemberInfo memberInfo = memberSvc.getMemberInfo(miid);
		
		request.setAttribute("memberInfo", memberInfo);
		return "/member/memberDetail";
	}
}
