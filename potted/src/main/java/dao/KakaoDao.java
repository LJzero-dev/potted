package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vo.*;

public class KakaoDao {
	private JdbcTemplate jdbc;
	
	public KakaoDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public int isMem(String email) {
		String sql = "select count(*) from t_member_info where mi_email = '" + email + "' and mi_status != 'c'";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

	public MemberInfo getLoginInfo(String email) {
		String sql = "select * from t_member_info where mi_email = '" + email + "' and mi_status != 'c'";
		
		List<MemberInfo> results = jdbc.query(sql, new RowMapper<MemberInfo>() {
			public MemberInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberInfo mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
	            mi.setMi_pw(rs.getString("mi_pw"));
	            mi.setMi_name(rs.getString("mi_name"));
	            mi.setMi_gender(rs.getString("mi_gender"));
	            mi.setMi_birth(rs.getString("mi_birth"));
	            mi.setMi_phone(rs.getString("mi_phone"));
	            mi.setMi_email(rs.getString("mi_email"));
	            mi.setMi_isad(rs.getString("mi_isad"));
	            mi.setMi_point(rs.getInt("mi_point"));
	            mi.setMi_status(rs.getString("mi_status"));
	            mi.setMi_date(rs.getString("mi_date"));
	            mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
	            mi.setOrder_count(jdbc.queryForObject("select count(*) from t_order_cart where mi_id = '" + rs.getString("mi_id") + "'", Integer.class));
	            return mi;
			}
		});
		
		sql = "update t_member_info set mi_lastlogin = now() where mi_email = '" + email + "' and mi_status != 'c'";
		int result = jdbc.update(sql);
		
		return results.isEmpty() ? null : results.get(0);
	}

}
