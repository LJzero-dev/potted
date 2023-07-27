<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
List<NoticeList> noticeList = (List<NoticeList>)request.getAttribute("noticeList");

%>

<h2 style="display:inline;">SERVICE</h2>
<form style="display:inline; float:right;">
<div style="width:450px;">
		<select name="schtype">
		<option value="a" <c:if test="${si.getSchtype() eq 'a'}">selected="selected"</c:if>>전체🌱</option>
		<option value="title" <c:if test="${si.getSchtype() eq 'title'}">selected="selected"</c:if>>제목🌱</option>
		<option value="content" <c:if test="${si.getSchtype() eq 'content'}">selected="selected"</c:if>>내용🌱</option>
	</select>
	<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력해주세요." value="${si.getKeyword()}" style=" width:180px; border:0; font-size:10pt;" />
	<input type="image" name="submit" src="/potted/resources/images/product/search.png" width="20" class="btn" onclick="" />
</div>
</form>
<hr color="#1cad0a" style="border-width:1px; height:1px; border:0;" />
&nbsp;&nbsp;&nbsp;&nbsp;<h3 style="display:inline;">공지사항</h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<h3 style="display:inline;">문의</h3>
<br /><br />
<table width="60%" height="80px" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<th width="5%" class="nhList">번호</th>
<th width="*" class="nhList">제목</th>
<th width="15%" class="nhList">작성자</th>
<th width="20%" class="nhList">날짜</th>
</tr>
<%
if (noticeList.size() > 0 ){
//	int num = rcnt - (psize * (cpage - 1));
	for (int i = 0 ; i < noticeList.size() ; i++) {
		NoticeList nl = noticeList.get(i);
		out.println("<tr height='50px'><td class='ntList'>" + /*num*/nl.getNl_idx() + "</td><td style='font-size:15px; border-bottom:1px solid;'>" + nl.getNl_title() + "</td><td class='ntList'>" + nl.getAi_id() + "</td>" + 
		"<td class='ntList'>" + nl.getNl_date() + "</td></tr>");
//		num--;
	}
} else {
	out.println("<tr><td colspan='5' align='center'>검색결과가 없습니다.</td></tr>");
}
%>
</table>



<%@ include file="../inc/inc_foot.jsp" %>