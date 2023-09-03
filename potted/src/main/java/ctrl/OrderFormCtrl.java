package ctrl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import config.CtrlConfig.LoginRequired;
import svc.OrderSvc;
import vo.MemberAddr;
import vo.MemberInfo;
import vo.OrderCart;
import vo.OrderDetail;
import vo.OrderInfo;

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
		String isAuction = request.getParameter("isAuction");
		// ������熬���������占� ������������ : c | ����濡�源��������� : d
		String pi_id = request.getParameter("pi_id");
		String pi_name = request.getParameter("pi_name");
		String pi_price = request.getParameter("pi_price");
		String pi_img1 = request.getParameter("pi_img1");
		String pi_dc = request.getParameter("pi_dc");
		int pcnt = Integer.parseInt(request.getParameter("cnt"));
		
		String total = request.getParameter("totalPrice");
		String option = request.getParameter("option");
		String totalc = request.getParameter("totalc");
		String delic = request.getParameter("delic");
		String todelc = request.getParameter("todelc");
		String orderCart = request.getParameter("orderCart");
		
		
		MemberInfo mi = (MemberInfo) request.getSession().getAttribute("loginInfo");
		
		String miid = mi.getMi_id();
		
		String select = "select a.pi_id, a.pi_name, a.pi_img1, group_concat(b.pos_id) pos_id, "; 
		String from = "from t_product_info a, t_product_option_stock b "; 
		String where = "where a.pi_id = b.pi_id and a.pi_isview = 'y' and b.pos_isview = 'y' ";
		
		if (kind.equals("c")) {	// ������熬�����������占� ������������ ������������(c)������ ��������占�
			String[] arr = request.getParameterValues("chk");
			
			
			select += " c.oc_option, c.oc_cnt cnt, c.oc_idx ";
			from += ", t_order_cart c ";
			where += " and a.pi_id = c.pi_id and b.pos_id = c.mi_id = '" + miid + "' and (";
			
			for (int i = 1 ; i < arr.length ; i++) {
				if (i == 1) where += "c.oc_idx = " + arr[i];
				else 		where += " or c.oc_idx = " + arr[i];
			}
			where += ") order by a.pi_id";
			
		} else {    // 諛�濡� 援щℓ(d)�� 寃쎌��
            int cnt = Integer.parseInt(request.getParameter("cnt"));
            select += cnt + " cnt ";
            where += " and a.pi_id = '" + pi_id + "' ";
        }
		
		List<OrderCart> pdtList = orderSvc.getBuyList(kind, select + from + where);
		ArrayList<MemberAddr> addrList = orderSvc.getAddrList(miid);
		
		request.setAttribute("addrList", addrList);
		
	    String mi_name = mi.getMi_name();
	    String mi_phone = mi.getMi_phone();
	    String mi_email = mi.getMi_email();
	    int mi_point = mi.getMi_point();
		
	    model.addAttribute("pdtList", pdtList);
        model.addAttribute("kind", kind);
		model.addAttribute("pi_id", pi_id);
		model.addAttribute("pi_name", pi_name);
		model.addAttribute("pi_price", pi_price);
		model.addAttribute("pi_img1", pi_img1);
		model.addAttribute("pi_dc", pi_dc);
		model.addAttribute("pcnt", pcnt);
		model.addAttribute("total", total);
		model.addAttribute("mi_name", mi_name);
		model.addAttribute("option", option);
		model.addAttribute("totalc", totalc);
		model.addAttribute("delic", delic);
		model.addAttribute("todelc", todelc);
		model.addAttribute("mi_phone", mi_phone);
		model.addAttribute("mi_email", mi_email);
		model.addAttribute("mi_point", mi_point);
		model.addAttribute("orderCart", orderCart);
		model.addAttribute("isAuction", request.getParameter("isAuction") != null ? "y" : "n");
		 
		
		
		return "order/orderForm";
	}
	
	@PostMapping("/orderProcIn")
	public String orderProcIn(Model model, HttpServletRequest request) throws Exception  {
		request.setCharacterEncoding("utf-8");
		
		MemberInfo mi = (MemberInfo) request.getSession().getAttribute("loginInfo");
		String miid = mi.getMi_id();
		
		String oi_apointParam = request.getParameter("oi_apoint");
	    int oi_apoint = Integer.parseInt(oi_apointParam.split("\\.")[0]); // �����쎌�������� ������������ ���몃��� ������������
		OrderInfo oi = new OrderInfo();
		OrderDetail od = new OrderDetail();
		
		oi.setMi_id(miid);
		oi.setPi_id(request.getParameter("pi_id"));
		oi.setOi_name(request.getParameter("oi_name"));
		oi.setOi_phone(request.getParameter("oi_phone"));
		oi.setOi_zip(request.getParameter("oi_zip"));
		oi.setOi_addr1(request.getParameter("oi_addr1"));
		oi.setOi_addr2(request.getParameter("oi_addr2"));
		oi.setOi_memo(request.getParameter("oi_memo"));
		oi.setOi_payment(request.getParameter("oi_payment"));
		oi.setOi_pay(Integer.parseInt(request.getParameter("oi_pay")));
		oi.setOi_upoint(Integer.parseInt(request.getParameter("oi_upoint")));
		oi.setOi_apoint(oi_apoint);
		oi.setOi_kind(request.getParameter("oi_kind"));
		oi.setIsAuction(request.getParameter("isAuction"));
		oi.setOi_cnt(Integer.parseInt(request.getParameter("pcnt")));
		od.setOd_name(request.getParameter("od_name"));
		od.setOd_img(request.getParameter("od_img"));
		od.setOd_option(request.getParameter("option"));
		
		int result = orderSvc.orderInsert(oi, od);
		mi.setMi_point(mi.getMi_point() + oi_apoint - oi.getOi_upoint());
		return "redirect:/mypage";
	}
}
