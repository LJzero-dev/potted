<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
<tr>
<th>no</th>
<th>회원ID</th>
<th>구매금액</th>
<th>회원가입일</th>
<th>최종 접속일</th>
</tr>
<c:if test="${memberList.size() > 0}">
	<c:forEach items="${memberList}" var="mi" varStatus="status">
	<tr height="40">
	<td align="center" class="ntList">${status.index}</td>
	<td align="center" class="ntList">${mi.getMi_id()}</td>
	<td align="center" class="ntList"></td>
	<td align="center" class="ntList">${mi.getMi_lastlogin()}</td>
	</tr>
	</c:forEach>
</c:if>
</table>

</body>
</html>
