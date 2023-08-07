<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.bimg {padding:10px; margin-right:10px; border:1px solid #000;}
</style>
</head>
<body>
<h2>홈화면 배너 이미지를 설정해주세요</h2>
<span>※이미지는 최소 1개 최대 3개까지 가능합니다.</span>
<br /><br />
<form name="frm" action="setbannerProc">
<table>
	<tr><td>배너이미지 1 : </td><td><input type="file" class="bimg" name="bl_img1" /></td></tr>
	<tr><td>배너이미지 2 : </td><td><input type="file" class="bimg" name="bl_img2" /></td></tr>
	<tr><td>배너이미지 3 : </td><td><input type="file" class="bimg" name="bl_img3" /></td></tr>
</table>
	<input type="button" value="취소" /><input type="button" value="설정완료" />
</form>
</body>
</html>