package ctrl;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import config.*;
import svc.*;
import vo.*;

@Controller
public class ReviewCtrl {
	private ReviewSvc reviewSvc;

	public void setReviewSvc(ReviewSvc reviewSvc) {
		this.reviewSvc = reviewSvc;
	}
	
	@GetMapping("/reviewForm")
	public String reviewForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String oiid = request.getParameter("oiid");
		
		// orderDetail에서 주문 정보 가져오기
		OrderDetail od = reviewSvc.getOrderDetail(oiid);
		
		request.setAttribute("od", od);
		// 가져온 정보 reviewList 형식으로 저장
		
		return "review/reviewForm";
	}
	
	@PostMapping("/reviewIn")
	public String reviewIn(MultipartFile[] uploadFile, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String piid = request.getParameter("pi_id");
		
		ReviewList rl = new ReviewList();
		rl.setMi_id(loginInfo.getMi_id());
		rl.setOi_id(request.getParameter("oi_id"));
		rl.setPi_id(piid);
		rl.setRl_content(request.getParameter("rl_content"));
		rl.setRl_good(request.getParameter("rl_good"));
		rl.setRl_name(request.getParameter("rl_name"));
		rl.setRl_ip(request.getRemoteAddr());
		
		String uploadPath = "E:/esm/project/potted/src/main/webapp/resources/images/review";
		String files = "";	// for문돌리기위해  ""을 안넣으면 null이되서
		for (MultipartFile file : uploadFile) {
			File saveFile = new File(uploadPath, file.getOriginalFilename());
			// 저장할 파일 객체생성
			try {
				file.transferTo(saveFile);
				files += "," + file.getOriginalFilename();
				rl.setRl_img(file.getOriginalFilename());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		int result = reviewSvc.reviewInsert(rl);
		
		return "redirect:/productView?piid=" + piid;
	}
	
	@GetMapping("/reviewDel")
	@ResponseBody
	public String reviewDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int rlidx = Integer.parseInt(request.getParameter("rlidx"));
		
		int result = reviewSvc.reviewDel(rlidx);

		return result + "";
	}
	

}
