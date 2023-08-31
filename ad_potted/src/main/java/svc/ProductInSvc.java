package svc;

import java.util.*;

import org.springframework.stereotype.Service;

import dao.*;
import vo.*;

@Service
public class ProductInSvc {
	private ProductInDao productInDao;
	
	public void setProductInDao(ProductInDao productInDao) {
		this.productInDao = productInDao;	
	}
	
	public ArrayList<ProductCtgrBig> getBigList() {
		ArrayList<ProductCtgrBig> bigList = productInDao.getBigList();
		return bigList;
	}

	public ArrayList<ProductCtgrSmall> getSmallList() {
		ArrayList<ProductCtgrSmall> smallList = productInDao.getSmallList();
		return smallList;
	}

	public int productInsert(ProductInfo pi, ArrayList<ProductOptionStock> poList) {
		int result = productInDao.productInsert(pi, poList);
		return result;
	}

	public int getProductCount(String where) {
		int rcnt = 0;
		rcnt = productInDao.getProductCount(where);
		return rcnt;
	}

	public List<ProductInfo> getProductList(PageInfo pageInfo) {
		List<ProductInfo> productList = productInDao.getProductList(pageInfo);
		return productList;
	}

	public ProductInfo getProductInfo(String piid) {
		ProductInfo productInfo = productInDao.getProductInfo(piid);
		return productInfo;
	}

	public List<ProductOptionStock> getProductOptionInfo(String piid) {
		List<ProductOptionStock> poList = productInDao.getProductOptionInfo(piid);
		return poList;
	}


}
