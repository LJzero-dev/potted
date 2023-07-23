package ctrl;

import java.io.*;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class ProductListCtrl {
	private ProductListSvc productListSvc;

	public void setProductListSvc(ProductListSvc productListSvc) {
		this.productListSvc = productListSvc;
	}
	
	@GetMapping("/productList")
	public String productList(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		List<ProductInfo> productList = productListSvc.getProductList();
		request.setAttribute("productList", productList);
		
		return "product/productList";
	}
	
	


}
