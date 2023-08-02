package svc;

import java.util.List;

import dao.*;
import vo.*;

public class IndexSvc {
	private IndexDao indexDao;

	public void setIndexDao(IndexDao indexDao) {
		this.indexDao = indexDao;
	}
	
	public List<ProductInfo> getProductLista() {
		List<ProductInfo> productLista = indexDao.getProductLista();
		return productLista;
	}
	
	public List<ProductInfo> getProductListb() {
		List<ProductInfo> productListb = indexDao.getProductListb();
		return productListb;
	}

	public List<FreeList> getFreeList() {
		List<FreeList> freeList = indexDao.getFreeList();
		return freeList;
	}
}
