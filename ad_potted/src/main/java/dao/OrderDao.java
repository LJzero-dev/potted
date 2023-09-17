package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vo.*;

public class OrderDao {
	private JdbcTemplate jdbc;

	public OrderDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<OrderInfo> getOrderList(int cpage, int psize) {
		String sql = "select mi_id, oi_id, oi_name, oi_type, oi_phone, oi_zip, oi_addr1, oi_addr2, oi_memo, oi_payment, oi_pay, oi_upoint, oi_apoint, oi_status, " + 
				"concat(mid(oi_date, 3, 2), '/', mid(oi_date, 6, 2), '/', mid(oi_date, 9, 2), ' ', mid(oi_date, 12, 5)) odate, oi_cnt, b.pi_id, b.pi_name " + 
				"from t_order_info a, t_product_info b where a.pi_id = b.pi_id and oi_type = 'a' order by oi_date desc limit " + ((cpage - 1) * psize) + ", " + psize;
		List<OrderInfo> orderList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			OrderInfo oi = new OrderInfo();
			oi.setMi_id(rs.getString("mi_id"));
			oi.setOi_id(rs.getString("oi_id"));
			oi.setOi_name(rs.getString("oi_name"));
			oi.setOi_type(rs.getString("oi_type"));
			oi.setOi_phone(rs.getString("oi_phone"));
			oi.setOi_zip(rs.getString("oi_zip"));
			oi.setOi_addr1(rs.getString("oi_addr1"));
			oi.setOi_addr2(rs.getString("oi_addr2"));
			oi.setOi_memo(rs.getString("oi_memo"));
			oi.setOi_payment(rs.getString("oi_payment"));
			oi.setOi_pay(rs.getInt("oi_pay"));
			oi.setOi_upoint(rs.getInt("oi_upoint"));
			oi.setOi_apoint(rs.getInt("oi_apoint"));
			oi.setOi_status(rs.getString("oi_status"));
			oi.setOi_date(rs.getString("odate"));
			oi.setPi_name(rs.getString("pi_name"));
			oi.setOi_cnt(rs.getInt("oi_cnt"));
			oi.setPi_id(rs.getString("pi_id"));
			
			return oi;
		});
		return orderList;
	}

	public int getOrderListCount() {
		String sql = "select count(*) from t_order_info where oi_type = 'a'";
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

	public OrderInfo getOrderInfo(String oiid) {
		String sql = "select a.mi_id, a.oi_id, a.oi_name, a.oi_phone, a.oi_zip, a.oi_addr1, a.oi_addr2, a.oi_memo, a.oi_pay, a.oi_status, b.od_name, b.od_option, "
				+ "concat(mid(a.oi_date, 3, 2), '/', mid(a.oi_date, 6, 2), '/', mid(a.oi_date, 9, 2), ' ', mid(a.oi_date, 12, 5)) wdate "
				+ "from t_order_info a join t_order_detail b on a.oi_id = b.oi_id where a.oi_id = '" + oiid + "' ";
		OrderInfo orderInfo = jdbc.queryForObject(sql, new RowMapper<OrderInfo>() {
			@Override
			public OrderInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				OrderInfo oi = new OrderInfo();
				oi.setMi_id(rs.getString("mi_id"));
				oi.setOi_id(oiid);
				oi.setOi_name(rs.getString("oi_name"));
				oi.setOi_phone(rs.getString("oi_phone"));						
				oi.setOi_zip(rs.getString("oi_zip"));
				oi.setOi_addr1(rs.getString("oi_addr1"));
				oi.setOi_addr2(rs.getString("oi_addr2"));
				oi.setOi_memo(rs.getString("oi_memo"));
				oi.setOi_pay(rs.getInt("oi_pay"));
				oi.setOi_status(rs.getString("oi_status"));
				oi.setOd_name(rs.getString("od_name"));
				oi.setOd_option(rs.getString("od_option"));
				
				return oi;
			}
		});
		
		return orderInfo;
	}
	
	public int getOrderStatus(String oi_status, String oiid) {
		 String sql = "update t_order_info set oi_status = ? where oi_id = ?";
		    int result = jdbc.update(sql, oi_status, oiid);

		    return result;
	}

}
