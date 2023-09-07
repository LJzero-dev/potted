package ctrl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import svc.*;
import vo.*;

@Controller
public class BannerCtrl {
	@Autowired
	BannerSvc bannerSvc;

	public void setbannerSvc(BannerSvc bannerSvc) {
		this.bannerSvc = bannerSvc;
	}
	
	@GetMapping("/setbanner")
	public String setbanner(HttpServletRequest request) throws Exception {
		BannerList bl = bannerSvc.getBannerList();
		request.setAttribute("bl", bl);
		
		return "banner/setbanner";
	}
	
	@PostMapping("/setbannerProc")
	public String setbannerProc(MultipartFile[] uploadFile, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("imgNumber"));
		
		String uploadPath = "E:/esm/project/ad_potted/src/main/webapp/resources/images/product/banner";
		String files = "";	// for문돌리기위해  ""을 안넣으면 null이되서
		BannerList bl = new BannerList();
		for (MultipartFile file : uploadFile) {
			File saveFile = new File(uploadPath, file.getOriginalFilename());
			// 저장할 파일 객체생성
			try {
				file.transferTo(saveFile);
				files += "," + file.getOriginalFilename();
				String name = file.getOriginalFilename();
				int result = bannerSvc.UpdateBanner(num, name);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		return "redirect:/setbanner";
	}
	
}
