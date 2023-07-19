package svc;

import dao.*;
import vo.*;

public class ProductListSvc {
	private ProductListDao productListDao;
	
	public void setProductListDao(ProductListDao productListDao) {
		this.productListDao = productListDao;
	}
	

	public ProductInfo getProductList() {
		ProductInfo productInfo = productListDao.getProductList(); 
		return productInfo;
	}
	
	/*
	public int memberInsert(MemberInfo mi) {
		int result = memberDao.memberInsert(mi);
		return result;
	}*/

}
