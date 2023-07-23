package svc;

import java.util.List;

import dao.*;
import vo.*;

public class ProductListSvc {
	private ProductListDao productListDao;
	
	public void setProductListDao(ProductListDao productListDao) {
		this.productListDao = productListDao;
	}
	

	public List<ProductInfo> getProductList() {
		List<ProductInfo> productList = productListDao.getProductList();
		return productList;
	}

}
