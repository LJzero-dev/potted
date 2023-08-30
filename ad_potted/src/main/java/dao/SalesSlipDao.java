package dao;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.MemberInfo;

public class SalesSlipDao {
	private JdbcTemplate jdbc;
	
	public SalesSlipDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<MemberInfo> getMemberInfo(int y, int m) {
		String month = "";
		if(m < 10)	month = "0" + m;
		String sql = "select count(*) mcnt, mid(mi_date, 9, 2) miday from t_member_info where mid(mi_date, 1, 4) = '" + y + "' and mid(mi_date, 6, 2) = '" + month + "' group by miday";
		System.out.println(sql);
		List<MemberInfo> memberInfo = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			MemberInfo mi = new MemberInfo();
			mi.setMi_day(rs.getString("miday"));
			mi.setMi_count(rs.getInt("mcnt"));
			return mi;
		});
		return memberInfo;
	}	
}
