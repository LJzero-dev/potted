package vo;

public class ProductInfo {
	private String pi_id, pcb_id, pcs_id, pi_name, pi_status, pi_img1, pi_img2, pi_img3, pi_desc, pi_special, pi_isview, pi_date, pi_last;
	private int pi_price, pi_cost, pi_read, pi_review, pi_sale, ai_idx, pi_admin;
	private double pi_dc;
	
	// ��ǰ �󼼺��� ȭ�鿡�� ����� �з��� �귣����� ������ ������

	public ProductInfo(String pi_id, String pcb_id, String pcs_id, String pi_name, String pi_status, String pi_img1,
			String pi_img2, String pi_img3, String pi_desc, String pi_special, String pi_isview, String pi_date,
			String pi_last, int pi_price, int pi_cost, int pi_read, int pi_review, int pi_sale, int ai_idx,
			int pi_admin, double pi_dc) {
		this.pi_id = pi_id;			this.pcb_id = pcb_id;			this.pcs_id = pcs_id;		this.pi_name = pi_name;
		this.pi_status = pi_status;	this.pi_img1 = pi_img1;			this.pi_img2 = pi_img2;		this.pi_img3 = pi_img3;
		this.pi_desc = pi_desc;		this.pi_special = pi_special;	this.pi_isview = pi_isview;	this.pi_date = pi_date;
		this.pi_last = pi_last;		this.pi_price = pi_price;		this.pi_cost = pi_cost;		this.pi_read = pi_read;
		this.pi_review = pi_review;	this.pi_sale = pi_sale;			this.ai_idx = ai_idx;		this.pi_admin = pi_admin;
		this.pi_dc = pi_dc;
	}
	
	
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getPcb_id() {
		return pcb_id;
	}
	public void setPcb_id(String pcb_id) {
		this.pcb_id = pcb_id;
	}
	public String getPcs_id() {
		return pcs_id;
	}
	public void setPcs_id(String pcs_id) {
		this.pcs_id = pcs_id;
	}
	public String getPi_name() {
		return pi_name;
	}
	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}
	public String getPi_status() {
		return pi_status;
	}
	public void setPi_status(String pi_status) {
		this.pi_status = pi_status;
	}
	public String getPi_img1() {
		return pi_img1;
	}
	public void setPi_img1(String pi_img1) {
		this.pi_img1 = pi_img1;
	}
	public String getPi_img2() {
		return pi_img2;
	}
	public void setPi_img2(String pi_img2) {
		this.pi_img2 = pi_img2;
	}
	public String getPi_img3() {
		return pi_img3;
	}
	public void setPi_img3(String pi_img3) {
		this.pi_img3 = pi_img3;
	}
	public String getPi_desc() {
		return pi_desc;
	}
	public void setPi_desc(String pi_desc) {
		this.pi_desc = pi_desc;
	}
	public String getPi_special() {
		return pi_special;
	}
	public void setPi_special(String pi_special) {
		this.pi_special = pi_special;
	}
	public String getPi_isview() {
		return pi_isview;
	}
	public void setPi_isview(String pi_isview) {
		this.pi_isview = pi_isview;
	}
	public String getPi_date() {
		return pi_date;
	}
	public void setPi_date(String pi_date) {
		this.pi_date = pi_date;
	}
	public String getPi_last() {
		return pi_last;
	}
	public void setPi_last(String pi_last) {
		this.pi_last = pi_last;
	}
	public int getPi_price() {
		return pi_price;
	}
	public void setPi_price(int pi_price) {
		this.pi_price = pi_price;
	}
	public int getPi_cost() {
		return pi_cost;
	}
	public void setPi_cost(int pi_cost) {
		this.pi_cost = pi_cost;
	}
	public int getPi_read() {
		return pi_read;
	}
	public void setPi_read(int pi_read) {
		this.pi_read = pi_read;
	}
	public int getPi_review() {
		return pi_review;
	}
	public void setPi_review(int pi_review) {
		this.pi_review = pi_review;
	}
	public int getPi_sale() {
		return pi_sale;
	}
	public void setPi_sale(int pi_sale) {
		this.pi_sale = pi_sale;
	}
	public int getAi_idx() {
		return ai_idx;
	}
	public void setAi_idx(int ai_idx) {
		this.ai_idx = ai_idx;
	}
	public int getPi_admin() {
		return pi_admin;
	}
	public void setPi_admin(int pi_admin) {
		this.pi_admin = pi_admin;
	}
	public double getPi_dc() {
		return pi_dc;
	}
	public void setPi_dc(double pi_dc) {
		this.pi_dc = pi_dc;
	}
	
	
}
