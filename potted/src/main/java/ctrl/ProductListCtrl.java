package ctrl;

import java.io.*;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import config.CtrlConfig.Login;
import config.CtrlConfig.LoginRequired;
import svc.*;
import vo.*;

@Controller
public class ProductListCtrl {
	private ProductListSvc productListSvc;

	public void setProductListSvc(ProductListSvc productListSvc) {
		this.productListSvc = productListSvc;
	}
	
	public PageInfo pageNsearch(HttpServletRequest request, HttpServletResponse response, String kind) throws Exception  {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, spage = 0, psize = 12, bsize = 5, rcnt = 0, pcnt = 0;
		//	페이지 번호  
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		String status = "";
		if (kind.equals("n")) {
			status = " a.pi_status = 'a' ";
		} else {
			status = " a.pi_status <> 'c' ";
		}
		// 검색조건 작업 : 대분류, 소분류, 가격대, 상품명
		String where = " where a.pi_isview = 'y' and " + status + " and a.pi_auction = '" + kind + "' ", schargs = "";
		String pcb = request.getParameter("pcb");	// 대분류 조건
		String pcs = request.getParameter("pcs");	// 소분류 조건
		String sch = request.getParameter("sch");	// 검색조건(가격대p, 상품명n)
		if (pcb != null && !pcb.equals(""))	{
			where += " and left(a.pcs_id, 2) = '" + pcb + "' ";
			schargs += "&pcb=" + pcb;
		}		
		if (pcs != null && !pcs.equals("")) {
			where += " and a.pcs_id = '" + pcs + "' ";
			schargs += "&pcs=" + pcs;
		}			
		if (sch != null && !sch.equals("")) {
		// 검색조건 : &sch=ntest,p100000~200000
			schargs += "&sch=" + sch;
			String[] arrSch = sch.split(",");
			for (int i = 0 ; i < arrSch.length ; i++) {
				char c = arrSch[i].charAt(0);
				if (c == 'n') {			// 상품명 검색일 경우(n검색어)
					where += " and a.pi_name like '%" + arrSch[i].substring(1) + "%' ";	// 검색어만 가져오기 위해 잘라옴
					
				} else if (c == 'p') {	// 가격대 검색일 경우(p시작가~종료가)
					String sp = arrSch[i].substring(1, arrSch[i].indexOf('~'));			// 시작가 / 물결표시 전까지 자름
					if (sp != null && !sp.equals(""))
						where += " and if(a.pi_dc <> 0, a.pi_price * (1 - a.pi_dc), a.pi_price) >= " + sp;

					String ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);		// 종료가
					if (ep != null && !ep.equals(""))
						where += " and if(a.pi_dc <> 0, a.pi_price * (1 - a.pi_dc), a.pi_price) <= " + ep;
				}
			}
		}
		
		String orderBy = " order by ";	// 목록 정렬 순서
		String ob = request.getParameter("ob");	// 정렬조건
		if (ob == null || ob.equals(""))	ob = "a";	// 목록 처음 들어왔을 때는 정렬 조건이 없으므로 임의로 a로 정해둠
		String obargs = "&ob=" + ob; // 정렬조건을 위한 쿼리스트링
		switch (ob) {
		case "a" :	// 등록역순(기본값)(최근 등록이 가장 위에 옴
			orderBy += " a.pi_date desc ";		break;
		case "b" :	// 판매량(인기)순
			orderBy += " a.pi_sale desc ";		break;
		case "c" :	// 이름순
			orderBy += " a.pi_name desc ";		break;
		case "d" :	// 낮은 가격 순
			orderBy += " a.pi_price desc ";		break;
		case "e" :	// 높은 가격 순
			orderBy += " a.pi_price asc ";		break;
		}

		rcnt = productListSvc.getProductCount(where);
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0)	pcnt++;
		spage = (cpage -1) / bsize * bsize +1;
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);		pageInfo.setCpage(cpage);
		pageInfo.setSpage(spage);		pageInfo.setPsize(psize);
		pageInfo.setPcnt(pcnt);			pageInfo.setRcnt(rcnt);
		pageInfo.setSch(sch); 			pageInfo.setOb(ob);
		pageInfo.setSchargs(schargs);	pageInfo.setObargs(obargs);
		pageInfo.setWhere(where);		pageInfo.setOrderby(orderBy);
		if (pcs != null && !pcs.equals("")) {
			pageInfo.setPcs(pcs);
		}
		request.setAttribute("pageInfo", pageInfo);
		return pageInfo;
	}
	
	@GetMapping("/productList")
	public String productList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PageInfo pageInfo = pageNsearch(request, response, "n");
		
		List<ProductInfo> productList = productListSvc.getProductList(pageInfo);
		request.setAttribute("productList", productList);
		
		return "product/productList";
	}
	
	@GetMapping("/productView")
	public String productView(HttpServletRequest request, HttpServletResponse response) throws Exception  {
		request.setCharacterEncoding("utf-8");
		// 1. 조회수 증가 / 2. 보여줄 상품 정보 받아오기 / 3. 해당 상품의 후기 목록 받아오기 / 4. 상품상세보기 화면으로 이동
		
		String piid = request.getParameter("piid");
		
		// 1. 조회수 증가 -> 상품 정보 받아오는 메소드에서 호출함
		
		// 2. 보여줄 상품 정보 받아오기
		ProductInfo productInfo = productListSvc.getProductInfo(piid);
		request.setAttribute("productInfo", productInfo);
		
		List<ProductOptionStock> productOptionStock = productListSvc.getProductOptionStock(piid);
		request.setAttribute("productOptionStock", productOptionStock);
		
		List<ProductOptionBig> productOptionBig = productListSvc.getProductOptionBig();
		request.setAttribute("productOptionBig", productOptionBig);
		
		// 3. 후기 목록 받아오기
		
		// 4. 상품 상세보기 화면으로 이동
		return "product/productView";
	}
	
	@GetMapping("/auctionList")
	public String auctionList(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		PageInfo pageInfo = pageNsearch(request, response, "y");
		List<ProductInfo> productList = productListSvc.getProductList(pageInfo);
		request.setAttribute("productList", productList);		
		return "auction/auctionList";
	}
	@GetMapping("/auctionView")
	public String auctionView(HttpServletRequest request, HttpServletResponse response) throws Exception  {
		request.setCharacterEncoding("utf-8");
		// 1. 조회수 증가 / 2. 보여줄 상품 정보 받아오기 / 3. 해당 상품의 후기 목록 받아오기 / 4. 상품상세보기 화면으로 이동
		
		String piid = request.getParameter("piid");
		
		// 1. 조회수 증가 -> 상품 정보 받아오는 메소드에서 호출함
		
		// 2. 보여줄 상품 정보 받아오기
		ProductInfo productInfo = productListSvc.getProductInfo(piid);
		request.setAttribute("productInfo", productInfo);
		
		List<ProductOptionStock> productOptionStock = productListSvc.getProductOptionStock(piid);
		request.setAttribute("productOptionStock", productOptionStock);
		
		List<ProductOptionBig> productOptionBig = productListSvc.getProductOptionBig();
		request.setAttribute("productOptionBig", productOptionBig);
		
		// 3. 후기 목록 받아오기
		
		// 4. 상품 상세보기 화면으로 이동
		return "auction/auctionView";
	}
	@LoginRequired
	@PostMapping("/bid")
	@ResponseBody
	public String bid(HttpServletRequest request, @Login MemberInfo mi) throws Exception{		
		return "" +productListSvc.setbid(Integer.parseInt(request.getParameter("bidPrice")), request.getParameter("piid"),mi.getMi_id());
	}
}
