package svc;

import java.util.List;

import dao.*;
import vo.*;

public class ProductListSvc {
	private ProductListDao productListDao;
	
	public void setProductListDao(ProductListDao productListDao) {
		this.productListDao = productListDao;
	}
	

	public List<ProductInfo> getProductList(PageInfo pageInfo) {
		List<ProductInfo> productList = productListDao.getProductList(pageInfo);
		return productList;
	}


	public int getProductCount(String where) {
		int rcnt = 0;
		rcnt = productListDao.getProductCount(where);
		return rcnt;
	}


	public ProductInfo getProductInfo(String piid) {
		ProductInfo pi = productListDao.getProductInfo(piid);
		return pi;
	}


	public List<ProductOptionStock> getProductOptionStock(String piid) {
		List<ProductOptionStock> productOptionStock = productListDao.getProductOptionStock(piid);
		return productOptionStock;
	}


	public List<ProductOptionBig> getProductOptionBig() {
		List<ProductOptionBig> productOptionBig = productListDao.getProductOptionBig();
		return productOptionBig;
	}


	public int setbid(int bidprice,String piid, String miid) {
		return productListDao.setbid(bidprice,piid, miid);
	}


	public List<ReviewList> getReviewList(String piid) {
		List<ReviewList> reviewList = productListDao.getReviewList(piid);
		return reviewList;
	}


	public int getReviewListCount(String piid) {
		int rcnt = productListDao.getReviewListCount(piid);
		return rcnt;
	}
}
