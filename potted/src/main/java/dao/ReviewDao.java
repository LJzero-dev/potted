package dao;

import java.sql.*;
import java.util.List;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class ReviewDao {
	private JdbcTemplate jdbc;
	
	public ReviewDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public OrderDetail getOrderDetail(String oiid) {
		String sql = "select od_idx, oi_id, pi_id, od_option, od_cnt, od_name from t_order_detail where oi_id = '" + oiid + "'";
		OrderDetail od = jdbc.queryForObject(sql,
			new RowMapper<OrderDetail>() {
				@Override
				public OrderDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
					OrderDetail od = new OrderDetail();
					od.setOd_idx(rs.getInt("od_idx"));
					od.setOi_id(rs.getString("oi_id"));
					od.setPi_id(rs.getString("pi_id"));
					od.setOd_option(rs.getString("od_option"));
					od.setOd_cnt(rs.getInt("od_cnt"));
					od.setOd_name(rs.getString("od_name"));
					return od;
				}
			}
		);
		return od;
	}

	public int reviewInsert(ReviewList rl) {
		String sql = "insert into t_review_list (mi_id, oi_id, pi_id, rl_name, rl_content, rl_img, rl_good, rl_ip) values ('" + 
					rl.getMi_id() + "', '" + rl.getOi_id() + "', '" + rl.getPi_id() + "', '" + rl.getRl_name() + "', '" + rl.getRl_content() + "', '" + 
					rl.getRl_img() + "', '" + rl.getRl_good() + "', '" + rl.getRl_ip() + "')";
		int result = jdbc.update(sql);
		
		sql = "update t_order_info set oi_status = 'd' where oi_id = '" + rl.getOi_id() + "'";
		result += jdbc.update(sql);
		return result;
	}

	public int reviewDel(int rlidx) {
		String sql = "update t_review_list set rl_isview = 'n' where rl_idx = '" + rlidx + "'";
		System.out.println(sql);
		int result = jdbc.update(sql);
		return result;
	}


}
