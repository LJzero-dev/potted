package ctrl;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import svc.ProductInSvc;
import vo.PageInfo;
import vo.ProductCtgrBig;
import vo.ProductCtgrSmall;
import vo.ProductInfo;
import vo.ProductOptionInfo;

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
		//	������ ��ȣ  
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
		case "b" :	// �Ǹŷ�(�α�)��
			orderBy += " pi_sale desc ";		break;
		case "c" :	// �̸���
			orderBy += " pi_name desc ";		break;
		case "d" :	// ���� ���� ��
			orderBy += " pi_price desc ";		break;
		case "e" :	// ���� ���� ��
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
	public String productProcIn(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		ProductInfo pi = new ProductInfo();
		ProductOptionInfo po = new ProductOptionInfo();
		
		System.out.println(request.getParameter("pcs_id"));
		
		pi.setPi_id(request.getParameter("pi_id"));
		pi.setPcb_id(request.getParameter("pcb_id"));
		pi.setPcs_id(request.getParameter("pcs_id"));
		pi.setPi_name(request.getParameter("pi_name"));
		pi.setPi_price(Integer.parseInt(request.getParameter("pi_price")));
		pi.setPi_cost(Integer.parseInt(request.getParameter("pi_cost")));
		pi.setPi_dc (Integer.parseInt(request.getParameter("pi_dc")));
		pi.setPi_status(request.getParameter("pi_status"));
		pi.setPi_img1(request.getParameter("pi_img1"));
		pi.setPi_img2(request.getParameter("pi_img2"));
		pi.setPi_img3(request.getParameter("pi_img3"));
		pi.setPi_stock(Integer.parseInt(request.getParameter("pi_stock")));
		pi.setPi_desc(request.getParameter("pi_desc"));
		pi.setPi_date(request.getParameter("pi_date"));
		pi.setAi_idx(1);
	
		po.setPos_id(request.getParameter("pos_id"));
		po.setPob_id(request.getParameter("pob_id"));
		
		int result = productInSvc.productInsert(pi, po);
			
		return "redirect:/productList";
	}
	
}
