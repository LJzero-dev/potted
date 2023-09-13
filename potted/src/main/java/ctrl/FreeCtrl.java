package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import config.CtrlConfig.LoginRequired;

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
	
	@GetMapping("/freeView")
	public String freeView(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int flidx = Integer.parseInt(request.getParameter("flidx"));
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String args = "?cpage=" + cpage;
		
		if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			args += "&schtype=" + schtype + "&keyword=" + keyword;
		}
		
		FreeList fl = freeSvc.getFreeInfo(flidx);
		List<ReplyList> replyList = freeSvc.getReplyList(flidx);
		
		model.addAttribute("fl", fl);
		model.addAttribute("replyList", replyList);
		model.addAttribute("args", args);
		
		request.setAttribute("replyList", replyList);
		
		return "free/freeView";
	}
	
	@LoginRequired
	@GetMapping("/freeFormIn")
	public String freeFormIn() {
		return "free/freeFormIn";
	}

	@PostMapping("/freeProcIn")
	public String freeProcIn(MultipartFile[] uploadFile, HttpServletRequest request) throws Exception {
	// �޾ƿ��� file��Ʈ���� �̸��� �Ű������� �̸��� ���ƾ� ��
		String uploadPath = "E:/esm/project/potted/src/main/webapp/resources/images/free";
		String files = "";	// for������������  ""�� �ȳ����� null�̵Ǽ�
		FreeList fl = new FreeList();
		for (MultipartFile file : uploadFile) {
			File saveFile = new File(uploadPath, file.getOriginalFilename());
			// ������ ���� ��ü����
			try {
				file.transferTo(saveFile);
				files += "," + file.getOriginalFilename();
				fl.setFl_img1(file.getOriginalFilename());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		String title = request.getParameter("fl_title");
		String content = request.getParameter("fl_content");
		fl.setFl_title(title);
		fl.setFl_content(content);

		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		fl.setFl_writer(mi.getMi_name());
		fl.setMi_id(mi.getMi_id());

		int result = freeSvc.freeInsert(fl);

		return "redirect:/freeView?cpage=1&flidx=" + result;
										// �տ� ,�� ¥���� ���� substring
	}
	
	@PostMapping("/replyIn")
	public void replyeInProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String fr_content = request.getParameter("rcon").trim();
		int flidx = Integer.parseInt(request.getParameter("flidx"));
		
		int result = freeSvc.replyInsert(miid, fr_content, flidx);

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
	}
	
	
	@GetMapping("/replyDel")
	public String replyDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int fridx = Integer.parseInt(request.getParameter("fridx"));
		int flidx = Integer.parseInt(request.getParameter("flidx"));
		
		int result = freeSvc.replyDel(fridx, flidx);
		if (result < 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('정말 삭제하시겠습니까?');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		return "redirect:/freeView?cpage=1&flidx=" + flidx;
	}
	
	@LoginRequired
	@GetMapping("/flDel")
	public String flDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("flidx"));
		
		int result = freeSvc.flDel(idx);
		if (result != 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�Խñ� ������ �����߽��ϴ�.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		return "redirect:/freeList";
	}
	
}

