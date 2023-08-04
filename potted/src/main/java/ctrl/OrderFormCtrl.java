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
	private OrderSvc orderSvc;

    public void setOrderSvc(OrderSvc orderSvc) {
        this.orderSvc = orderSvc;
    }

	@LoginRequired
	@PostMapping("/orderForm")
	public String orderForm(Model model, HttpServletRequest request) throws Exception  {
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		// ��ٱ��� ���� : c | �ٷα��� : d
		String pi_id = request.getParameter("pi_id");
		String pi_name = request.getParameter("pi_name");
		String total = request.getParameter("totalPrice");
		String option = request.getParameter("option");
		String totalc = request.getParameter("totalc");
		String delic = request.getParameter("delic");
		String todelc = request.getParameter("todelc");
		
		
		MemberInfo mi = (MemberInfo) request.getSession().getAttribute("loginInfo");
		
		String miid = mi.getMi_id();
		
		String select = "select a.pi_id, a.pi_name, a.pi_img1, b.pos_id, "; 
		String from = "from t_product_info a, t_product_option_stock b "; 
		String where = "where a.pi_id = b.pi_id and a.pi_isview = 'y' and b.pos_isview = 'y' ";
		
		if (kind.equals("c")) {	// ��ٱ��ϸ� ���� ����(c)�� ���
			String[] arr = request.getParameterValues("chk");
			select += " c.oc_cnt cnt, c.oc_idx ";
			from += ", t_order_cart c ";
			where += " and a.pi_id = c.pi_id and b.pos_id = c.mi_id = '" + miid + "' and (";
			
			for (int i = 1 ; i < arr.length ; i++) {
				if (i == 1) where += "c.oc_idx = " + arr[i];
				else 		where += " or c.oc_idx = " + arr[i];
			}
			where += ") order by a.pi_id, c.pos_idx";
			
		} else {	// �ٷ� ����(d)�� ���
				int cnt = Integer.parseInt(request.getParameter("cnt"));
				System.out.println(cnt);
				select += cnt + " cnt ";
				where += " and a.pi_id = '" + pi_id + "' ";
		}
		
		List<OrderCart> pdtList = orderSvc.getBuyList(kind, select + from + where);
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
		model.addAttribute("option", option);
		model.addAttribute("option", option);
		model.addAttribute("totalc", totalc);
		model.addAttribute("delic", delic);
		model.addAttribute("todelc", todelc);
		model.addAttribute("mi_phone", mi_phone);
		model.addAttribute("mi_email", mi_email);
		model.addAttribute("mi_point", mi_point);
		
		
		return "order/orderForm";
	}
}
