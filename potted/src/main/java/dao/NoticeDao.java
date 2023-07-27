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
	
	// 공지사항 리스트 값 가져올 쿼리
	public List<NoticeList> getNoticeList(SpageInfo si) {
		String where = "";
		if(si.getSchtype() != null && !si.getSchtype().equals("") && si.getKeyword() != null && !si.getKeyword().equals("")) {
			if (si.getSchtype().equals("a")) {
				where += " and nl_title like '%" + si.getKeyword() + "%' or nl_content like '%" + si.getKeyword() + "%'";
			} else { where += " and nl_" + si.getSchtype() + " like '%" + si.getKeyword() + "%'"; } 
		}
		String sql = "select a.*, b.ai_id, if(curdate() = date(nl_date), mid(nl_date, 12, 5), mid(nl_date, 3, 8)) wdate from t_notice_list a, t_admin_info b where a.ai_idx = b.ai_idx " + where + " and  a.nl_isview = 'y' order by nl_idx desc";
		
		List<NoticeList> noticeList = jdbc.query(sql, 
			(ResultSet rs, int rowNum) -> {
			NoticeList nl = new NoticeList(rs.getInt("nl_idx"), rs.getInt("ai_idx"), rs.getString("nl_title"), 
				rs.getString("nl_content"), rs.getString("wdate"), rs.getString("nl_isview"), rs.getString("ai_id"));
				return nl;
			});
		
		return noticeList;
	}
	

}
