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
	
	public List<MemberInfo> getMemberList() {
		String sql = "select * from t_member_info ";
		System.out.println(sql);
		List<MemberInfo> memberList = (List<MemberInfo>) jdbc.query(sql, (ResultSet rs, int rowNum) -> {
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
	        return mi;
	    });
		
		return memberList;
	}
	
}