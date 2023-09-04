package ctrl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import config.CtrlConfig.*;
import svc.*;
import vo.*;

@Controller
public class MemberCtrl {
	private MemberSvc memberSvc;

	public void setMemberSvc(MemberSvc memberSvc) {
		this.memberSvc = memberSvc;
	}
	
	@LoginRequired
	@GetMapping ("/mypage")
	public String mypage() {
		return "member/mypage";
	}
	
	@LoginRequired
	@GetMapping ("/orderInfo")
	public String orderInfo(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 5, bsize = 5;
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage"));
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		List<OrderInfo> orderList = memberSvc.getOrderList(miid, cpage, psize);
		
		rcnt = memberSvc.getOrderListCount(miid);

		pcnt = rcnt / psize;	if(rcnt % psize > 0)	pcnt++;
		spage = (cpage - 1) / bsize * bsize + 1;
		PageInfo pi = new PageInfo();
		pi.setBsize(bsize);			pi.setCpage(cpage);
		pi.setPcnt(pcnt);			pi.setPsize(psize);
		pi.setRcnt(rcnt);			pi.setSpage(spage);
		
		model.addAttribute("pi", pi);
		request.setAttribute("orderList", orderList);
		
		return "member/orderInfo";
	}
	
	@LoginRequired
	@GetMapping ("/pointInfo")
	public String pointInfo(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 5, bsize = 5;
		// 현재 페이지 번호, 페이지 수, 시작페이지, 게시글 수, 페이지 크기, 블록 크기를 저장할 변수
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage"));
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		List<MemberPoint> memberPoint = memberSvc.getMemberPoint(miid, cpage, psize);
		
		rcnt = memberSvc.getMemberPointListCount(miid);
		
		pcnt = rcnt / psize;	if(rcnt % psize > 0)	pcnt++;
		spage = (cpage - 1) / bsize * bsize + 1;
		PageInfo pi = new PageInfo();
		pi.setBsize(bsize);			pi.setCpage(cpage);
		pi.setPcnt(pcnt);			pi.setPsize(psize);
		pi.setRcnt(rcnt);			pi.setSpage(spage);

		model.addAttribute("pi", pi);
		request.setAttribute("memberPoint", memberPoint);
		return "member/pointInfo";
	}
	
	@LoginRequired
	@GetMapping ("/out")
	public String out() {
		return "member/out";
	}
	
	@GetMapping("/joinForm")
	public String joinForm() {
		return "member/joinForm";
	}
	
	@GetMapping("/termsOfService")
	public String termsOfService() {
		return "member/termsOfService";
	}
	
	@PostMapping("/dupId")
	@ResponseBody
	public String dupId(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim().toLowerCase();
		int result = memberSvc.chkDupId(uid);

		return result + "";
	}
}
