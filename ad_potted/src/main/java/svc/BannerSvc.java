package svc;

import java.util.List;

import dao.*;
import vo.BannerList;

public class BannerSvc {

	private BannerDao bannerDao;
	
	public void setBannerDao(BannerDao bannerDao) {
		this.bannerDao = bannerDao;	
	}

	public BannerList getBannerList() {
		BannerList bl = bannerDao.getBannerList();
		return bl;
	}

	public int UpdateBanner(int num, String name) {
		int result = bannerDao.UpdateBanner(num, name);
		return result;
	}
}
