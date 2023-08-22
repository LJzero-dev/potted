package dao;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.*;

public class CartDao {
	private JdbcTemplate jdbc;
	
	public CartDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public int cartInsert(OrderCart oc) {
		String sql = "insert into t_order_cart (mi_id, pi_id, oc_option, oc_cnt, oc_price) values ('" + oc.getMi_id() + "', '" + oc.getPi_id() + "', '" + oc.getOc_option() + "', " + oc.getOc_cnt() + ", " + oc.getOp_price() + ")";
		int result = jdbc.update(sql);
		System.out.println(sql);
		System.out.println(result);
		return result;
	}

	
	public List<OrderCart> getOrderCart(String miid) {
		String sql = "select a.mi_id, a.pi_id, a.oc_date, a.oc_option, a.oc_cnt, a.oc_price, a.oc_idx, b.pi_img1, b.pi_name, b.pi_price, b.pi_dc, b.pi_stock from t_order_cart a, t_product_info b where a.pi_id = b.pi_id and a.mi_id = '" + miid + "' ";
		List<OrderCart> orderCart = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			OrderCart oc = new OrderCart();
			oc.setMi_id(miid);
			oc.setOc_idx(rs.getInt("oc_idx"));
			oc.setPi_id(rs.getString("pi_id"));
			oc.setOc_date(rs.getString("oc_date"));
			oc.setOc_option(rs.getString("oc_option"));
			oc.setOc_cnt(rs.getInt("oc_cnt"));
			oc.setOp_price(rs.getInt("oc_price"));
			oc.setPi_img(rs.getString("pi_img1"));
			oc.setPi_name(rs.getString("pi_name"));
			oc.setPi_price(rs.getInt("pi_price"));
			oc.setPi_dc(rs.getDouble("pi_dc"));
			oc.setPi_stock(rs.getInt("pi_stock"));
			return oc;
			
		});

		return orderCart;
	}

	public int cartDel(int ocidx, String miid) {
		String sql = "delete from t_order_cart where oc_idx = " + ocidx + " and mi_id = '" + miid + "'";
		int result = jdbc.update(sql);
		return result;
	}

	public int cartUp(int ocidx, String miid, int cnt, String num, int stock) {
		String set = "";
		if (cnt <= 1 && num.equals("-")) {
			set = " oc_cnt = oc_cnt ";
		} else if (cnt == stock && num.equals("+")) {
			set = " oc_cnt = oc_cnt ";
		} else {
			set = " oc_cnt = oc_cnt " + num + " 1 ";
		}
		String sql = "update t_order_cart set " + set + " where oc_idx = " + ocidx + " and mi_id = '" + miid + "'";
		int result = jdbc.update(sql);
		System.out.println(sql);
		System.out.println(result);
		return result;
	}
	
}
