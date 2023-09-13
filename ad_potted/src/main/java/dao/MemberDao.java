package dao;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;

import vo.*;

public class MemberDao {
	private JdbcTemplate jdbc;	
	public MemberDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public List<MemberInfo> getMemberList(int cpage, int psize) {
		String sql = "select a.*, concat(mid(a.mi_date, 3, 2), '/', mid(a.mi_date, 6, 2), '/', mid(a.mi_date, 9, 2), ' ', mid(a.mi_date, 12, 5)) wdate, " +	
					"ifnull(sum(b.oi_pay), 0) purchase_sum from t_member_info a left join t_order_info b on a.mi_id = b.mi_id group by mi_id limit " + 
					((cpage - 1) * psize) + ", " + psize;
//		System.out.println(sql);
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
            mi.setMi_date(rs.getString("wdate"));
            mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
            mi.setPurchase_sum(rs.getInt("purchase_sum"));
	        return mi;
	    });
		
		
		return memberList;
	}

	public int getMemberCount() {
		String sql = "select count(*) from t_member_info";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

	public MemberInfo getMemberInfo(String miid) {
		String sql = "select mi_id, mi_name, mi_gender, mi_birth, mi_phone, mi_email, mi_isad, mi_point, mi_protein, mi_status, concat(mid(mi_date, 3, 2), '/', mid(mi_date, 6, 2), '/', mid(mi_date, 9, 2), ' ', mid(mi_date, 12, 5)) wdate, mi_lastlogin " + 
					"from t_member_info where mi_id = '" + miid + "'";
//		System.out.println(sql);
		MemberInfo memberInfo = jdbc.queryForObject(sql, new RowMapper<MemberInfo>() {
			@Override
			public MemberInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberInfo mi = new MemberInfo();
				mi.setMi_id(miid);
				mi.setMi_name(rs.getString("mi_name"));
				mi.setMi_gender(rs.getString("mi_gender"));
				mi.setMi_birth(rs.getString("mi_birth"));
				mi.setMi_phone(rs.getString("mi_phone"));
				mi.setMi_email(rs.getString("mi_email"));
				mi.setMi_isad(rs.getString("mi_isad"));
				mi.setMi_protein(rs.getInt("mi_protein"));
				mi.setMi_status(rs.getString("mi_status"));
	            mi.setMi_date(rs.getString("wdate"));
	            mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
				return mi;
			}
		});
		return memberInfo;
	}
	
}