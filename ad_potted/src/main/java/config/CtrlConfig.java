package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import ctrl.*;
import svc.*;

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
}
