<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>


<h2 style="display:inline; margin-left:20px;">SERVICE</h2>
<form style="display:inline; float:right;">
<div style="width:450px;"> <!--  게시판 내 검색창 시작-->
		<select name="schtype">
		<option value="tc" <c:if test="${si.getSchtype() eq 'tc'}">selected="selected"</c:if>>전체🌱</option>
		<option value="title" <c:if test="${si.getSchtype() eq 'title'}">selected="selected"</c:if>>제목🌱</option>
		<option value="content" <c:if test="${si.getSchtype() eq 'content'}">selected="selected"</c:if>>내용🌱</option>
	</select>
	<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력해주세요." value="${si.getKeyword()}" style=" width:180px; border:0; font-size:10pt;" />
	<input type="image" name="submit" src="/potted/resources/images/product/search.png" width="20" class="btn" onclick="" />
</div>
</form>	<!--  게시판 내 검색창 종료-->
<hr color="#1cad0a" style="border-width:1px; height:1px; border:0;" />
&nbsp;&nbsp;&nbsp;&nbsp;<h3 style="display:inline;"><a href="noticeList">공지사항</a></h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<h3 style="display:inline;"><a href="mapList">맵</a></h3>
<br /><br />
<!--  게시글 리스트 시작 -->
<table width="60%" height="80px" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<th width="10%" class="nhList">번호</th>
<th width="*" class="nhList">제목</th>
<th width="15%" class="nhList">작성자</th>
<th width="20%" class="nhList">날짜</th>
</tr>
<c:if test="${noticeList.size() > 0}">
	<c:forEach items="${noticeList}" var="nl" varStatus="status">
	<tr height="40">
	<td align="center" class="ntList">${si.getNum() - status.index}</td>
	<td class="ndList"><a href="noticeView?nlidx=${nl.getNl_idx()}${si.getArgs()}">${nl.getNl_title()}</a></td>
	<td align="center" class="ntList">${nl.getAi_id()}</td>
	<td align="center" class="ntList">${nl.getNl_date()}</td>
	</tr>
	</c:forEach>
</c:if>
<c:if test="${noticeList.size() == 0}">
	<tr><td colspan="5" align="center"	>
		검색 결과가 없습니다.
	</td></tr>
</c:if>
</table>
<!--  게시글 리스트 종료 -->

<!--  게시판리스트 페이징 시작 -->
<br />
<table width="*" cellpadding="5" align="center">
<tr>
<td width="*">
<c:if test="${noticeList.size() > 0}">
	
	<c:if test="${si.getCpage() == 1}">
		<<&nbsp;&nbsp;&nbsp;<&nbsp;&nbsp;
	</c:if>
	<c:if test="${si.getCpage() > 1}">
		<a href="noticeList?cpage=1${si.getSchargs()}"><<</a>&nbsp;&nbsp;&nbsp;
		<a href="noticeList?cpage=${si.getCpage() - 1}${si.getSchargs()}"><</a>&nbsp;&nbsp;
	</c:if>
	
	<c:forEach var="i" begin="${si.getSpage()}" end="${si.getSpage() + si.getBsize() - 1 < si.getPcnt() ? si.getSpage() + si.getBsize() - 1 : si.getPcnt()}">
		<c:if test="${i == si.getCpage()}">
			&nbsp;<strong>${i}</strong>&nbsp;
		</c:if>
		<c:if test="${i != si.getCpage()}">
			&nbsp;<a href="noticeList?cpage=${i}${si.getSchargs()}">${i}</a>&nbsp;
		</c:if>
	
	</c:forEach>
	
	<c:if test="${si.getCpage() == si.getPcnt()}">
		&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;>>
	</c:if>
	<c:if test="${si.getCpage() < si.getPcnt()}">
		&nbsp;&nbsp;<a href="noticeList?cpage=${si.getCpage() + 1}${si.getSchargs()}">></a>
		&nbsp;&nbsp;&nbsp;<a href="noticeList?cpage=${si.getPcnt()}${si.getSchargs()}">>></a>
	</c:if>
</c:if>	
</td>
</tr>
</table>
<!--  게시판리스트 페이징 종료 -->
<%@ include file="../inc/inc_foot.jsp" %>