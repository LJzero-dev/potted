package vo;

public class SpageInfo {
	private String schtype, keyword, args;

	
	
	public SpageInfo(String schtype, String keyword, String args) {
		this.schtype = schtype;
		this.keyword = keyword;
		this.args = args;
	}

	
	
	public String getArgs() {
		return args;
	}



	public void setArgs(String args) {
		this.args = args;
	}



	public String getSchtype() {
		return schtype;
	}

	public void setSchtype(String schtype) {
		this.schtype = schtype;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
}
