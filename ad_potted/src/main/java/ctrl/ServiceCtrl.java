package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
	@GetMapping("/noticeList")
	public String noticeList(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 5, num = 0;
		// 현재페이지, 현/마지막페이지수, 시작페이지, 게시글 수, 한페이지 크기, 블록의 크기, 번호등을 저장할 변수
		
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
			if (schtype.equals("tc")) {	// 검색 조건이 제목 + 내용일 경우
				where += " and (nl_title like '%" + keyword + "%' or nl_content like '%" + keyword + "%') ";
			} else {
				where += " and nl_" + schtype + " like '%" + keyword + "%' ";
			}
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
		args = "&cpage=" + cpage + schargs;
		
		rcnt = noticeSvc.getNoticeListCount(where);
		// 검색된 게시글의 총 개수로 게시글 일련번호 출력과 전체 페이지 수 계산을 위한 값
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
	
	@GetMapping("/noticeFormIn")
	public String noticeFormIn() {
		return "service/noticeFormIn";
	}
	
	@PostMapping("/noticeProcIn")
	public String noticeProcIn(HttpServletRequest request) throws Exception {
		NoticeList nl = new NoticeList();

		String title = request.getParameter("nl_title");
		String content = request.getParameter("nl_content");
		nl.setNl_title(title);
		nl.setNl_content(content);

		HttpSession session = request.getSession();
		AdminInfo ai = (AdminInfo)session.getAttribute("loginInfo");
		nl.setAi_idx(ai.getAi_idx());// 현재 로그인한 어드민 idx를 noticeList에 넣음

		int result = noticeSvc.noticeInsert(nl);

		return "redirect:/noticeView?cpage=1&nlidx=" + result;
										// 앞에 ,를 짜르기 위한 substring
	}
	
	@GetMapping("/noticeDel")
	public String noticeDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		int result = noticeSvc.noticeDel(idx);
		if (result < 1) {
			response.setContentType("text/html; charset=utf-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('게시글 삭제에 실패했습니다.');");
	         out.println("history.back();");
	         out.println("</script>");
	         out.close();
		}
		
		return "redirect:/noticeList";
	}
	
}
