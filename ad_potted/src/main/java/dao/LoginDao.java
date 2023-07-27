package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vo.AdminInfo;

public class LoginDao {
	private JdbcTemplate jdbc;	
	public LoginDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}	
	public AdminInfo getLoginInfo(String uid, String pwd) {
		List<AdminInfo> results = jdbc.query("select * from t_admin_info where ai_id = ? and ai_pw = ?", new RowMapper<AdminInfo>() {
			public AdminInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				AdminInfo ai = new AdminInfo(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6));
	            return ai;
			}
		}, uid, pwd);
	return results.isEmpty() ? null : results.get(0);
	}
}