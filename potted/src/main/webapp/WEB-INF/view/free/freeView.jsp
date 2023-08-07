<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<c:set var="loginInfo" value="<%=loginInfo %>" />
<script>
function rInsert(flidx) {
	var rcon = document.frm.rcontent.value;
		if(rcon != "" || rcon != null){
		$.ajax({
			type : "POST", url : "/potted/replyIn", data : { "flidx" : flidx, "rcon" : rcon },
			success : function(chk) {
				if (chk != 2 && chk != 1 ) {	// 댓글 등록과 게시판 리스트 댓글증가가  실패했을 경우
					alert("댓글 등록을 실패했습니다 \n다시 시도해 주세요.");
				} else {	// 댓글 등록이 성공했을경우
					location.href = "freeView?cpage=1&flidx=" + flidx;
				}
			}
		});
	} else {
		alert("내용 안쓸꺼니?");
	}
}


	function rDel(fridx, flidx) {
		if(confirm("정말 삭제하시겠습니까?")){
			location.href = "replyDel?fridx=" + fridx + "&flidx=" + flidx;
		}
	}
</script>
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
	<img src="/potted/resources/images/free/${fl.getFl_img1()}" width="200" height="200" />
	<br /><br />
	</c:if>
	<!--  이미지1이 없을 때 -->
	<c:if test="${fl.getFl_img1() == null || fl.getFl_img1() == ''}">
	<br />
	</c:if>
	<!--  이미지2가 있을 때 -->
	<c:if test="${fl.getFl_img2() != null && fl.getFl_img2() != ''}">
	<img src="/potted/resources/images/free/${fl.getFl_img2()}" width="200" height="200" />
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
		<c:if test="${loginInfo.getMi_id() == rl.getMi_id()}">
		<input type="button" class="bt" value="수정" onclick="" />&nbsp;&nbsp;
		<input type="button" class="bt" value="삭제" onclick="" />
		</c:if>
		</div>
</div>
<br /><br /><br />
<!--  게시글 내용 종료 -->
<hr style="border-width:1px;" />
<!--  댓글 내용 시작 -->
<form name="frm" method="post">
	<table style="width:100%;" cellpadding="0" cellspacing="0">
	<tr height="60">
	<td align="center" width="20%" style="font-size:18px;"><strong>${loginInfo.getMi_name()}</strong></td>
	<td width="75%"><input type="text" name="rcontent" style="width:800px; height:60px;" placeholder="댓글을 입력해주세요.엔터금지" value="" /></td>
	<td width="5%">&nbsp;&nbsp;<input type="button" id="btn" value="등록" class="bt" onclick="rInsert(${fl.getFl_idx()});"></td>
	</tr><tr height="30" style="border-style: double;"><td colspan="3" style="border:0; border-bottom:2px; border-style: double;"></td></tr>
	</tr><tr height="10" style="border-style: double;"><td colspan="3" style="border:0; border-bottom:2px; border-style: double;"></td></tr>
	<c:if test="${replyList.size() > 0}">
		<c:forEach items="${replyList}" var="rl" varStatus="status">
		<tr height="60">
		<td width="20%" class="rtList"><strong>${rl.getMi_name()}</strong></td>
		<td width="*" class="rcList">${rl.getFr_content()}</td>
		<td width="20%" class="rdList">${rl.getFr_date()}
		<c:if test="${loginInfo.getMi_id() == rl.getMi_id()}">
			<input type="button" class="bt" onclick="rDel('${rl.getFr_idx()}', '${fl.getFl_idx()}');" value="댓글삭제" /></td>
		</c:if>
		</tr>
		</c:forEach>
	</c:if>
	</table>
</form>
	<!--  댓글 내용 종료 -->
</div>







<%@ include file="../inc/inc_foot.jsp" %>