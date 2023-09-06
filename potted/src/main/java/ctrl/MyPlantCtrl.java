package ctrl;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import config.CtrlConfig.Login;
import config.CtrlConfig.LoginRequired;
import svc.MyPlantSvc;
import vo.MemberInfo;
import vo.MemberTree;

@Controller
public class MyPlantCtrl {
	private MyPlantSvc myPlantSvc;

	public void setMyPlantSvc(MyPlantSvc myPlantSvc) {
		this.myPlantSvc = myPlantSvc;
	}
	
	@LoginRequired
	@GetMapping("/myPlant")
	public String myPlant(@Login MemberInfo mi, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		if (myPlantSvc.getMyPlant(mi.getMi_id()) != null && myPlantSvc.getMyPlant(mi.getMi_id()).getMt_hp() <= 5000) {
			request.setAttribute("mt", myPlantSvc.getMyPlant(mi.getMi_id()));
			request.setAttribute("mp", mi.getMi_point());
			request.setAttribute("result", "false");
			return "myPlant/plant_finish";
		} else if(myPlantSvc.getMyPlant(mi.getMi_id()) != null && myPlantSvc.getMyPlant(mi.getMi_id()).getMt_count() >= (myPlantSvc.getMyPlant(mi.getMi_id()).getMt_grade() == 4 ? 3 : myPlantSvc.getMyPlant(mi.getMi_id()).getMt_grade() == 2 ? 7 : 14)) {
			request.setAttribute("mt", myPlantSvc.getMyPlant(mi.getMi_id()));
			request.setAttribute("mp", mi.getMi_point());
			request.setAttribute("result", "true");
			return "myPlant/plant_finish";
		}
		
		if (myPlantSvc.getMtPlant(mi.getMi_id())) {			
			request.setAttribute("mt", myPlantSvc.getMyPlant(mi.getMi_id()));			
			return "/myPlant/plant_grow_up";
		}
		return "/myPlant/plant_select";
	}
	@LoginRequired
	@GetMapping("/plantSelect")
	public String plant_select(HttpServletRequest request, HttpServletResponse response, @Login MemberInfo mi) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (myPlantSvc.setMyPlant(mi.getMi_id(),request.getParameter("plant")) == 1) {
			out.println("<script>");
			out.println("location.href='myPlant'");
			out.println("</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('�Ĺ� ���ÿ� �����ϼ̽��ϴ�.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		return "/index";
	}
	@LoginRequired
	@PostMapping("/plantWatering")
	@ResponseBody
	public void plantWatering(@Login MemberInfo mi) {
		myPlantSvc.wattering(mi.getMi_id());
	}
	@LoginRequired
	@PostMapping("/plantNutrients")
	@ResponseBody
	public void plantNutrients(@Login MemberInfo mi) {
		myPlantSvc.plantNutrients(mi.getMi_id());
	}	
	@LoginRequired
	@PostMapping("/plnatFinish")
	public String plnatFinish(HttpServletRequest request,HttpServletResponse response, @Login MemberInfo mi) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (myPlantSvc.plantFinish((request.getParameter("grade") == null || request.getParameter("grade").equals("")) ? 0 : Integer.valueOf(request.getParameter("grade")), Integer.valueOf(request.getParameter("addPoint")) , mi.getMi_id()) == 3) {
		out.println("<script>");
		out.println("location.href='myPlant'");
		out.println("</script>");
		out.close();
		} else {
			out.println("<script>");
			out.println("alert('��Ȯ�� �����ϼ̽��ϴ�.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		return "/index";
	}
	
}
