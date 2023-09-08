package svc;

import java.util.List;

import dao.*;
import vo.*;

public class ReviewSvc {
	private ReviewDao reviewDao;
	
	public void setReviewDao(ReviewDao reviewDao) {
		this.reviewDao = reviewDao;	
	}

	public OrderDetail getOrderDetail(String oiid) {
		OrderDetail od = reviewDao.getOrderDetail(oiid);
		return od;
	}

	public int reviewInsert(ReviewList rl) {
		int result = reviewDao.reviewInsert(rl);
		return result;
	}

	public int reviewDel(int rlidx) {
		int result = reviewDao.reviewDel(rlidx);
		return result;
	}


}
