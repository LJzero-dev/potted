<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
BannerList bl = (BannerList)request.getAttribute("bl");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.bimg {padding:10px; margin-right:10px; border:1px solid #000;}
.nimg { width:200px; height:100px; }
.title { font-size:24px; font-weight:bold; }
.now { border:1px solid #0B9649; }
#caution { border:1px solid #0B9649; padding:10px; width:600px; }
#ctxt { font-size:20px; font-weight:bold; color:red; }
input {padding:6px 12px; border-radius:6px; color:#495057; border:1px solid #ced4da; cursor:pointer; }
input:hover { background-color:#ced4da; }
input:active { background-color:#6B727A; }
</style>
</head>
<body>
<h2>홈화면 배너 이미지를 설정해주세요</h2>
<div id="caution">
<span id="ctxt">주의 사항</span><br />
※이미지는 최소 1개 최대 4개까지 가능합니다.<br />
※변경할 이미지 항목에 파일을 선택하고 [설정] 버튼을 눌러주세요.
</div>
<br /><br />
<div>
<span class="title">현재 배너 이미지</span><br />
※이미지가 나타나지 않는 경우 새로고침 버튼을 눌러주세요.
<input type="button" onclick="location.href='http://localhost:8086/ad_potted/setbanner'" value="새로고침" />
<table class="now" cellpadding="10" cellspacing="10">
<tr><th>배너이미지 1</th><th>배너이미지 2</th><th>배너이미지 3</th><th>배너이미지 4</th></tr><tr>
<td><img class="nimg" src="http://localhost:8086/ad_potted/resources/images/banner/<%=bl.getBl_img1() %>" /><br /></td>
<td><img class="nimg" src="http://localhost:8086/ad_potted/resources/images/banner/<%=bl.getBl_img2() %>" /><br /></td>
<td><img class="nimg" src="http://localhost:8086/ad_potted/resources/images/banner/<%=bl.getBl_img3() %>" /><br /></td>
<td><img class="nimg" src="http://localhost:8086/ad_potted/resources/images/banner/<%=bl.getBl_img4() %>" /><br /></td>
</tr></table></div><br /><br />
<span class="title">변경할 배너 이미지</span>
<table class="now" cellpadding="10" cellspacing="10">
	<tr><td>배너이미지 1 : </td><td><form name="frm" action="setbannerProc" method="post" enctype="multipart/form-data"><input type="hidden" name="imgNumber" value="1" /><input type="file" class="bimg" name="uploadFile" multiple="multiple" />&nbsp;<input type="submit" value="설정" /></form></td></tr>
	<tr><td>배너이미지 2 : </td><td><form name="frm" action="setbannerProc" method="post" enctype="multipart/form-data"><input type="hidden" name="imgNumber" value="2" /><input type="file" class="bimg" name="uploadFile" multiple="multiple" />&nbsp;<input type="submit" value="설정" /></form></td></tr>
	<tr><td>배너이미지 3 : </td><td><form name="frm" action="setbannerProc" method="post" enctype="multipart/form-data"><input type="hidden" name="imgNumber" value="3" /><input type="file" class="bimg" name="uploadFile" multiple="multiple" />&nbsp;<input type="submit" value="설정" /></form></td></tr>
	<tr><td>배너이미지 4 : </td><td><form name="frm" action="setbannerProc" method="post" enctype="multipart/form-data"><input type="hidden" name="imgNumber" value="4" /><input type="file" class="bimg" name="uploadFile" multiple="multiple" />&nbsp;<input type="submit" value="설정" /></form></td></tr>
</table>
</body>
</html>