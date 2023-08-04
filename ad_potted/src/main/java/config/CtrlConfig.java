package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import ctrl.AuctionCtrl;
import ctrl.FreeCtrl;
import ctrl.IndexCtrl;
import ctrl.LoginCtrl;
import ctrl.LogoutCtrl;
import ctrl.MemberInfoCtrl;
import ctrl.ProductCtrl;
import ctrl.SalesSlipCtrl;
import ctrl.ScheduleCtrl;
import ctrl.ServiceCtrl;
import ctrl.SetbannerCtrl;
import svc.AuctionSvc;
import svc.FreeSvc;
import svc.LoginSvc;
import svc.MemberSvc;
import svc.NoticeSvc;
import svc.ProductInSvc;
import svc.ScheduleSvc;

@Configuration
public class CtrlConfig {
// ������ ���� ��Ʈ�ѷ����� ������ ������ ��Ͻ�Ű�� Ŭ����
	@Autowired // �ʿ��� �� �˾Ƽ� ���� ��
	private ProductInSvc productInSvc;
	
	@Autowired
	private LoginSvc loginSvc;
	
	@Autowired
	private MemberSvc memberSvc;
	
	@Autowired
	private NoticeSvc noticeSvc;
	
	@Autowired
	private FreeSvc freeSvc;

	@Autowired	// �ʿ��Ҷ� �˾Ƽ� ���ܾ�
	private ScheduleSvc scheduleSvc;
	
	@Autowired
	private AuctionSvc auctionSvc;
	
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
	
	@Bean
	public SetbannerCtrl setbannerCtrl() {
		return new SetbannerCtrl();
	}
	@Bean
	public AuctionCtrl auctionCtrl() {
		AuctionCtrl auctionCtrl = new AuctionCtrl();
		auctionCtrl.setAuctionSvc(auctionSvc);
		return auctionCtrl;
	}	
}
