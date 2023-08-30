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

	public List<MemberPoint> getMemberPoint(String miid, int cpage, int psize) {
		// 회원 포인트를 List<MemberPoint>형으로 리턴
		String sql = "select mp_idx, mp_point, mp_desc, mp_detail, concat(mid(mp_date, 3, 2), '/', mid(mp_date, 6, 2), '/', mid(mp_date, 9, 2), ' ', mid(mp_date, 12, 5)) wdate from t_member_point " + 
		" where mi_id = '" + miid + "' order by mp_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
		List<MemberPoint> memberPoint = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			MemberPoint mp = new MemberPoint();
			mp.setMp_idx(rs.getInt("mp_idx"));
			mp.setMp_point(rs.getInt("mp_point"));
			mp.setMp_desc(rs.getString("mp_desc"));
			mp.setMp_detail(rs.getString("mp_detail"));
			mp.setMp_date(rs.getString("wdate"));
			return mp;
		});
		return memberPoint;
	}

	public int getMemberPointListCount(String miid) {
		String sql = "select count(*) from t_member_point where mi_id ='" + miid + "'";
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

}
