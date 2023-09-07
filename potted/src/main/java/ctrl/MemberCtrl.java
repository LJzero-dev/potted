package ctrl;

import java.io.PrintWriter;
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
	@GetMapping ("/auctionInfo")
	public String auctionInfo(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 5, bsize = 5;
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage"));
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		List<OrderInfo> auctionOrderList = memberSvc.getAuctionOrderList(miid, cpage, psize);
		
		rcnt = memberSvc.getAuctionOrderListCount(miid);

		pcnt = rcnt / psize;	if(rcnt % psize > 0)	pcnt++;
		spage = (cpage - 1) / bsize * bsize + 1;
		PageInfo pi = new PageInfo();
		pi.setBsize(bsize);			pi.setCpage(cpage);
		pi.setPcnt(pcnt);			pi.setPsize(psize);
		pi.setRcnt(rcnt);			pi.setSpage(spage);
		
		model.addAttribute("pi", pi);
		request.setAttribute("auctionOrderList", auctionOrderList);
		
		return "member/auctionInfo";
	}
	
	@LoginRequired
	@GetMapping ("/pointInfo")
	public String pointInfo(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 5, bsize = 5;
		// ���� ������ ��ȣ, ������ ��, ����������, �Խñ� ��, ������ ũ��, ��� ũ�⸦ ������ ����
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
	
	@PostMapping("/chkPw")
	@ResponseBody
	public String chkPw(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String pw = request.getParameter("pw").trim().toLowerCase();
		String pw2 = request.getParameter("pw2").trim().toLowerCase();
		int result = 0;
		if (!pw.equals(pw2))	result = 0;
		else					result = 1;

		return result + "";
	}
	
	@PostMapping("/memberJoin")
	public String memberJoin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		MemberInfo mi = new MemberInfo();
		mi.setMi_id(request.getParameter("mi_id"));
		mi.setMi_pw(request.getParameter("mi_pw"));
		mi.setMi_email(request.getParameter("e1") + "@" + request.getParameter("e3"));
		mi.setMi_phone(request.getParameter("p1") + "-" + request.getParameter("p2") + "-" + request.getParameter("p3"));
		mi.setMi_name(request.getParameter("mi_name"));
		mi.setMi_birth(request.getParameter("year") + "-" + request.getParameter("month") + "-" + request.getParameter("day"));
		mi.setMi_gender(request.getParameter("mi_gender"));
		mi.setMi_isad(request.getParameter("mi_isad"));
		
		MemberAddr ma = new MemberAddr();
		ma.setMa_zip(request.getParameter("ma_zip"));
		ma.setMa_addr1(request.getParameter("ma_addr1"));
		ma.setMa_addr2(request.getParameter("ma_addr2"));
		
		int result = memberSvc.memberInsert(mi, ma);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (result != 3) {
			out.println("<script>");
			out.println("alert('회원가입에 실패하였습니다. 다시 시도해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		return "redirect:/login";
	}
	
	@LoginRequired
	@GetMapping ("/setInfo")
	public String setInfo(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();

		int maidx = Integer.parseInt(request.getParameter("maidx"));
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(maidx);
		
		List<MemberAddr> memberAddrList = memberSvc.getMemberAddrList(miid);
		MemberAddr ma = memberSvc.getMemberAddr(miid, maidx);

		request.setAttribute("ma", ma);
		request.setAttribute("memberAddrList", memberAddrList);
		request.setAttribute("pageInfo", pageInfo);
		
		return "member/setInfo";
	}

	@PostMapping("/addrInsert")
	public String addrInsert(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		String basic = "";
		if (request.getParameter("ma_basic") == null)	basic = "n";
		else											basic = "y";
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		MemberAddr ma = new MemberAddr();
		ma.setMi_id(miid);
		ma.setMa_basic(basic);
		ma.setMa_name(request.getParameter("ma_name"));
		ma.setMa_rname(request.getParameter("ma_rname"));
		ma.setMa_phone(request.getParameter("p1") + "-" + request.getParameter("p2") + "-" + request.getParameter("p3"));
		ma.setMa_zip(request.getParameter("ma_zip"));
		ma.setMa_addr1(request.getParameter("ma_addr1"));
		ma.setMa_addr2(request.getParameter("ma_addr2"));
		
		int result = memberSvc.addrInsert(ma, idx);
		
		return "redirect:/setInfo?maidx=1";
	}

	@PostMapping("/addrUpdate")
	public String addrUpdate(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		String basic = "";
		if (request.getParameter("ma_basic") == null)	basic = "n";
		else											basic = "y";
		
		MemberAddr ma = new MemberAddr();
		ma.setMi_id(miid);
		ma.setMa_basic(basic);
		ma.setMa_idx(Integer.parseInt(request.getParameter("maidx")));
		ma.setMa_name(request.getParameter("ma_name"));
		ma.setMa_rname(request.getParameter("ma_rname"));
		ma.setMa_phone(request.getParameter("p1") + "-" + request.getParameter("p2") + "-" + request.getParameter("p3"));
		ma.setMa_zip(request.getParameter("ma_zip"));
		ma.setMa_addr1(request.getParameter("ma_addr1"));
		ma.setMa_addr2(request.getParameter("ma_addr2"));
		
		int result = memberSvc.addrUpdate(ma);
		
		return "redirect:/setInfo?maidx=1";
	}
	
}
