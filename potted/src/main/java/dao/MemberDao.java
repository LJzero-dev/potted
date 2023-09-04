package dao;

import java.sql.ResultSet;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import vo.*;

public class MemberDao {
	private JdbcTemplate jdbc;

	public MemberDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<MemberPoint> getMemberPoint(String miid, int cpage, int psize) {
		// 회원 포인트를 List<MemberPoint>형으로 리턴
		String sql = "select mp_idx, mp_point, mp_desc, mp_detail, concat(mid(mp_date, 3, 2), '/', mid(mp_date, 6, 2), '/', mid(mp_date, 9, 2), ' ', mid(mp_date, 12, 5)) wdate from t_member_point " + 
		" where mi_id = '" + miid + "' order by mp_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
		List<MemberPoint> memberPoint = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			MemberPoint mp = new MemberPoint();
			mp.setMp_idx(rs.getInt("mp_idx"));
			mp.setMp_point(rs.getInt("mp_point"));
			mp.setMp_desc(rs.getString("mp_desc"));
			mp.setMp_detail(rs.getString("mp_detail"));
			mp.setMp_date(rs.getString("wdate"));
			return mp;
		});
		return memberPoint;
	}

	public int getMemberPointListCount(String miid) {
		String sql = "select count(*) from t_member_point where mi_id ='" + miid + "'";
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

	public List<OrderInfo> getOrderList(String miid, int cpage, int psize) {
		String sql = "select oi_id, oi_name, oi_type, oi_phone, oi_zip, oi_addr1, oi_addr2, oi_memo, oi_payment, oi_pay, oi_upoint, oi_apoint, oi_status, " + 
	"concat(mid(oi_date, 3, 2), '/', mid(oi_date, 6, 2), '/', mid(oi_date, 9, 2), ' ', mid(oi_date, 12, 5)) odate, oi_cnt, b.pi_id, b.pi_name " + 
	"from t_order_info a, t_product_info b where a.pi_id = b.pi_id and mi_id = '" + miid + "' order by oi_date desc limit " + ((cpage - 1) * psize) + ", " + psize;
		List<OrderInfo> orderList = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			OrderInfo oi = new OrderInfo();
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

	public int getOrderListCount(String miid) {
		String sql = "select count(*) from t_order_info where mi_id = '" + miid + "'";
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

	public int chkDupId(String uid) {
		String sql = "select count(*) from t_member_info where mi_id = '" + uid + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

}
