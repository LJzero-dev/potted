package ctrl;

import java.time.LocalDate;
import java.util.*;

import javax.servlet.http.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import svc.*;
import vo.*;

@Controller
public class AuctionCtrl {
	private AuctionSvc auctionSvc;

	public void setAuctionSvc(AuctionSvc auctionSvc) {
		this.auctionSvc = auctionSvc;
	}
	
	@GetMapping("/auction")
	public String productList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, spage = 0, psize = 5, bsize = 5, rcnt = 0, pcnt = 0;
		
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String where = "", schargs = "";
		String keyword = request.getParameter("keyword");
		if (keyword != null && !keyword.equals("")) {
			schargs += "&sch=" + keyword;
			where += " and pi_name like '%" + keyword + "%'";
		}
		
		String orderBy = " order by ";	// ��� ���� ����
		String ob = request.getParameter("ob");	// ��������
		if (ob == null || ob.equals(""))	ob = "a";	// ��� ó�� ������ ���� ���� ������ �����Ƿ� ���Ƿ� a�� ���ص�
		String obargs = "&ob=" + ob; // ���������� ���� ������Ʈ��
		switch (ob) {
		case "a" :	// ��Ͽ���(�⺻��)(�ֱ� ����� ���� ���� ��
			orderBy += " pi_date desc ";		break;
		case "b" :	// �Ǹ���
			where += " and pi_status = 'a' ";
			orderBy += " pi_date desc ";		break;
		case "c" :	// �Ǹ� ����
			where += " and pi_status = 'b' ";
			orderBy += " pi_date desc ";		break;
		case "d" :	// ���� �Ǹŵ� ��
			orderBy += " pi_sale desc ";		break;
		case "e" :	// ��ȸ�� ��
			orderBy += " pi_read desc ";		break;
		}
		System.out.println("where===" + where);
		rcnt = auctionSvc.getProductCount(where);
		
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
		pageInfo.setKeyword(keyword);
		List<ProductInfo> productList = auctionSvc.getProductList(pageInfo);

		model.addAttribute("pageInfo", pageInfo);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
		return "auction/auction";
	}

	@GetMapping("/auctionIn")
	public String productIn(HttpServletRequest request) throws Exception {
		ArrayList<ProductCtgrBig> bigList = auctionSvc.getBigList();
		ArrayList<ProductCtgrSmall> smallList = auctionSvc.getSmallList();

		CalendarInfo ci = new CalendarInfo();
		LocalDate today = LocalDate.now();
		ci.setCurYear(today.getYear());
		ci.setCurMonth(today.getMonthValue());
		ci.setCurDay(today.getDayOfMonth());
		LocalDate schDate = LocalDate.of(ci.getCurYear(), ci.getCurMonth(), ci.getCurDay());
		ci.setSchLast(schDate.lengthOfMonth());
		

		request.setAttribute("ci", ci);
		request.setAttribute("bigList", bigList);
		request.setAttribute("smallList", smallList);
		
		return "auction/auctionIn";
	}
	
	@PostMapping("/auctionProcIn")
	public String productProcIn(HttpServletRequest request, @RequestPart("pi_img1") Part piImg1, @RequestPart("pi_desc") Part piDesc) throws Exception {
		request.setCharacterEncoding("utf-8");
		String uploadFiles = "";	// ���ε��� ���ϵ��� �̸��� �����Ͽ� ������ ����
		
		ProductInfo pi = new ProductInfo();
		
		pi.setPi_id(request.getParameter("pi_id"));
		pi.setPcb_id(request.getParameter("pcb_id"));
		pi.setPcs_id(request.getParameter("pcs_id"));
		pi.setPi_name(request.getParameter("pi_name"));
		pi.setPi_price(Integer.parseInt(request.getParameter("pi_price")));
		pi.setPi_status(request.getParameter("pi_status"));
		pi.setPi_img1(getUploadFileName(piImg1.getHeader("content-disposition")));
		pi.setPi_stock(1);
		pi.setPi_desc(getUploadFileName(piDesc.getHeader("content-disposition")));
		pi.setPi_date(request.getParameter("pi_date"));
		pi.setAi_idx(1);

		String pai_start = request.getParameter("pai_start");
		String pai_runtime = request.getParameter("pai_runtime");
		
		
		int result = auctionSvc.productInsert(pi, pai_start, pai_runtime);
		
		for (Part part : request.getParts()) {
			if (part.getName().startsWith("pi_img") || part.getName().equals("pi_desc")) {
				String cd =  part.getHeader("content-disposition");
				String uploadName = getUploadFileName(cd);
				if (!uploadName.equals("")) {
				// ���ε��� ������ ������
					uploadFiles += ", " + uploadName;
					part.write(uploadName);
				}
				
			}
		}
		if (!uploadFiles.equals(""))	uploadFiles = uploadFiles.substring(2);
			
		return "redirect:/auction";
	}

	private String getUploadFileName(String cd) {
		String uploadName = null;
		String[] arrContent = cd.split(";");
		
		int fIdx = arrContent[2].indexOf("\"");
		int sIdx = arrContent[2].lastIndexOf("\"");
		
		uploadName = arrContent[2].substring(fIdx + 1, sIdx);
		return uploadName;
	}

	
}