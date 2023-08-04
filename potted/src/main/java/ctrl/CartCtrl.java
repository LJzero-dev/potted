package ctrl;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import config.CtrlConfig.LoginRequired;
import svc.*;
import vo.*;

@Controller
public class CartCtrl {
	private CartSvc cartSvc;

	public void setCartSvc(CartSvc cartSvc) {
		this.cartSvc = cartSvc;
	}
	
	@LoginRequired
	@PostMapping ("/cartProc")
	public void cartProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		// ��ǰ ���� �ޱ�
		String piid = request.getParameter("piid");
		String option = request.getParameter("option");
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		int price = Integer.parseInt(request.getParameter("price"));
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		
		// ��ٱ��Ͽ� insert
		OrderCart oc = new OrderCart();
		oc.setMi_id(miid);
		oc.setPi_id(piid);
		oc.setOc_option(option);
		oc.setOc_cnt(cnt);
		oc.setOc_price(price);
		int result = cartSvc.cartInsert(oc);

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);

	}
	
	@LoginRequired
	@GetMapping ("/cartView")
	public String cartView(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		List<OrderCart> orderCart = cartSvc.getOrderCart(miid);
		
		model.addAttribute("orderCart", orderCart);
		
		return "order/cartView";
	}
	
	@PostMapping ("/cartProcDel")
	public void cartProcDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int ocidx = Integer.parseInt(request.getParameter("ocidx"));
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		
		int result = cartSvc.cartDel(ocidx, miid);

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
	}

}
