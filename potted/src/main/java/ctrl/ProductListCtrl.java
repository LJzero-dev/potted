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
		//	������ ��ȣ  
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		String status = "";
		if (kind.equals("n")) {
			status = " a.pi_status = 'a' ";
		} else {
			status = " a.pi_status <> 'c' ";
		}
		// �˻����� �۾� : ��з�, �Һз�, ���ݴ�, ��ǰ��
		String where = " where a.pi_isview = 'y' and " + status + " and a.pi_auction = '" + kind + "' ", schargs = "";
		String pcb = request.getParameter("pcb");	// ��з� ����
		String pcs = request.getParameter("pcs");	// �Һз� ����
		String sch = request.getParameter("sch");	// �˻�����(���ݴ�p, ��ǰ��n)
		if (pcb != null && !pcb.equals(""))	{
			where += " and left(a.pcs_id, 2) = '" + pcb + "' ";
			schargs += "&pcb=" + pcb;
		}		
		if (pcs != null && !pcs.equals("")) {
			where += " and a.pcs_id = '" + pcs + "' ";
			schargs += "&pcs=" + pcs;
		}			
		if (sch != null && !sch.equals("")) {
		// �˻����� : &sch=ntest,p100000~200000
			schargs += "&sch=" + sch;
			String[] arrSch = sch.split(",");
			for (int i = 0 ; i < arrSch.length ; i++) {
				char c = arrSch[i].charAt(0);
				if (c == 'n') {			// ��ǰ�� �˻��� ���(n�˻���)
					where += " and a.pi_name like '%" + arrSch[i].substring(1) + "%' ";	// �˻�� �������� ���� �߶��
					
				} else if (c == 'p') {	// ���ݴ� �˻��� ���(p���۰�~���ᰡ)
					String sp = arrSch[i].substring(1, arrSch[i].indexOf('~'));			// ���۰� / ����ǥ�� ������ �ڸ�
					if (sp != null && !sp.equals(""))
						where += " and if(a.pi_dc <> 0, a.pi_price * (1 - a.pi_dc), a.pi_price) >= " + sp;

					String ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);		// ���ᰡ
					if (ep != null && !ep.equals(""))
						where += " and if(a.pi_dc <> 0, a.pi_price * (1 - a.pi_dc), a.pi_price) <= " + ep;
				}
			}
		}
		
		String orderBy = " order by ";	// ��� ���� ����
		String ob = request.getParameter("ob");	// ��������
		if (ob == null || ob.equals(""))	ob = "a";	// ��� ó�� ������ ���� ���� ������ �����Ƿ� ���Ƿ� a�� ���ص�
		String obargs = "&ob=" + ob; // ���������� ���� ������Ʈ��
		switch (ob) {
		case "a" :	// ��Ͽ���(�⺻��)(�ֱ� ����� ���� ���� ��
			orderBy += " a.pi_date desc ";		break;
		case "b" :	// �Ǹŷ�(�α�)��
			orderBy += " a.pi_sale desc ";		break;
		case "c" :	// �̸���
			orderBy += " a.pi_name desc ";		break;
		case "d" :	// ���� ���� ��
			orderBy += " a.pi_price desc ";		break;
		case "e" :	// ���� ���� ��
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
		// 1. ��ȸ�� ���� / 2. ������ ��ǰ ���� �޾ƿ��� / 3. �ش� ��ǰ�� �ı� ��� �޾ƿ��� / 4. ��ǰ�󼼺��� ȭ������ �̵�
		
		String piid = request.getParameter("piid");
		
		// 1. ��ȸ�� ���� -> ��ǰ ���� �޾ƿ��� �޼ҵ忡�� ȣ����
		
		// 2. ������ ��ǰ ���� �޾ƿ���
		ProductInfo productInfo = productListSvc.getProductInfo(piid);
		request.setAttribute("productInfo", productInfo);
		
		List<ProductOptionStock> productOptionStock = productListSvc.getProductOptionStock(piid);
		request.setAttribute("productOptionStock", productOptionStock);
		
		List<ProductOptionBig> productOptionBig = productListSvc.getProductOptionBig();
		request.setAttribute("productOptionBig", productOptionBig);
		
		// 3. �ı� ��� �޾ƿ���
		
		// 4. ��ǰ �󼼺��� ȭ������ �̵�
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
		// 1. ��ȸ�� ���� / 2. ������ ��ǰ ���� �޾ƿ��� / 3. �ش� ��ǰ�� �ı� ��� �޾ƿ��� / 4. ��ǰ�󼼺��� ȭ������ �̵�
		
		String piid = request.getParameter("piid");
		
		// 1. ��ȸ�� ���� -> ��ǰ ���� �޾ƿ��� �޼ҵ忡�� ȣ����
		
		// 2. ������ ��ǰ ���� �޾ƿ���
		ProductInfo productInfo = productListSvc.getProductInfo(piid);
		request.setAttribute("productInfo", productInfo);
		
		List<ProductOptionStock> productOptionStock = productListSvc.getProductOptionStock(piid);
		request.setAttribute("productOptionStock", productOptionStock);
		
		List<ProductOptionBig> productOptionBig = productListSvc.getProductOptionBig();
		request.setAttribute("productOptionBig", productOptionBig);
		
		// 3. �ı� ��� �޾ƿ���
		
		// 4. ��ǰ �󼼺��� ȭ������ �̵�
		return "auction/auctionView";
	}
	@LoginRequired
	@PostMapping("/bid")
	@ResponseBody
	public String bid(HttpServletRequest request, @Login MemberInfo mi) throws Exception{		
		return "" +productListSvc.setbid(Integer.parseInt(request.getParameter("bidPrice")), request.getParameter("piid"),mi.getMi_id());
	}
}
