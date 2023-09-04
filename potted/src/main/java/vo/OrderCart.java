package vo;

public class OrderCart {
	private String mi_id, pi_id, oc_date, oc_option, pi_img, pi_name;
	private int oc_idx, pos_idx, oc_cnt, oc_price, pi_price, pi_stock, op_price;
	double pi_dc;
	private int first_cnt; 
	
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getOc_date() {
		return oc_date;
	}
	public void setOc_date(String oc_date) {
		this.oc_date = oc_date;
	}
	public int getOc_idx() {
		return oc_idx;
	}
	public void setOc_idx(int oc_idx) {
		this.oc_idx = oc_idx;
	}
	public int getPos_idx() {
		return pos_idx;
	}
	public void setPos_idx(int pos_idx) {
		this.pos_idx = pos_idx;
	}
	public int getOc_cnt() {
		return oc_cnt;
	}
	public void setOc_cnt(int oc_cnt) {
		this.oc_cnt = oc_cnt;
	}
	public String getOc_option() {
		return oc_option;
	}
	public void setOc_option(String oc_option) {
		this.oc_option = oc_option;
	}
	public int getOc_price() {
		return oc_price;
	}
	public void setOc_price(int oc_price) {
		this.oc_price = oc_price;
	}
	public String getPi_img() {
		return pi_img;
	}
	public void setPi_img(String pi_img) {
		this.pi_img = pi_img;
	}
	public String getPi_name() {
		return pi_name;
	}
	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}
	public int getPi_price() {
		return pi_price;
	}
	public void setPi_price(int pi_price) {
		this.pi_price = pi_price;
	}
	public double getPi_dc() {
		return pi_dc;
	}
	public void setPi_dc(double pi_dc) {
		this.pi_dc = pi_dc;
	}
	public int getPi_stock() {
		return pi_stock;
	}
	public void setPi_stock(int pi_stock) {
		this.pi_stock = pi_stock;
	}
	public int getOp_price() {
		return op_price;
	}
	public void setOp_price(int op_price) {
		this.op_price = op_price;
	}
	public int getFirst_cnt() {
		return first_cnt;
	}
	public void setFirst_cnt(int first_cnt) {
		this.first_cnt = first_cnt;
	}
	
	
}
