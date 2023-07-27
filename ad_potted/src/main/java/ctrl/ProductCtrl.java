package ctrl;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class ProductCtrl {
	ProductInSvc productInSvc;

	public void setProductInSvc(ProductInSvc productInSvc) {
		this.productInSvc = productInSvc;
	}

	@GetMapping("/productIn")
	public String productIn(HttpServletRequest request) throws Exception {
		ArrayList<ProductCtgrBig> bigList = productInSvc.getBigList();
		ArrayList<ProductCtgrSmall> smallList = productInSvc.getSmallList();

		request.setAttribute("bigList", bigList);
		request.setAttribute("smallList", smallList);
		
		return "product/productIn";
	}
	
	@PostMapping("/productProcIn")
	@ResponseBody
	public String productProcIn(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		ProductInfo pi = new ProductInfo();
		ProductOptionInfo po = new ProductOptionInfo();
		
		pi.setPi_id(request.getParameter("pi_id"));
		pi.setPcb_id(request.getParameter("pcb_id"));
		pi.setPcs_id(request.getParameter("pcs_id"));
		pi.setPi_name(request.getParameter("pi_name"));
		pi.setPi_price(Integer.parseInt(request.getParameter("pi_price")));
		pi.setPi_cost(Integer.parseInt(request.getParameter("pi_cost")));
		pi.setPi_dc (Integer.parseInt(request.getParameter("pi_dc")));
		pi.setPi_status(request.getParameter("pi_status"));
		pi.setPi_img1(request.getParameter("pi_img1"));
		pi.setPi_img2(request.getParameter("pi_img2"));
		pi.setPi_img3(request.getParameter("pi_img3"));
		pi.setPi_stock(Integer.parseInt(request.getParameter("pi_stock")));
		pi.setPi_desc(request.getParameter("pi_desc"));
		pi.setPi_date(request.getParameter("pi_date"));
		pi.setAi_idx(Integer.parseInt(request.getParameter("ai_idx")));
		
		po.setPos_id(request.getParameter("pos_id"));
		po.setPos_name(request.getParameter("pos_name"));
		po.setPoi_id(request.getParameter("poi_id"));
		po.setPos_sale(Integer.parseInt(request.getParameter("pos_sale")));
		po.setPos_isview(request.getParameter("pos_isview"));
		
		
		ProductInSvc productInSvc = new ProductInSvc();
		int result = productInSvc.productInsert(pi, po);
			
		return "redirect:/product/productIn";
	}
	
}
