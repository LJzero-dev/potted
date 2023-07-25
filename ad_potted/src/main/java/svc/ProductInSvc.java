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



}
