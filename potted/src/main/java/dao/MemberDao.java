package dao;

import java.sql.*;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.jdbc.core.*;

import vo.*;

public class MemberDao {
	private JdbcTemplate jdbc;

	public MemberDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<MemberPoint> getMemberPoint(String miid, int cpage, int psize) {
		// ȸ�� ����Ʈ�� List<MemberPoint>������ ����
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
	"from t_order_info a, t_product_info b where a.pi_id = b.pi_id and oi_type = 'a' and mi_id = '" + miid + "' order by oi_date desc limit " + ((cpage - 1) * psize) + ", " + psize;
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
		String sql = "select count(*) from t_order_info where mi_id = '" + miid + "' and oi_type = 'a'";
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

	public int chkDupId(String uid) {
		String sql = "select count(*) from t_member_info where mi_id = '" + uid + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

	public List<OrderInfo> getAuctionOrderList(String miid, int cpage, int psize) {
		String sql = "select oi_id, oi_name, oi_type, oi_phone, oi_zip, oi_addr1, oi_addr2, oi_memo, oi_payment, oi_pay, oi_upoint, oi_apoint, oi_status, " + 
		"concat(mid(oi_date, 3, 2), '/', mid(oi_date, 6, 2), '/', mid(oi_date, 9, 2), ' ', mid(oi_date, 12, 5)) odate, oi_cnt, b.pi_id, b.pi_name " + 
		"from t_order_info a, t_product_info b where a.pi_id = b.pi_id and oi_type = 'b' and mi_id = '" + miid + "' order by oi_date desc limit " + ((cpage - 1) * psize) + ", " + psize;
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

	public int getAuctionOrderListCount(String miid) {
		String sql = "select count(*) from t_order_info where mi_id = '" + miid + "' and oi_type = 'b'";
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

	public int memberInsert(MemberInfo mi, MemberAddr ma) {
		// 회원정보 테이블에 insert
		String sql = "insert into t_member_info values ('" + mi.getMi_id() + "', '" + mi.getMi_pw() + "', '" + mi.getMi_name() + "', '" + mi.getMi_gender() + 
				"', '" + mi.getMi_birth() + "', '" + mi.getMi_phone() + "', '" + mi.getMi_email() + "', '" + mi.getMi_isad() + "', 1000, '0', 'a', now(), null)";
		int result = jdbc.update(sql);
//		System.out.println(sql);
		// 회원 주소록 테이블에 insert
		sql = "insert into t_member_addr (mi_id, ma_name, ma_rname, ma_phone, ma_zip, ma_addr1, ma_addr2) values ('" + mi.getMi_id() + "', '집', '" + mi.getMi_name() + 
				"', '" + mi.getMi_phone() + "', '" + ma.getMa_zip() + "', '" + ma.getMa_addr1() + "', '" + ma.getMa_addr1() + "')";
		result += jdbc.update(sql);
//		System.out.println(sql);
		// 회원 포인트 테이블에 insert
		sql = "insert into t_member_point (mi_id, mp_su, mp_point, mp_desc, mp_detail, mp_admin) values ('" + mi.getMi_id() + "', 'a', 1000, '회원 가입 축하 포인트', '회원 가입 축하 포인트', 1)";
		result += jdbc.update(sql);
//		System.out.println(sql);
		
		return result;
	}

	public List<MemberAddr> getMemberAddrList(String miid) {
		String sql = "select ma_idx, ma_name, ma_rname, ma_phone, ma_zip, ma_addr1, ma_addr2, ma_basic from t_member_addr where mi_id = '" + miid + "' order by ma_basic desc";
		List<MemberAddr> memberAddrList = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			MemberAddr ma = new MemberAddr();
			ma.setMa_idx(rs.getInt("ma_idx"));
			ma.setMa_name(rs.getString("ma_name"));
			ma.setMa_rname(rs.getString("ma_rname"));
			ma.setMa_phone(rs.getString("ma_phone"));
			ma.setMa_zip(rs.getString("ma_zip"));
			ma.setMa_addr1(rs.getString("ma_addr1"));
			ma.setMa_addr2(rs.getString("ma_addr2"));
			ma.setMa_basic(rs.getString("ma_basic"));
			
			return ma;
		});
		return memberAddrList;
	}

	public MemberAddr getMemberAddr(String miid, int maidx) {
		String sql = "select ma_idx, ma_name, ma_rname, ma_phone, ma_zip, ma_addr1, ma_addr2, ma_basic from t_member_addr where mi_id = '" + miid + "' and ma_idx = " + maidx;
		MemberAddr ma = jdbc.queryForObject(sql,
			new RowMapper<MemberAddr>() {
				@Override
				public MemberAddr mapRow(ResultSet rs, int rowNum) throws SQLException {
					MemberAddr ma = new MemberAddr();
					ma.setMa_idx(rs.getInt("ma_idx"));
					ma.setMa_name(rs.getString("ma_name"));
					ma.setMa_rname(rs.getString("ma_rname"));
					ma.setMa_phone(rs.getString("ma_phone"));
					ma.setMa_zip(rs.getString("ma_zip"));
					ma.setMa_addr1(rs.getString("ma_addr1"));
					ma.setMa_addr2(rs.getString("ma_addr2"));
					ma.setMa_basic(rs.getString("ma_basic"));
					return ma;
				}
			}
		);
		return ma;
	}

	public int addrInsert(MemberAddr ma, int idx) {
		String sql = "insert into t_member_addr (mi_id, ma_name, ma_rname, ma_phone, ma_zip, ma_addr1, ma_addr2, ma_basic) values ('" + ma.getMi_id() + "', '" + ma.getMa_name() + 
		"', '" + ma.getMa_rname() + "', '" + ma.getMa_phone() + "', '" + ma.getMa_zip() + "', '" + ma.getMa_addr1() + "', '" + ma.getMa_addr2() + "', '" + ma.getMa_basic() + "')";
//		System.out.println(sql);
		int result = jdbc.update(sql);
		
		if (ma.getMa_basic() == "y") {
			sql = "update t_member_addr set ma_basic = 'n' where mi_id = '" + ma.getMi_id() + "' and ma_idx != " + idx;
//			System.out.println(sql);
			result += jdbc.update(sql);
		}
		
		
		return result;
	}

	public int addrUpdate(MemberAddr ma) {
		String sql = "update t_member_addr set ma_name = '" + ma.getMa_name() + "', ma_rname = '" + ma.getMa_rname() + "', ma_phone = '" + ma.getMa_phone() + 
			"', ma_zip = '" + ma.getMa_zip() + "', ma_addr1 = '" + ma.getMa_addr1() + "', ma_addr2 = '" + ma.getMa_addr2() + "', ma_basic = '" + ma.getMa_basic() + 
			"' where ma_idx = " + ma.getMa_idx();
		System.out.println(sql);
		int result = jdbc.update(sql);
		
		if (ma.getMa_basic() == "y") {
			sql = "update t_member_addr set ma_basic = 'n' where mi_id = '" + ma.getMi_id() + "' and ma_idx != " + ma.getMa_idx();
			System.out.println(sql);
			result += jdbc.update(sql);
		}
		
		return result;
	}

	public int memberOut(String miid) {
		String sql = "update t_member_info set mi_status = 'c' where mi_id = '" + miid + "'";
		int result = jdbc.update(sql);
		return result;
	}

	public List<ReviewList> getReviewList(String miid, int cpage, int psize) {
		String sql = "select rl_idx, mi_id, pi_id, rl_name, rl_content, rl_img, rl_good, concat(mid(rl_date, 3, 2), '/', mid(rl_date, 6, 2), '/', mid(rl_date, 9, 2), ' ', mid(rl_date, 12, 5)) wdate from t_review_list where mi_id = '" + miid + "' and rl_isview = 'y'";
//		System.out.println(sql);	
		List<ReviewList> reviewList = jdbc.query(sql, 
			(ResultSet rs, int rowNum) -> {
				ReviewList rl = new ReviewList();
				rl.setRl_idx(rs.getInt("rl_idx"));
				rl.setMi_id(rs.getString("mi_id"));
				rl.setPi_id(rs.getString("pi_id"));
				rl.setRl_name(rs.getString("rl_name"));
				rl.setRl_content(rs.getString("rl_content"));
				rl.setRl_img(rs.getString("rl_img"));
				rl.setRl_good(rs.getString("rl_good"));
				rl.setRl_date(rs.getString("wdate"));
				return rl;
		});
		return reviewList;
	}

	public int getReviewCount(String miid) {
		String sql = "select count(*) from t_review_list where mi_id = '" + miid + "' and rl_isview = 'y'";
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

}
