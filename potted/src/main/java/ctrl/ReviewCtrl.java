package ctrl;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import config.CtrlConfig.LoginRequired;
import svc.*;
import vo.*;

@Controller
public class ReviewCtrl {
	private ReviewSvc reviewSvc;

	public void setReviewSvc(ReviewSvc reviewSvc) {
		this.reviewSvc = reviewSvc;
	}
	
	@GetMapping("/reviewForm")
	public String reviewForm() {
		return "review/reviewForm";
	}
	
	

}
