package index;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class IndexCtrl {	// ������ ��ӹ��� �ʾƵ� @Controller�� ���� �������� ��޹���
	@GetMapping("/index")
	// Get ������� test�� ��û�� ��� ó���� �޼ҵ带 ����
	// Post ����� ��û�� @PostMapping �ֳ����̼� ���
	// "/test" ��η� ���� ��û�� ó���� �޼ҵ�� test() �޼ҵ带 ����
	// get�� post �� �ٸ� �����Ϸ��� @RequestMapping("���")�� ���
	// @RequestMapping[("���", method=RequestMethod.GET or RequestMethod.POST)]
	public String test(Model model, @RequestParam(value="name", defaultValue="aaa", required=false) String name) {
	// Model : ��Ʈ�ѷ��� ó�� ����� model�� ��Ƽ� �信 ����
	// @RequestParam : ��û  url�� �Ķ���� ���� �޼ҵ��� �Ķ���ͷ� ����
	// defaultValue : name�Ű������� ���� ���� ��� �� �⺻��. ������ null�� ��
	// required : �ʼ����η� true�� ��� name�Ķ���Ͱ� ������ 400 ���� �߻��ϸ� �⺻���� false
		
		model.addAttribute("greeting", "�ȳ��ϼ���, " + name);	// ���� �Ӽ����� ���� greeting�̶�� �̸�����, 
		return "index";
		// ��Ʈ�ѷ��� ó�� ����� ������ �� �̸����� "test"�� ����ϰڴٴ� �ǹ� - test.jsp
	}
}