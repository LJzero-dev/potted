package config;

import org.springframework.context.annotation.*;
import dao.*;
import svc.*;

public class ReviewConfig {

	@Bean
	public ReviewDao reviewDao() {
		return new ReviewDao(DbConfig.dataSource());
	}
	
	@Bean
	public ReviewSvc reviewSvc() {
		ReviewSvc reviewSvc = new ReviewSvc();
		reviewSvc.setReviewDao(reviewDao()); 
		return reviewSvc;
	}
}
