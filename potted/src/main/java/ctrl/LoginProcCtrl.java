package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/loginProc")
public class LoginProcCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public LoginProcCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim().toLowerCase();
		String pwd = request.getParameter("pwd").trim();
		String url = request.getParameter("url").replace('~', '&');
		
		LoginProcSvc loginProcSvc = new LoginProcSvc();
		MemberInfo loginInfo = loginProcSvc.getLoginInfo(uid, pwd);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		if (loginInfo != null) {	// �α��� ������
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
			
			out.println("location.replace('" + url + "');");
		} else {	// �α��� ���н�
			out.println("alert('���̵�� ��й�ȣ�� Ȯ���ϼ���.');");
			out.println("history.back();");
		}
		out.println("</script>");
	}
}
