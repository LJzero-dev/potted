package vo;

import java.util.*;

import org.springframework.jdbc.core.PreparedStatementSetter;

public class OrderInfo {
	private String oi_id, mi_id, oi_name, oi_type, oi_phone, oi_zip, oi_addr1, oi_addr2, oi_memo, oi_payment, oi_status, oi_date, pi_id, pi_kind;
	private int oi_pay, oi_upoint, oi_spoint, oi_apoint;
	private ArrayList<OrderDetail> detailList;
	
	public String getOi_id() {
		return oi_id;
	}
	public void setOi_id(String oi_id) {
		this.oi_id = oi_id;
	}
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getOi_name() {
		return oi_name;
	}
	public void setOi_name(String oi_name) {
		this.oi_name = oi_name;
	}
	public String getOi_type() {
		return oi_type;
	}
	public void setOi_type(String oi_type) {
		this.oi_type = oi_type;
	}
	public String getOi_phone() {
		return oi_phone;
	}
	public void setOi_phone(String oi_phone) {
		this.oi_phone = oi_phone;
	}
	public String getOi_zip() {
		return oi_zip;
	}
	public void setOi_zip(String oi_zip) {
		this.oi_zip = oi_zip;
	}
	public String getOi_addr1() {
		return oi_addr1;
	}
	public void setOi_addr1(String oi_addr1) {
		this.oi_addr1 = oi_addr1;
	}
	public String getOi_addr2() {
		return oi_addr2;
	}
	public void setOi_addr2(String oi_addr2) {
		this.oi_addr2 = oi_addr2;
	}
	public String getOi_memo() {
		return oi_memo;
	}
	public void setOi_memo(String oi_memo) {
		this.oi_memo = oi_memo;
	}
	public String getOi_payment() {
		return oi_payment;
	}
	public void setOi_payment(String oi_payment) {
		this.oi_payment = oi_payment;
	}
	public String getOi_status() {
		return oi_status;
	}
	public void setOi_status(String oi_status) {
		this.oi_status = oi_status;
	}
	public String getOi_date() {
		return oi_date;
	}
	public void setOi_date(String oi_date) {
		this.oi_date = oi_date;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public int getOi_pay() {
		return oi_pay;
	}
	public void setOi_pay(int oi_pay) {
		this.oi_pay = oi_pay;
	}
	public int getOi_upoint() {
		return oi_upoint;
	}
	public void setOi_upoint(int oi_upoint) {
		this.oi_upoint = oi_upoint;
	}
	public int getOi_spoint() {
		return oi_spoint;
	}
	public void setOi_spoint(int oi_spoint) {
		this.oi_spoint = oi_spoint;
	}
	public ArrayList<OrderDetail> getDetailList() {
		return detailList;
	}
	public void setDetailList(ArrayList<OrderDetail> detailList) {
		this.detailList = detailList;
	}
	public int getOi_apoint() {
		return oi_apoint;
	}
	public void setOi_apoint(int oi_apoint) {
		this.oi_apoint = oi_apoint;
	}
	
	
}
