<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
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
<!--  게시글 내용 시작 -->
<div style="width:80%; margin:0 auto;">
	<div style="display:inline; font-size:22px; font-weight:bold;">
	${fl.getFl_title()}
	</div>
	<div style="display:inline; float:right; font-size:18px;">
	${fl.getFl_writer()} | ${fl.getFl_date()}&nbsp;&nbsp;조회 : ${fl.getFl_read()}
	</div>
	<br />
	<hr style="border-width:1px;" />
	<br />
	<div style="font-size:18px;">
	${fl.getFl_content()}
	</div>
	<br /><br />
	<!--  이미지1이 있을 때 -->
	<c:if test="${fl.getFl_img1() != null && fl.getFl_img1() != ''}">
	<img src="/potted/resources/images/free/${fl.getFl_img1()}" />
	<br /><br />
	</c:if>
	<!--  이미지1이 없을 때 -->
	<c:if test="${fl.getFl_img1() == null || fl.getFl_img1() == ''}">
	<br />
	</c:if>
	<!--  이미지2가 있을 때 -->
	<c:if test="${fl.getFl_img2() != null && fl.getFl_img2() != ''}">
	<img src="/potted/resources/images/free/${fl.getFl_img2()}" />
	<br />
	</c:if>
	<!--  이미지2가 없을 때 -->
	<c:if test="${fl.getFl_img2() == null || fl.getFl_img2() == ''}">
	<br />
	</c:if>
	<br />
<hr style="border-width:1px;" />
	<br />
	<div>
		<div style="float:left; font-size:16px;">
		댓글 : ${fl.getFl_reply()}
		</div>
		<div style="float:right;">
		<input type="button" class="bt" value="글목록" onclick="location.href='freeList${args}';" />&nbsp;&nbsp;
		<input type="button" class="bt" value="목록" onclick="" />&nbsp;&nbsp;
		<input type="button" class="bt" value="삭제" onclick="" />
		</div>
	</div>
	<br /><br /><br />
	<!--  게시글 내용 종료 -->
	<hr style="border-width:1px;" />
	<!--  댓글 내용 시작 -->
	<table style="width:70%;" cellpadding="0" cellspacing="0">
	<tr height="20">
	<td align="center" width="20%" class="rtList">${fl.getFl_writer()}</td>
	<td width="*"><input type="text" name="" id="" placeholder="댓글을 입력해주세요" /></td>
	</tr>
	<c:if test="${replyList.size() > 0}">
		<c:forEach items="${replyList}" var="rl" varStatus="status">
		<tr height="20">
		<td width="20%" class="rtList">${fl.getFl_writer() - status.index}</td>
		<td width="*" class="rtList">${fr.getFr_content()}</td>
		<td width="20%" class="rtList">${fr.getFr_date()}</td>
		</tr>
		</c:forEach>
	</c:if>
	</table>
	<!--  댓글 내용 종료 -->
</div>







<%@ include file="../inc/inc_foot.jsp" %>