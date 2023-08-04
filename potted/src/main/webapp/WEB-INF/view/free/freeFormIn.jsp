<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<c:set var="loginInfo" value="<%=loginInfo %>" />
<h1 style="display:inline; margin-left:20px;">COMMUNITY</h1>
<form style="display:inline; float:right;">
<div style="width:450px;"> <!--  게시판 내 검색창 시작-->
		<select name="schtype">
		<option value="title" <c:if test="${si.getSchtype() eq 'title'}">selected="selected"</c:if>>제목🌱</option>
		<option value="writer" <c:if test="${si.getSchtype() eq 'writer'}">selected="selected"</c:if>>작성자🌱</option>
		<option value="content"  <c:if test="${si.getSchtype() eq 'content'}">selected="selected"</c:if>>내용🌱</option>
		<option value="tc" <c:if test="${si.getSchtype() eq 'tc'}">selected="selected"</c:if>>제목 + 내용🌱</option>
	</select>
	<input type="text" name="keyword" id="pdt" placeholder="검색어를 입력해주세요." value="" style=" width:180px; border:0; font-size:10pt;" />
	<input type="image" name="submit" src="/potted/resources/images/product/search.png" width="20" class="btn" />
</div>
</form>	<!--  게시판 내 검색창 종료-->
<hr color="#1cad0a" style="border-width:1px; height:1px; border:0;" />
<br /><br />
<!--  게시글 등록 폼 시작 -->
<form name="frmBbs" action="freeProcIn" method="post" enctype="multipart/form-data">
<table width="70%" align="center" cellpadding="0" cellspacing="0">
	<tr>
	<td width="*" class="ndList">
		<input type="text" name="fl_title" placeholder="제목을 입력해주세요" style="width:1200px; height:20; border:0; font-size:16pt; resize:none;" />
	</td>
	<td width="20%" class="rdList">${loginInfo.getMi_name()}</td>
</table>
<br /><br />
<div align="center"><!-- 게시글 내용 입력 -->
	<textarea name="fl_content" cols="185" rows="25" placeholder="내용을 입력해주세요." style="border:none; font-size:16px;"></textarea>
</div>
<br /><br /><!--  첨부파일 -->
<div style="margin-left:300px; font-size:20px;">
	<input type="file" name="uploadFile" multiple="multiple" />
</div>
<br />
<div align="right" style="margin-right:300px;">
	<input type="submit" class="bt" value="등록" />
</div>
</form>
<!--  게시글 등록 폼 시작 -->

<%@ include file="../inc/inc_foot.jsp" %>