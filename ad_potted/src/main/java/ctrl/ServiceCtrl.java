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
public class ServiceCtrl {
	private NoticeSvc noticeSvc;

	public void setNoticeSvc(NoticeSvc noticeSvc) {
		this.noticeSvc = noticeSvc;
	}
	@GetMapping("/service")
	public String noticeList(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 5, num = 0;
		// ����������, ��/��������������, ����������, �Խñ� ��, �������� ũ��, ����� ũ��, ��ȣ���� ������ ����
		
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String where = " where nl_isview = 'y' ";
		String args = "", schargs = "";
		if (schtype == null || keyword == null) {
			schtype = "";	keyword = "";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			if (schtype.equals("tc")) {	// �˻� ������ ���� + ������ ���
				where += " and (nl_title like '%" + keyword + "%' or nl_content like '%" + keyword + "%') ";
			} else {
				where += " and nl_" + schtype + " like '%" + keyword + "%' ";
			}
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
		args = "&cpage=" + cpage + schargs;
		
		rcnt = noticeSvc.getNoticeListCount(where);
		// �˻��� �Խñ��� �� ������ �Խñ� �Ϸù�ȣ ��°� ��ü ������ �� ����� ���� ��
		List<NoticeList> noticeList = noticeSvc.getNoticeList(where, cpage, psize);
		
		
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
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("si", si);

		return "service/noticeList";
	}
	
	@GetMapping("/noticeView")
	public String noticeView(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int nlidx = Integer.parseInt(request.getParameter("nlidx"));
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String args = "?cpage=" + cpage;
		
		if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			args += "&schtype=" + schtype + "&keyword=" + keyword;
		}
		
		NoticeList nl = noticeSvc.getNoticeInfo(nlidx);
		model.addAttribute("nl", nl);
		model.addAttribute("args", args);		
		
		return "service/noticeView";
	}
}
