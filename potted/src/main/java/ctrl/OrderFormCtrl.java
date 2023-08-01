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
		// 장바구니 구매 : c | 바로구매 : D
		String pi_id = request.getParameter("pi_id");
		String pi_name = request.getParameter("pi_name");
		String total = request.getParameter("totalPrice");
		String option = request.getParameter("option");
		
		
		MemberInfo mi = (MemberInfo) request.getSession().getAttribute("loginInfo");
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
