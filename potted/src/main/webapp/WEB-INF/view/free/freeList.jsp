<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%@ include file="../inc/inc_head.jsp" %>

<h2 style="display:inline;">COMMUNITY</h2>
<form style="display:inline; float:right;">
<div style="width:450px;">
		<select name="fs" onchange="" >
		<option value="a">전체</option>
		<option value="b">작성자</option>
		<option value="c">제목</option>
		<option value="d">내용</option>
		<option value="e">제목 + 내용</option>
	</select>
	<input type="text" name="pdt" id="pdt" placeholder="검색어를 입력해주세요." value="" style=" width:180px; border:0; font-size:10pt;" />
	<input type="image" name="submit" src="/potted/resources/images/product/search.png" width="20" class="btn" onclick="" />
</div>
</form>
<hr color="#1cad0a" style="border-width:1px; height:1px; border:0;" />
<br /><br />
<table width="80%" height="80px" border="0" align="center">
<tr>
<th width="5%" class="nhList">번호</th>
<th width="*" class="nhList">제목</th>
<th width="15%" class="nhList">작성자</th>
<th width="20%" class="nhList">날짜</th>
<th width="10%" class="nhList">조회</th>
</tr>
</table>



<%@ include file="../inc/inc_foot.jsp" %>