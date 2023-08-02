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
	
	public int getNoticeListCount(String where) {
		String sql = "select count(*) from t_notice_list " + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}
	
	// 공지사항 리스트 값 가져올 쿼리
	public List<NoticeList> getNoticeList(String where, int cpage, int psize) {
		String sql = "select a.nl_idx, a.nl_title, b.ai_id, " +
			" if(curdate() = date(nl_date), mid(nl_date, 12, 5), mid(nl_date, 3, 8)) wdate " +
			" from t_notice_list a, t_admin_info b " + where + " and a.ai_idx = b.ai_idx  order by nl_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
		System.out.println(sql);
		List<NoticeList> noticeList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			NoticeList nl = new NoticeList();
			nl.setNl_idx(rs.getInt("nl_idx"));		nl.setAi_id(rs.getString("ai_id"));
			nl.setNl_date(rs.getString("wdate").replace("-", "."));
			
			
			String title = "";	int cnt = 30;
			if(rs.getString("nl_title").length() > cnt)
				title = rs.getString("nl_title").substring(0, cnt - 3) + "..." + title;
			else
				title = rs.getString("nl_title") + title;
			
			nl.setNl_title(title);
			
				return nl;
 			
		});
		
		return noticeList;
	}

	public NoticeList getNoticeInfo(int nlidx) {
		//지정한 게시글내용을 NoticeList형 인스턴스로 리턴하는 메소드
		String sql = "select a.*, if(curdate() = date(a.nl_date), mid(a.nl_date, 12, 5), mid(a.nl_date, 3, 8)) wdate, b.ai_id from t_notice_list a, t_admin_info b where a.ai_idx = b.ai_idx and a.nl_isview = 'y' and a.nl_idx = " + nlidx;
		System.out.println(sql);
		NoticeList nl = jdbc.queryForObject(sql, new RowMapper<NoticeList>() {
			@Override
			public NoticeList mapRow(ResultSet rs, int rowNum) throws SQLException {
				NoticeList nl = new NoticeList();
				nl.setNl_idx(rs.getInt("nl_idx"));	nl.setNl_title(rs.getString("nl_title"));
				nl.setNl_content(rs.getString("nl_content").replace("\r\n", "<br />"));
				nl.setAi_id(rs.getString("ai_id"));	nl.setNl_date(rs.getString("wdate"));
				
				return nl;
			}
		});
		
		return nl;
	}
}

