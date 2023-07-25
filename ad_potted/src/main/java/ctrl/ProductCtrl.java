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
	
	@PostMapping("/SmallCategories")
	@ResponseBody
	public int smallCategories(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		System.out.println("a");
		System.out.println(request.getParameter("bigCategoryId"));
		return 0;		
	}
	
}
