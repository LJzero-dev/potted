package dao;

import java.sql.*;
import java.util.*;

import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import vo.*;

public class ScheduleDao {
	private JdbcTemplate jdbc;

	public ScheduleDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<ScheduleInfo> getScheduleList(String uid, int y, int m) {
	// 지정한 연월에 해당하는 일정들의 목록을 List<ScheduleInfo>로 리턴하는 메소드
		String sql = "select * from t_schedule_info where ai_id = '" + uid + "' and si_date like '" + y + "-" + (m < 10 ? "0" + m : m) + "%' order by si_date, si_time";
		List<ScheduleInfo> scheduleList = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			ScheduleInfo si = new ScheduleInfo(
			rs.getInt("si_idx"), rs.getString("ai_id"), rs.getString("si_date"), rs.getString("si_time"), rs.getString("si_title"), rs.getString("si_content"), rs.getString("si_regdate"));
			return si;
		});

		return scheduleList;
	}

	public int scheduleInsert(ScheduleInfo si) {
		String sql = "insert into t_schedule_info values (null, '" + si.getAi_id() + "', '" + si.getSi_date() + "', '" + si.getSi_time() + "', '" + si.getSi_title() + "', '" + si.getSi_content() + "', now())";
		int result = jdbc.update(sql);
		return result;
	}
}
