package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import ctrl.*;
import svc.*;

@Configuration
public class CtrlConfig {
// 구현해 놓은 컨트롤러들을 스프링 빈으로 등록시키는 클래스
	@Autowired // 필요할 때 알아서 땡겨 씀
	private ProductInSvc productInSvc;
	
	@Autowired
	private LoginSvc loginSvc;
	
	@Autowired
	private MemberSvc memberSvc;
	
	@Autowired
	private NoticeSvc noticeSvc;
	
	@Autowired
	private FreeSvc freeSvc;

	@Autowired	// 필요할때 알아서 땡겨씀
	private ScheduleSvc scheduleSvc;
	
	@Bean
	public ProductCtrl productCtrl() {
		ProductCtrl productCtrl = new ProductCtrl();
		productCtrl.setProductInSvc(productInSvc);
		return productCtrl; 
	}
	@Bean
	public LoginCtrl loginCtrl() {
		LoginCtrl loginCtrl = new LoginCtrl();
		loginCtrl.setLoginSvc(loginSvc);
		return loginCtrl; 
	}
	@Bean
	public MemberInfoCtrl MemberInfoCtrl() {
		MemberInfoCtrl memberInfoCtrl = new MemberInfoCtrl();
		memberInfoCtrl.setMemberSvc(memberSvc);
		return memberInfoCtrl;
	}
	
	@Bean
	public ServiceCtrl serviceCtrl() {
		ServiceCtrl serviceCtrl = new ServiceCtrl();
		serviceCtrl.setNoticeSvc(noticeSvc);
		return serviceCtrl;
	}
	
	@Bean
	public FreeCtrl freeCtrl() {
		FreeCtrl freeCtrl = new FreeCtrl();
		freeCtrl.setFreeSvc(freeSvc);
		return freeCtrl;
	}
	
	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}
	
	@Bean
	public LogoutCtrl logoutCtrl() {
		return new LogoutCtrl();
	}
	
	@Bean
	public SalesSlipCtrl salesSlipCtrl() {
		return new SalesSlipCtrl();
	}
	
	@Bean
	public ScheduleCtrl scheduleCtrl() {
		ScheduleCtrl scheduleCtrl = new ScheduleCtrl();
		scheduleCtrl.setScheduleSvc(scheduleSvc);
		return scheduleCtrl;
	}
}
