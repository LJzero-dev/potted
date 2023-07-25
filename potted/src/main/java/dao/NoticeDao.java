package dao;


import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;


public class NoticeDao {
	private JdbcTemplate jdbc;
	
	public NoticeDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public List<NoticeList> getNoticeList() {
		String sql = "select * from t_notice_List where nl_isview = 'y'";
		List<NoticeList> noticeList = jdbc.query(sql, 
			(ResultSet rs, int rowNum) -> {
			NoticeList nl = new NoticeList(rs.getInt("nl_idx"), rs.getInt("ai_idx"), rs.getString("nl_title"), 
				rs.getString("nl_content"), rs.getString("nl_date"), rs.getString("nl_isview"));
				return nl;
			});
		
		return noticeList;
	}
}
