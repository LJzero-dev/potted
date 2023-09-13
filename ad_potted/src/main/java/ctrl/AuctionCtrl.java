package ctrl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;

import svc.AuctionSvc;
import vo.PageInfo;
import vo.ProductCtgrBig;
import vo.ProductCtgrSmall;
import vo.ProductInfo;
import vo.ProductOptionStock;

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

		request.setAttribute("bigList", bigList);
		request.setAttribute("smallList", smallList);
		
		return "auction/auctionIn";
	}
	
	@PostMapping("/auctionProcIn")
	public String productProcIn(HttpServletRequest request, @RequestPart("pi_img1") Part piImg1,
	        @RequestPart("pi_img2") Part piImg2, @RequestPart("pi_img3") Part piImg3, @RequestPart("pi_desc") Part piDesc) throws Exception {
		request.setCharacterEncoding("utf-8");
		String uploadFiles = "";	// ���ε��� ���ϵ��� �̸��� �����Ͽ� ������ ����
		
		ProductInfo pi = new ProductInfo();
		ProductOptionStock po = new ProductOptionStock();
		
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
		
		int result = auctionSvc.productInsert(pi, po);
		
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
	
	@GetMapping("/auctionUp")
	public String productUp(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		 String piid = request.getParameter("piid");
	        ProductInfo pi = auctionSvc.getProductInfo(piid);
	        List<ProductOptionStock> poList = auctionSvc.getProductOptionStock(piid);
	        ArrayList<ProductCtgrBig> bigList = auctionSvc.getBigList();
	        ArrayList<ProductCtgrSmall> smallList = auctionSvc.getSmallList();
	        
	        
	        String pi_img1 = pi.getPi_img1();
	        String pi_img2 = pi.getPi_img2();
	        String pi_img3 = pi.getPi_img3();
	        String pcb_id = pi.getPcb_id();
	        String pcs_id = pi.getPcs_id();


	        Set<String> PobIds = new HashSet<>();
	        for (ProductOptionStock po : poList) {
	            PobIds.add(po.getPob_id());
	        }
	        
	        Set<String> PosIds = new HashSet<>();
	        for (ProductOptionStock po : poList) {
	            PosIds.add(po.getPos_id());
	        }
	        

	        request.setAttribute("bigList", bigList);
	        request.setAttribute("smallList", smallList);
	        model.addAttribute("pi", pi);
	        model.addAttribute("pi_img1", pi_img1);
	        model.addAttribute("pi_img2", pi_img2);
	        model.addAttribute("pi_img3", pi_img3);
	        model.addAttribute("pcb_id", pcb_id);
	        model.addAttribute("pcs_id", pcs_id);
	        model.addAttribute("PobIds", PobIds);
	        model.addAttribute("PosIds", PosIds);
		
		return "auction/auctionUp";
	}

	
}