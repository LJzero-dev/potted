package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vo.MemberInfo;
import vo.MemberTree;

public class MyPlantDao {
	private JdbcTemplate jdbc;	
	public MyPlantDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	public boolean getMtPlant(String mi_id) {
		return jdbc.queryForObject("select count(*) from t_member_tree where mi_id = '" + mi_id + "' and mt_plant = 'y'", Integer.class) == 1 ? true : false;		
	}
	public int setMyPlant(String mi_id, String plant) {
		return jdbc.update("insert into t_member_tree (mi_id,mt_grade, mt_plant) values (?, ?, 'y')",mi_id,plant);
	}
	public MemberTree getMyPlant(String mi_id) {
		List<MemberTree> results = jdbc.query("select a.mi_protein, b.mt_grade, b.mt_hp, b.mt_count, b.mt_date from t_member_info a, t_member_tree b where a.mi_id = b.mi_id and b.mt_plant = 'y' and b.mi_id = ?", new RowMapper<MemberTree>() {
			public MemberTree mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberTree mt = new MemberTree();
				mt.setMi_protein(rs.getInt(1)); mt.setMt_grade(rs.getInt(2));	mt.setMt_hp(rs.getInt(3));	mt.setMt_count(rs.getInt(4));	mt.setMt_date(rs.getString(5));	
	            return mt;
			}
		},mi_id);
		return results.isEmpty() ? null : results.get(0);
	}
	public int wattering(String mi_id) {		
		return jdbc.update("update t_member_tree set mt_hp = mt_hp - timestampdiff(minute, mt_date, now()), mt_count = mt_count + 1, mt_date = date_add(now(), interval " + jdbc.queryForObject("select mt_grade from t_member_tree where mi_id = '" + mi_id + "' and mt_plant = 'y'", Integer.class) * 6 + " hour) where mi_id = ? and mt_plant = 'y'",mi_id);			
	}
}