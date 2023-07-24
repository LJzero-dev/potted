package ctrl;

import java.io.*;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class ProductListCtrl {
	private ProductListSvc productListSvc;

	public void setProductListSvc(ProductListSvc productListSvc) {
		this.productListSvc = productListSvc;
	}
	
	@GetMapping("/productList")
	public String productList(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
/*		int cpage = 1, spage = 0, psize = 12, bsize = 10, rcnt = 0, pcnt = 0;
		//	������ ��ȣ  
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		// �˻����� �۾� : ��з�, �Һз�, ���ݴ�, ��ǰ��, �귣��
		String where = "", schargs = "";
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
		// �˻����� : &sch=ntest,bB1:B2:B3,p100000~200000
			schargs += "&sch=" + sch;
			String[] arrSch = sch.split(",");
			for (int i = 0 ; i < arrSch.length ; i++) {
				char c = arrSch[i].charAt(0);
				if (c == 'n') {			// ��ǰ�� �˻��� ���(n�˻���)
					where += " and a.pi_name like '%" + arrSch[i].substring(1) + "%' ";	// �˻�� �������� ���� �߶��
					
				} else if (c == 'p') {	// ���ݴ� �˻��� ���(p���۰�~���ᰡ)
					String sp = arrSch[i].substring(1, arrSch[i].indexOf('~'));			// ���۰� / ����ǥ�� ������ �ڸ�
					if (sp != null && !sp.equals(""))
						where += " and a.pi_price >= " + sp;

					String ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);		// ���ᰡ
					if (ep != null && !ep.equals(""))
						where += " and a.pi_price <= " + ep;
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
		case "c" :	// ���� ���� ��
			orderBy += " a.pi_price asc ";		break;
		case "d" :	// ���� ���� ��
			orderBy += " a.pi_price desc ";		break;
		case "e" :	// ���� ���� ��
			orderBy += " a.pi_score desc ";		break;
		case "f" :	// ���� ���� ��
			orderBy += " a.pi_review desc ";	break;
		case "g" :	// ��ȸ�� ���� ��
			orderBy += " a.pi_read desc ";		break;
		}
*/
		List<ProductInfo> productList = productListSvc.getProductList();
		request.setAttribute("productList", productList);
		
		return "product/productList";
	}
	
	


}
