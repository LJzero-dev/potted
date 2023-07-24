package ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.*;
import svc.*;
import vo.*;

@Controller
public class ProductCtrl {
	@GetMapping("/productIn")
	public String index(Model model) {
		
		ProductInSvc productInSvc = new ProductInSvc();
		ArrayList<ProductCtgrBig> bigList = productInSvc.getBigList();
		ArrayList<ProductCtgrSmall> smallList = productInSvc.getSmallList();
		
		model.addAttribute("bigList", bigList);
		model.addAttribute("smallList", smallList);
		
		return "product/productIn";
	}
	
	
}
