package svc;

import java.util.ArrayList;
import java.util.List;

import dao.AuctionDao;
import vo.PageInfo;
import vo.ProductCtgrBig;
import vo.ProductCtgrSmall;
import vo.ProductInfo;
import vo.ProductOptionStock;

public class AuctionSvc {
	private AuctionDao auctionDao;
	
	public void setAuctionDao(AuctionDao auctionDao) {
		this.auctionDao = auctionDao;	
	}

	public ArrayList<ProductCtgrBig> getBigList() {
		ArrayList<ProductCtgrBig> bigList = auctionDao.getBigList();
		return bigList;
	}

	public ArrayList<ProductCtgrSmall> getSmallList() {
		ArrayList<ProductCtgrSmall> smallList = auctionDao.getSmallList();
		return smallList;
	}

	public int productInsert(ProductInfo pi, ProductOptionStock po) {
		int result = auctionDao.productInsert(pi, po);
		return result;
	}

	public int getProductCount(String where) {
		int rcnt = 0;
		rcnt = auctionDao.getProductCount(where);
		return rcnt;
	}

	public List<ProductInfo> getProductList(PageInfo pageInfo) {
		List<ProductInfo> productList = auctionDao.getProductList(pageInfo);
		return productList;
	}

	public ProductInfo getProductInfo(String piid) {
		ProductInfo productInfo = auctionDao.getProductInfo(piid);
		return productInfo;
	}

	public List<ProductOptionStock> getProductOptionStock(String piid) {
		List<ProductOptionStock> poList = auctionDao.getProductOptionInfo(piid);
		return poList;
	}
}
