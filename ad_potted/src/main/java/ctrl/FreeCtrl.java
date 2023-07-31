package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import java.util.*;
import java.net.*;
import org.springframework.ui.*;
import svc.*;
import vo.*;

@Controller
public class FreeCtrl {
	private FreeSvc freeSvc;

	public void setFreeSvc(FreeSvc freeSvc) {
		this.freeSvc = freeSvc;
	}
	
	@GetMapping("/freeList")
	public String freeList(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 5, num = 0;
		// ����������, ��/��������������, ����������, �Խñ� ��, �������� ũ��, ����� ũ��, ��ȣ���� ������ ����
		
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String where = " where fl_isview = 'y' ";
		String args = "", schargs = "";
		if (schtype == null || keyword == null) {
			schtype = "";	keyword = "";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			if (schtype.equals("tc")) {	// �˻� ������ ���� + ������ ���
				where += " and (fl_title like '%" + keyword + "%' or fl_content like '%" + keyword + "%') ";
			} else {
				where += " and fl_" + schtype + " like '%" + keyword + "%' ";
			}
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
		args = "&cpage=" + cpage + schargs;
		
		rcnt = freeSvc.getFreeListCount(where);
		// �˻��� �Խñ��� �� ������ �Խñ� �Ϸù�ȣ ��°� ��ü ������ �� ����� ���� ��
		List<FreeList> freeList = freeSvc.getFreeList(where, cpage, psize);
		
		
		pcnt = rcnt / psize;	if (rcnt % psize > 0)	pcnt++;
		spage = (cpage -1) / bsize * bsize + 1;
		num = rcnt - (psize * (cpage - 1)); 
		SpageInfo si = new SpageInfo();
		si.setBsize(bsize);		si.setCpage(cpage);
		si.setPcnt(pcnt);		si.setPsize(psize);
		si.setRcnt(rcnt);		si.setSpage(spage);
		si.setNum(num);			si.setSchtype(schtype);
		si.setKeyword(keyword);	si.setArgs(args);
		si.setSchtype(schtype);
		
		model.addAttribute("freeList", freeList);
		model.addAttribute("si", si);

		return "free/freeList";
	}
	
}

