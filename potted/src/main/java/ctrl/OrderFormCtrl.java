package ctrl;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import config.CtrlConfig.LoginRequired;
import svc.*;
import vo.*;

@Controller
public class OrderFormCtrl {

	@LoginRequired
	@PostMapping("/orderForm")
	public String orderForm(Model model, HttpServletRequest request) throws Exception  {
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		// 장바구니 구매 : c | 바로구매 : d
		String pi_id = request.getParameter("pi_id");
		String pi_name = request.getParameter("pi_name");
		String total = request.getParameter("totalPrice");
		String option = request.getParameter("option");
		
		
		MemberInfo mi = (MemberInfo) request.getSession().getAttribute("loginInfo");
		
		String miid = mi.getMi_id();
		
		String select = "select a.pi_id, a.pi_name, a.pi_img1, b.pos_id, if(a.pi_dc > 0, round((1 - a.pi_dc) * a.pi_price), a.pi_price) price, "; 
		String from = "from t_product_info a, t_product_option_stock b "; 
		String where = "where a.pi_id = b.pi_id and a.pi_isview = 'y' and b.pos_isview = 'y' ";
		
		if (kind.equals("c")) {	// 장바구니를 통한 구매(c)일 경우
			String[] arr = request.getParameterValues("chk");
			select += " c.oc_cnt cnt, c.oc_idx ";
			from += ", t_order_cart c ";
			where += " and a.pi_id = c.pi_id and b.pos_idx = c.pos_idx and c.mi_id = '" + miid + "' and (";
			
			for (int i = 1 ; i < arr.length ; i++) {
				if (i == 1) where += "c.oc_idx = " + arr[i];
				else 		where += " or c.oc_idx = " + arr[i];
			}
			where += ") order by a.pi_id, c.pos_idx";
			
		} else {	// 바로 구매(d)일 경우
				int cnt = Integer.parseInt(request.getParameter("cnt"));
				select += cnt + " cnt ";
				where += " and a.pi_id = '" + pi_id;
		}
		
		OrderSvc orderSvc = new OrderSvc(); 
		ArrayList<OrderCart> pdtList = orderSvc.getBuyList(kind, select + from + where);
		ArrayList<MemberAddr> addrList = orderSvc.getAddrList(miid);
		
		request.setAttribute("pdtList", pdtList);
		request.setAttribute("addrList", addrList);
		
	    String mi_name = mi.getMi_name();
	    String mi_phone = mi.getMi_phone();
	    String mi_email = mi.getMi_email();
	    int mi_point = mi.getMi_point();
		
		model.addAttribute("pi_id", pi_id);
		model.addAttribute("pi_name", pi_name);
		model.addAttribute("total", total);
		model.addAttribute("option", option);
		model.addAttribute("mi_name", mi_name);
		model.addAttribute("mi_phone", mi_phone);
		model.addAttribute("mi_email", mi_email);
		model.addAttribute("mi_point", mi_point);
		
		
		return "order/orderForm";
	}
}
