package ctrl;

import java.io.*;
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
	public String productList() {
		return "product/productList";
	}


}
