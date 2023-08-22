package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class QnaDao {
	private JdbcTemplate jdbc;
	
	public QnaDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public int getQnaListCount(String where) {
		String sql = "select count(*) from t_qna_list " + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

	public List<QnaList> getQnaList(String where, int cpage, int psize) {
		String sql = "select a.ql_idx, a.ql_title, b.mi_id, c.ai_idx" +
				" if(curdate() = date(ql_qdate), mid(ql_qdate, 12, 5), mid(ql_qdate, 3, 8)) wdate " +
				" from t_qna_list a, t_member_info b, t_admin_info c " + where + " and a.mi_id = b.mi_id and a.ai_idx = c.ai_idx and ql_isview = y  order by nl_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
			// System.out.println(sql);
			List<QnaList> qnaList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
				QnaList ql = new QnaList();
				ql.setQl_idx(rs.getInt("ql_idx"));		ql.setMi_id(rs.getString("mi_id"));
				ql.setAi_idx(rs.getInt("ai_idx"));
				ql.setQl_qdate(rs.getString("ql_qdate"));
				
				
				String title = "";	int cnt = 30;
				if(rs.getString("ql_title").length() > cnt)
					title = rs.getString("ql_title").substring(0, cnt - 3) + "..." + title;
				else
					title = rs.getString("ql_title") + title;
				
				ql.setQl_title(title);
				
					return ql;
	 			
			});
			
			return qnaList;
	}
}
