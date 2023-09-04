package dao;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.MemberInfo;
import vo.SalesSlip;

public class SalesSlipDao {
	private JdbcTemplate jdbc;
	
	public SalesSlipDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<MemberInfo> getMemberInfo(int y, int m) {
		String month = "";
		if(m < 10)	month = "0" + m;
		String sql = "select count(*) mcnt, mid(mi_date, 9, 2) miday from t_member_info where mid(mi_date, 1, 4) = '" + y + "' and mid(mi_date, 6, 2) = '" + month + "' group by miday";
//		System.out.println(sql);
		List<MemberInfo> memberInfo = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			MemberInfo mi = new MemberInfo();
			mi.setMi_day(rs.getString("miday"));
			mi.setMi_count(rs.getInt("mcnt"));
			return mi;
		});
		return memberInfo;
	}

	public List<MemberInfo> getMemberAge() {
		String sql = "select mi_id, mid(curdate(), 1, 4) - mid(mi_birth, 1, 4) miage from t_member_info order by miage";
		List<MemberInfo> memberAge = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			MemberInfo ma = new MemberInfo();
			ma.setMi_id(rs.getString("mi_id"));
			ma.setMi_age(rs.getInt("miage"));
			return ma;
		});
		return memberAge;
	}

	public List<SalesSlip> getSalesSlipList(String sql) {
		List<SalesSlip> salesSlipList = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			SalesSlip ss = new SalesSlip();
			ss.setSs_month(rs.getInt("smonth"));
			ss.setSs_sale(rs.getInt("sales"));
			ss.setSs_real(rs.getInt("realPrice"));
			ss.setSs_pcb(rs.getString("pcb"));
			return ss;
		});
		return salesSlipList;
	}	
}
