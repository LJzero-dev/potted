<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>


<h2 style="display:inline; margin-left:20px;">SERVICE</h2>
<form style="display:inline; float:right;">
<div style="width:450px;"> <!--  게시판 내 검색창 시작-->
		<select name="schtype">
		<option value="tc" <c:if test="${si.getSchtype() eq 'a'}">selected="selected"</c:if>>전체🌱</option>
		<option value="title" <c:if test="${si.getSchtype() eq 'title'}">selected="selected"</c:if>>제목🌱</option>
		<option value="content" <c:if test="${si.getSchtype() eq 'content'}">selected="selected"</c:if>>내용🌱</option>
	</select>
	<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력해주세요." value="${si.getKeyword()}" style=" width:180px; border:0; font-size:10pt;" />
	<input type="image" name="submit" src="/potted/resources/images/product/search.png" width="20" class="btn" onclick="" />
</div>
</form>	<!--  게시판 내 검색창 종료-->
<hr color="#1cad0a" style="border-width:1px; height:1px; border:0;" />
<br /><br />
<div style="width:80%; margin:0 auto;">
	<div style="display:inline; font-size:22px; font-weight:bold;">
	${nl.getNl_title()}
	</div>
	<div style="display:inline; float:right; font-size:18px;">
	${nl.getAi_id()} | ${nl.getNl_date()}
	</div>
	<br />
	<hr style="border-width:1px;" />
	<br />
	<div style="font-size:18px;">
	${nl.getNl_content()}
	</div>
	<br />
	<hr style="border-width:1px;" />
	<br />
	<div align="right">
		<input type="button" class="bt" value="글목록" onclick="location.href='noticeList${args}';" />
	</div>
</div>




<%@ include file="../inc/inc_foot.jsp" %>