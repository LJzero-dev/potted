package vo;

public class CalendarInfo {
// 일정 관리의 달력에서 필요한 정보들을 저장할 클래스 
	private int curYear, curMonth, curDay;	// 현재 연월일
	private int schYear, schMonth, schDay, schLast, sWeek;	// 검색할 연월일과 말일, 시작일의 요일번호
	
	public int getCurYear() {
		return curYear;
	}
	public void setCurYear(int curYear) {
		this.curYear = curYear;
	}
	public int getCurMonth() {
		return curMonth;
	}
	public void setCurMonth(int curMonth) {
		this.curMonth = curMonth;
	}
	public int getCurDay() {
		return curDay;
	}
	public void setCurDay(int curDay) {
		this.curDay = curDay;
	}
	public int getSchYear() {
		return schYear;
	}
	public void setSchYear(int schYear) {
		this.schYear = schYear;
	}
	public int getSchMonth() {
		return schMonth;
	}
	public void setSchMonth(int schMonth) {
		this.schMonth = schMonth;
	}
	public int getSchDay() {
		return schDay;
	}
	public void setSchDay(int schDay) {
		this.schDay = schDay;
	}
	public int getSchLast() {
		return schLast;
	}
	public void setSchLast(int schLast) {
		this.schLast = schLast;
	}
	public int getsWeek() {
		return sWeek;
	}
	public void setsWeek(int sWeek) {
		this.sWeek = sWeek;
	}
	
	
}
