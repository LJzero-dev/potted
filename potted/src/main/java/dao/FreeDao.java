package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class FreeDao {
	private JdbcTemplate jdbc;
	
	public FreeDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public int getFreeListCount(String where) {
		String sql = "select count(*) from t_free_list " + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
					// queryForObject : ������ ���� �ϳ��϶�
		return rcnt;
	}

	public List<FreeList> getFreeList(String where, int cpage, int psize) {
		String sql = "select mi_id, fl_idx, fl_title, fl_reply, fl_writer, fl_read, " +
				" if(curdate() = date(fl_date), mid(fl_date, 12, 5), mid(fl_date, 3, 8)) wdate from t_free_list " + where +
			" order by fl_idx desc limit " + ((cpage -1) * psize) + ", " + psize;
		List<FreeList> freeList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			FreeList fl = new FreeList();
			fl.setMi_id(rs.getString("mi_id"));
			fl.setFl_idx(rs.getInt("fl_idx"));		fl.setFl_writer(rs.getString("fl_writer"));
			fl.setFl_read(rs.getInt("fl_read"));	fl.setFl_date(rs.getString("wdate").replace("-", "."));
			
			
			String title = "";	int cnt = 22;
			if(rs.getInt("fl_reply") > 0) {
				title = " [" + rs.getInt("fl_reply") + "]";
				cnt -= 3;
			}
			if(rs.getString("fl_title").length() > cnt)
				title = rs.getString("fl_title").substring(0, cnt - 3) + "..." + title;
			else
				title = rs.getString("fl_title") + title;
			
			fl.setFl_title(title);
			
				return fl;
 			
		});
		
		return freeList;
	}

	public int readUpdate(int flidx) {
	
		String sql = "update t_free_list set fl_read = fl_read + 1 where fl_idx = " + flidx;
		int result = jdbc.update(sql);
		return result;
	}

	public FreeList getFreeInfo(int flidx) {
		int result = readUpdate(flidx);
		String sql = "select *, if(curdate() = date(fl_date), mid(fl_date, 12, 5), mid(fl_date, 3, 8)) wdate from t_free_list where fl_isview = 'y' and fl_idx =" + flidx;

		FreeList fl = jdbc.queryForObject(sql, new RowMapper<FreeList>() {
				@Override
				public FreeList mapRow(ResultSet rs, int rowNum) throws SQLException {
					FreeList fl = new FreeList();
					fl.setFl_idx(rs.getInt("fl_idx"));
					fl.setMi_id(rs.getString("mi_id"));
					fl.setFl_ismem(rs.getString("fl_ismem"));
					fl.setFl_writer(rs.getString("fl_writer"));
					fl.setFl_title(rs.getString("fl_title"));
					fl.setFl_content(rs.getString("fl_content").replace("\r\n", "<br />"));
					fl.setFl_reply(rs.getInt("fl_reply"));
					fl.setFl_read(rs.getInt("fl_read"));
					fl.setFl_date(rs.getString("wdate"));
					fl.setFl_img1(rs.getString("fl_img1"));
					fl.setFl_img2(rs.getString("fl_img2"));
					return fl;
				}
			});
		return fl;
	}
	
	public int freeInsert(FreeList fl) {
		String sql = "select max(fl_idx) + 1 from t_free_list";
		int idx = jdbc.queryForObject(sql, Integer.class);

		sql = "insert into t_free_list (fl_idx, mi_id, fl_writer, fl_title, fl_content, fl_img1) values (?, ?, ?, ?, ?, ?)";
		int result = jdbc.update(sql, idx, fl.getMi_id(), fl.getFl_writer(), fl.getFl_title(), fl.getFl_content(), fl.getFl_img1());
		return idx;
	}

	public List<ReplyList> getReplyList(int flidx) {
		String sql="select a.*, if(curdate() = date(fr_date), mid(fr_date, 12, 5), mid(fr_date, 3, 8)) wdate, b.mi_name from t_free_reply a, t_member_info b " + 
				" where fr_isview = 'y' and fr_ismem = 'y' and a.mi_id = b.mi_id and a.fl_idx = " + flidx;
		List<ReplyList> replyList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ReplyList rl = new ReplyList();
			rl.setFr_idx(rs.getInt("fr_idx"));			rl.setFr_content(rs.getString("fr_content").replace("\r\n", "<br />"));
			rl.setFr_date(rs.getString("wdate"));		rl.setFr_isview(rs.getString("fr_isview"));
			rl.setMi_name(rs.getString("mi_name"));		rl.setMi_id(rs.getString("mi_id"));
			
			return rl;
		});
		return replyList;
	}

	public int replyDel(int fridx, int flidx) {
		String sql = "update t_free_reply set fr_isview = 'n' where fr_idx = " + fridx;
		int result = jdbc.update(sql);
		sql = "update t_free_list set fl_reply = fl_reply - 1 where fl_idx = " + flidx;
		result += jdbc.update(sql);
		return result;
	}

	public int replyUpdate(int flidx) {
	// ������ �Խñ��� ��ۼ��� 1 ������Ű�� �޼ҵ�
	
		String sql = "update t_free_list set fl_reply = fl_reply + 1 where fl_idx = " + flidx;
		int result = jdbc.update(sql);
		return result;
	}


	public int replyInsert(String miid, String fr_content, int flidx) {
		int result = replyUpdate(flidx);
		String sql = "insert into t_free_reply (fl_idx, mi_id, fr_content) values (" + flidx + ", '" + miid + "', '" + fr_content + "')";
		result += jdbc.update(sql);
		return result;
	}

	
	public int flDel(int idx) {
		String sql = "update t_free_list set fl_isview = 'n' where fl_idx = " + idx;
		int result = jdbc.update(sql);
		return result;
	}

}
