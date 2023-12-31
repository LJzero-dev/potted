package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class LoginDao {
	private JdbcTemplate jdbc;
	
	public LoginDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public MemberInfo getLoginInfo(String uid, String pwd) {
		String sql = "select * from t_member_info where mi_id = ? and mi_pw = ? and mi_status != 'c'";
		
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
	            mi.setOrder_count(jdbc.queryForObject("select count(*) from t_order_cart where mi_id = '" + uid + "'", Integer.class));
	            return mi;
			}
		}, uid, pwd);
		// ������ ���� ���� ������ �Ű������� ���� �߰��� �ʿ� ����
		
		sql = "update t_member_info set mi_lastlogin = now() where mi_id = '" + uid + "'";
		int result = jdbc.update(sql);
		
		return results.isEmpty() ? null : results.get(0);	// ����Ʈ�� ��� ������ null�� �������� �ƴϸ� ����Ʈ �ȿ��ִ� 0�� �ε����� �����ض�
	}
}
