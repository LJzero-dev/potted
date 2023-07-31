package ctrl;


import java.util.*;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import svc.*;
import vo.*;

@Controller
public class ProductCtrl {
	@Autowired
	ProductInSvc productInSvc;

	public void setProductInSvc(ProductInSvc productInSvc) {
		this.productInSvc = productInSvc;
	}
	
	@GetMapping("/productList")
	public String productList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, spage = 0, psize = 5, bsize = 5, rcnt = 0, pcnt = 0;
		//	페이지 번호  
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String where = "", schargs = "";
		String keyword = request.getParameter("keyword");
		if (keyword != null && !keyword.equals("")) {
			schargs += "&sch=" + keyword;
			where += " and pi_name like '%" + keyword + "%'";
		}
		
		String orderBy = " order by ";	// 목록 정렬 순서
		String ob = request.getParameter("ob");	// 정렬조건
		if (ob == null || ob.equals(""))	ob = "a";	// 목록 처음 들어왔을 때는 정렬 조건이 없으므로 임의로 a로 정해둠
		String obargs = "&ob=" + ob; // 정렬조건을 위한 쿼리스트링
		switch (ob) {
		case "a" :	// 등록역순(기본값)(최근 등록이 가장 위에 옴
			orderBy += " pi_date desc ";		break;
		case "b" :	// 판매량(인기)순
			orderBy += " pi_sale desc ";		break;
		case "c" :	// 이름순
			orderBy += " pi_name desc ";		break;
		case "d" :	// 낮은 가격 순
			orderBy += " pi_price desc ";		break;
		case "e" :	// 높은 가격 순
			orderBy += " pi_price asc ";		break;
		}

		rcnt = productInSvc.getProductCount(where);
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0)	pcnt++;
		spage = (cpage -1) / bsize * bsize +1;
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);		pageInfo.setCpage(cpage);
		pageInfo.setSpage(spage);		pageInfo.setPsize(psize);
		pageInfo.setPcnt(pcnt);			pageInfo.setRcnt(rcnt);
		pageInfo.setOb(ob);
		pageInfo.setSchargs(schargs);	pageInfo.setObargs(obargs);
		pageInfo.setWhere(where);		pageInfo.setOrderby(orderBy);

		List<ProductInfo> productList = productInSvc.getProductList(pageInfo);

		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
		return "product/productList";
	}

	@GetMapping("/productIn")
	public String productIn(HttpServletRequest request) throws Exception {
		ArrayList<ProductCtgrBig> bigList = productInSvc.getBigList();
		ArrayList<ProductCtgrSmall> smallList = productInSvc.getSmallList();

		request.setAttribute("bigList", bigList);
		request.setAttribute("smallList", smallList);
		
		return "product/productIn";
	}
	
	@PostMapping("/productProcIn")
	public String productProcIn(HttpServletRequest request, @RequestPart("pi_img1") Part piImg1,
	        @RequestPart("pi_img2") Part piImg2, @RequestPart("pi_img3") Part piImg3, @RequestPart("pi_desc") Part piDesc) throws Exception {
		request.setCharacterEncoding("utf-8");
		String uploadFiles = "";	// 업로드한 파일들의 이름을 누적하여 저장할 변수
		
		ProductInfo pi = new ProductInfo();
		ProductOptionInfo po = new ProductOptionInfo();
		
		String[] posIds = request.getParameter("pos_id").split(",");
		
		pi.setPi_id(request.getParameter("pi_id"));
		pi.setPcb_id(request.getParameter("pcb_id"));
		pi.setPcs_id(request.getParameter("pcs_id"));
		pi.setPi_name(request.getParameter("pi_name"));
		pi.setPi_price(Integer.parseInt(request.getParameter("pi_price")));
		pi.setPi_cost(Integer.parseInt(request.getParameter("pi_cost")));
		pi.setPi_dc (Integer.parseInt(request.getParameter("pi_dc")));
		pi.setPi_status(request.getParameter("pi_status"));
		pi.setPi_img1(getUploadFileName(piImg1.getHeader("content-disposition")));
		pi.setPi_img2(getUploadFileName(piImg2.getHeader("content-disposition")));
		pi.setPi_img3(getUploadFileName(piImg3.getHeader("content-disposition")));
		pi.setPi_stock(Integer.parseInt(request.getParameter("pi_stock")));
		pi.setPi_desc(getUploadFileName(piDesc.getHeader("content-disposition")));
		pi.setPi_date(request.getParameter("pi_date"));
		pi.setAi_idx(1);
	
		po.setPos_id(posIds[1]);
		po.setPos_price(Integer.parseInt(posIds[0]));
		po.setPob_id(request.getParameter("pob_id"));
		
		int result = productInSvc.productInsert(pi, po);
		
		for (Part part : request.getParts()) {
			if (part.getName().startsWith("pi_img") || part.getName().equals("pi_desc")) {
				String cd =  part.getHeader("content-disposition");
				String uploadName = getUploadFileName(cd);
				if (!uploadName.equals("")) {
				// 업로드할 파일이 있으면
					uploadFiles += ", " + uploadName;
					part.write(uploadName);
				}
				
			}
		}
		if (!uploadFiles.equals(""))	uploadFiles = uploadFiles.substring(2);
			
		return "redirect:/productList";
	}

	private String getUploadFileName(String cd) {
		String uploadName = null;
		String[] arrContent = cd.split(";");
		
		int fIdx = arrContent[2].indexOf("\"");
		int sIdx = arrContent[2].lastIndexOf("\"");
		
		uploadName = arrContent[2].substring(fIdx + 1, sIdx);
		return uploadName;
	}
	
	@GetMapping("/productUp")
	public String productUp(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String piid = request.getParameter("piid");
		ProductInfo pi = productInSvc.getProductInfo(piid);
		ArrayList<ProductCtgrBig> bigList = productInSvc.getBigList();
		ArrayList<ProductCtgrSmall> smallList = productInSvc.getSmallList();

		request.setAttribute("bigList", bigList);
		request.setAttribute("smallList", smallList);
		
		model.addAttribute("pi", pi);
		
		return "product/productUp";
	}

	
}
