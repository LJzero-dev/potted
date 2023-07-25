package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import svc.*;
import vo.*;

@Controller
public class ProductCtrl {
	ProductInSvc productInSvc;

	public void setProductInSvc(ProductInSvc productInSvc) {
		this.productInSvc = productInSvc;
	}

	@GetMapping("/productIn")
	public String productIn(Model model) throws Exception {
		ArrayList<ProductCtgrBig> bigList = productInSvc.getBigList();
		ArrayList<ProductCtgrSmall> smallList = productInSvc.getSmallList();

		model.addAttribute("bigList", bigList);
		model.addAttribute("smallList", smallList);
		
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
