package ctrl;

import java.io.PrintWriter;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class OrderCtrl {
	@Autowired
	OrderSvc orderSvc;

	public void setOrderSvc(OrderSvc orderSvc) {
		this.orderSvc = orderSvc;
	}

	@GetMapping("/orderList") 
	public String orderList(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 5, bsize = 5;
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		List<OrderInfo> orderList = orderSvc.getOrderList(cpage, psize);
		
		rcnt = orderSvc.getOrderListCount();
		
		pcnt = rcnt / psize;	if(rcnt % psize > 0)	pcnt++;
		spage = (cpage - 1) / bsize * bsize + 1;
		PageInfo pi = new PageInfo();
		pi.setBsize(bsize);			pi.setCpage(cpage);
		pi.setPcnt(pcnt);			pi.setPsize(psize);
		pi.setRcnt(rcnt);			pi.setSpage(spage);
		
		model.addAttribute("pi", pi);
		model.addAttribute("orderList", orderList);
		
		return "order/orderList";
	}
	
	@GetMapping("/orderDetail")
	public String orderDetail(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String oiid = request.getParameter("oiid");
		
		OrderInfo orderInfo = orderSvc.getOrderInfo(oiid);
		
		model.addAttribute("orderInfo", orderInfo);
		return "/order/orderDetail";
	}
	
	@PostMapping("/orderStateChg")
	public String orderStateChg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(request.getParameter("situation"));
		
		String oi_status = request.getParameter("oi_stauts");
		String oiid = request.getParameter("oi_id");
		
		OrderInfo oi = new OrderInfo();
		oi.setOi_status(request.getParameter("situation"));
		
		int result = orderSvc.getOrderState(oi_status, oiid);
		
		PrintWriter out = response.getWriter();
	    out.println("<script>window.close();</script>");
	    out.flush();
	    out.close();

	    return "redirect:/order/orderList";
	}
}