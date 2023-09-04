package dao;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.MemberAddr;
import vo.OrderCart;
import vo.OrderDetail;
import vo.OrderInfo;

public class OrderDao {
	private JdbcTemplate jdbc;
	
	public OrderDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<OrderCart> getBuyList(String kind, String sql) {
		List<OrderCart> pdtList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			System.out.println(sql);
			OrderCart oc = new OrderCart();
			oc.setPi_id(rs.getString("pi_id"));
			oc.setPi_img(rs.getString("pi_img1"));
			if (kind.equals("c"))    {
                oc.setOc_idx(rs.getInt("oc_idx"));
                oc.setOc_option(rs.getString("oc_option"));
                oc.setOc_price(rs.getInt("oc_price"));
            }
			// 占쏙옙袂占쏙옙玖占� 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙荑∽옙占� 占쏙옙袂占쏙옙占� 占싸듸옙占쏙옙占쏙옙 占쌩곤옙 占쏙옙占쏙옙占쏙옙
			else 					oc.setOc_idx(0);
			oc.setPi_name(rs.getString("pi_name"));
			oc.setOc_cnt(rs.getInt("cnt"));
			return oc;
		});
		return pdtList;
	}

	public ArrayList<MemberAddr> getAddrList(String miid) {
		String sql = "select * from t_member_addr where mi_id = '" + miid + "' order by ma_basic desc";
		ArrayList<MemberAddr> addrList = (ArrayList<MemberAddr>) jdbc.query(sql, (ResultSet rs, int rowNum) -> {
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
		return addrList;
	}

	public int orderInsert(OrderInfo oi, OrderDetail od) {
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
        String datePart = dateFormat.format(new Date());

        Random random = new Random();
        int randomValue = random.nextInt(90) + 10; // 2占쌘몌옙 占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙 (10 占싱삼옙 99 占쏙옙占쏙옙)
        
		String sql = "insert into t_order_info (oi_id, mi_id, pi_id, oi_name, oi_type, oi_phone, oi_zip, oi_addr1, oi_addr2, oi_memo, oi_payment, oi_pay, oi_upoint, oi_apoint, oi_status, oi_date, oi_cnt) values (?, ?, ?, ?, 'a', ?, ?, ?, ?, ?, ?, ?, ?, ?, 'a', now(), ?)";
		int result = jdbc.update(sql, datePart + oi.getPi_id() + randomValue, oi.getMi_id(), oi.getPi_id(), oi.getOi_name(), oi.getOi_phone(), oi.getOi_zip(), oi.getOi_addr1(), oi.getOi_addr2(), oi.getOi_memo(), oi.getOi_payment(), oi.getOi_pay(), oi.getOi_upoint(), oi.getOi_apoint(), oi.getOi_cnt());
		
		if (result == 1) {
	    	String oiIdQuery = "select oi_id from t_order_info where oi_id = ?";
	        String oiId = jdbc.queryForObject(oiIdQuery, String.class, datePart + oi.getPi_id() + randomValue);
	        
			sql = "insert into t_order_detail (oi_id, pi_id, od_option, od_name, od_img) values (?, ?, ?, ?, ?)";
			result += jdbc.update(sql, oiId, oi.getPi_id(), od.getOd_option(), od.getOd_name(), od.getOd_img());
			jdbc.update("update t_member_info set mi_protein = mi_protein + " + (int)oi.getOi_pay()/30000 + " where mi_id = '" + oi.getMi_id() + "'");
			jdbc.update("update t_member_info set mi_point = mi_point + " + (oi.getOi_apoint() - oi.getOi_upoint()) + " where mi_id = '" + oi.getMi_id() + "'");	

			if (oi.getOi_upoint() != 0)	jdbc.update("insert into t_member_point (mi_id, mp_su, mp_point, mp_desc) values ('" + oi.getMi_id() + "', 'u', -" + oi.getOi_upoint() + ", '상품 구매')");			
			if (oi.getOi_apoint() != 0)	jdbc.update("insert into t_member_point (mi_id, mp_su, mp_point, mp_desc) values ('" + oi.getMi_id() + "', 'a', " + oi.getOi_apoint() + ", '상품 구매')");							
			if (oi.getIsAuction().equals("y")) jdbc.update("update t_product_info set pi_status = 'n' where pi_id = '" + oi.getPi_id() + "'");
	    }		
		return result;
	}


}
