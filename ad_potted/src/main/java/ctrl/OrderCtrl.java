package ctrl;

import java.util.*;
import javax.servlet.http.HttpServletRequest;

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
}
