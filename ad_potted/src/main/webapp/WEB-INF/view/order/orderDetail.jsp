<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
input {	padding:2px 2px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; }
#title { font-size:20px; font-weight: bold; }
#listbox { margin-left:60px; }
#table th, td{ font-weight: lighter; border:1.5px solid #CFD4CD; }
#table { border:1.5px solid #CFD4CD; border-collapse:collapse; text-align:center; }
#table tr { width:620px; height:50px; }
.isDone { font-size:13px; }
.orderPop {position:absolute; width:425px; top:45%; left:45%; transform:translate(-50%,-50%); border:1px solid #00b564; background:#fff;}
.orderPop .odBox {padding:20px; overflow:hidden; border-bottom:1px solid silver;}
.orderPop .odBox > span {float:left; width:130px; font-size:15px; font-weight:bold; color:#7d7d7d;}
.orderPop .odView {float:left; width:66%;}
.orderPop .odView span {font-weight:bold; font-size:14px;}
.orderPop .btnBox {display:flex;}
.orderPop .btnBox input {font-size:16px; border:0;}
.orderPop .btnBox input:hover {text-decoration:underline;}
.orderPop .btnBox a, .orderPop .btnBox input {width:50%; text-align:center; padding:20px 0; border-radius:0; background:#00b564; color:#fff; cursor:pointer;}
.orderPop .btnBox a {color:#00b564; background:#fff; border:1px solid #00b564;} 
</style>
</head>
<body>
	<!-- 주문 정보 팝업 -->
	<div class="orderPop">
		<div class="odBox odNum">
			<span>주문 번호</span>
			<div class="odView">
				<span>${orderInfo.oi_id}</span>
			</div>
		</div>
		<div class="odBox odPc">
			<span>주문 금액</span>
			<div class="odView">
				<span>${orderInfo.oi_pay}원</span>
			</div>
		</div>
		<div class="odBox odIf">
			<span>상품 정보</span>
			<div class="odView">
				<span>${orderInfo.od_name}</span><br />
				<span>
					<c:forEach var="option" items="${fn:split(orderInfo.od_option, ',')}">
	                    ${option}<br>
	                </c:forEach>
                </span>
			</div>
		</div>
		<div class="odBox odAdd">
			<span>배송지 정보</span>
			<div class="odView">
				<span>${orderInfo.oi_name }</span><br />
				<span>${orderInfo.oi_phone }</span><br />
				<span>${orderInfo.oi_zip }</span><br />
				<span>${orderInfo.oi_addr1 }</span><br />
				<span>${orderInfo.oi_addr2 }</span>
			</div>
		</div>
		<div class="odBox odMm">
			<span>상품 메모</span>
			<div class="odView">
				<span>${orderInfo.oi_memo }</span>				
			</div>
		</div>
		<div class="odBox odMm">
			<span>배송상태 변경</span>
			<form>
			<div class="odView">
				<input type="radio" name="situation" id="ptwait" <c:if test="${orderInfo.oi_status eq 'a'}">checked="checked"</c:if> /><label for="ptwait">배송대기</label>
				<input type="radio" name="situation" id="pting" <c:if test="${orderInfo.oi_status eq 'b'}">checked="checked"</c:if> /><label for="pting">배송중</label>
				<input type="radio" name="situation" id="ptcomt" <c:if test="${orderInfo.oi_status eq 'c'}">checked="checked"</c:if> /><label for="ptcomt">배송완료</label>				
			</div>
			</form>
		</div>
		<div class="btnBox">
			<input type="submit" value="저장" />
			<a href="javasciprt:void(0);" onclick="window.close();">닫기</a>
		</div>		
	</div>
</body>
</html>