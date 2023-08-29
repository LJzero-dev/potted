<%@page import="java.text.DecimalFormat"%>
<%@page import="com.mysql.cj.PingTarget"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="org.springframework.context.annotation.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
ProductInfo pi = (ProductInfo)request.getAttribute("productInfo");
List<ProductOptionBig> productOptionBig = (List<ProductOptionBig>)request.getAttribute("productOptionBig");


long realPrice = pi.getProductAuctionInfo().getPai_price();			// 수량 변경에 따른 가격 연산을 위한 변수
String price = pi.getPi_price() + "원";		// 가격 출력을 위한 변수
DecimalFormat formatter = new DecimalFormat("###,###,###,###");
%>
<style>
.imgs { width:80px; height:80px; cursor:pointer; }
#cnt { width:50px; height:15px; text-align:center; }
.so { background: #F5F5F5; text-align: left; width:400px; height:70px; padding: 20px 20px; }
.op { background: #F5F5F5; text-align: left; width:400px; height:50px; padding: 20px 20px; }
#del { border: 0; background: #F5F5F5; cursor:pointer; }
.smt { width:218px; height:30px; background:white; font-size: 15px; border-radius: 20px; border:1.5px solid  #6E6E6E; cursor: pointer; }
.smt:hover { border-color: #0B9649; background:#0B9649; color: white; }
#menu1 {}
#menu2 { display:none; }
</style>

<script>
// 상품 구매, 장바구니 이동시 들고갈 배열 
var arr = [];

function showBig(img){
	var big = document.getElementById("bigImg");
	//큰 이미지를 보여주는 img태그를 big이라는 이름의 객체로 받아옴.
	big.src = "/ad_potted/resources/images/product/" + img;
}

function buy() {
	var frm = document.frm;
// 옵션 정보 들어갈 부분
	var totalPrice = "<%=realPrice %>";
	document.getElementById("totalPrice").value = totalPrice;
	
	frm.action = "orderForm";
	frm.submit();
}


function updateTimer() {
	const future = Date.parse("<%=pi.getProductAuctionInfo().getPai_end() %>");
	const now = new Date();
	const diff = future - now;
	const days = Math.floor(diff / (1000 * 60 * 60 * 24));
	const hours = Math.floor(diff / (1000 * 60 * 60));
	const mins = Math.floor(diff / (1000 * 60));
	const secs = Math.floor(diff / 1000);

	const d = days;
	const h = hours - days * 24;
	const m = mins - hours * 60;
	const s = secs - mins * 60;
	if (diff < 0) {
	document.getElementById("timer").innerHTML ='<div>종료된 경매 입니다.</div>';
	} else {
	document.getElementById("timer").innerHTML ='<div>' + d + '<span>일 </span>' + h + '<span>시 </span>' + m + '<span>분 </span>' + s + '<span>초</span></div>';
	}
}
setInterval(updateTimer, 1000);	
var cmenu = 1;
function showMenu(num) {
// 상품 상세정보와 구매 후기를 보여주는 메소드
	var obj = document.getElementById("menu" + cmenu);
	obj.style.display = "none";
	
	var menu = document.getElementById("menu" + num); 
	menu.style.display = "block"; 
	cmenu = num;
}
function bid() {
	var bidPrice = document.getElementById("price").value;
	var nowPrice = <%=realPrice %>;
	if (bidPrice >= nowPrice + 500){
		$.ajax({
			type : "POST",
			data : {"bidPrice" : bidPrice, "piid" : '<%=pi.getPi_id()%>'},
			url : "./bid",
			success : function(chk) {
				if (chk == 2) {
					alert("입찰에 성공하였습니다.");
					location.reload();
				} else {
					alert("입찰에 실패하셨습니다.");
				}
			}
		});
	} else {
		alert("현제 가격에서 500원 추가된 금액부터 입찰 가능합니다.");
	}
}
</script>
<br /><br />
<div style="width:850px; margin:0 auto; ">
<table width="800" cellpadding="5">
<tr valign="top">
<td width="35%">
<!-- 이미지 관련 영역 -->
	<table width="100%" cellpadding="5" valign="top">
	<tr><td colspan="3" align="center">
		<img src="/ad_potted/resources/images/product/<%=pi.getPi_img1() %>" width="260" height="230" id="bigImg" />
	</td></tr>
	<tr align="center">
	<td width="33.3%">
		<img src="/ad_potted/resources/images/product/<%=pi.getPi_img1() %>" class="imgs"  onclick="showBig('<%=pi.getPi_img1() %>');" />
	</td>
	<td width="33.3%">
<% if (pi.getPi_img2() != null && !pi.getPi_img2().equals("")) { %>
		<img src="/ad_potted/resources/images/product/<%=pi.getPi_img2() %>" class="imgs" onclick="showBig('<%=pi.getPi_img2() %>');" />
<% } %>
	</td>
	<td width="33.3%">
<% if (pi.getPi_img3() != null && !pi.getPi_img3().equals("")) { %>
		<img src="/ad_potted/resources/images/product/<%=pi.getPi_img3() %>" class="imgs" onclick="showBig('<%=pi.getPi_img3() %>');" />
<% } %>
	</td>
	</tr>
	</table>
</td>
<td width="*">
<!-- 상품 정보 관련 영역 -->
	<form name="frm" method="post">
	<input type="hidden" name="kind" value="f" />
	<input type="hidden" name="isAuction" value="y" />
	<input type="hidden" name="cnt" value="1" />
	<input type="hidden" name="pi_id" value="<%=pi.getPi_id() %>" />
	<input type="hidden" name="pi_name" value="<%=pi.getPi_name()%>" />
	<input type="hidden" id="option" name="option" value="없음" /><!-- 옵션들어갈 부분 -->
	<input type="hidden" id="totalPrice" name="totalPrice" value="<%=realPrice %>" />
	<table width="100%" cellpadding="5" id="info" >
	<tr><td colspan="2">
		<a href="productList?pcb=<%=pi.getPcb_id() %>"><%=pi.getPcb_name() %></a>&nbsp; ‣ ‣ &nbsp;
		<a href="productList?pcb=<%=pi.getPcs_id().substring(0, 2) %>&pcs=<%=pi.getPcs_id() %>"><%=pi.getPcs_name() %></a>
	</td></tr>
	<tr>
	<td style="font-size:35px;"><strong><%=pi.getPi_name() %></strong></td>
	</tr>
	<tr valign="left" ><td >
		<span style="font-size:24px; font-weight: bold;">남은 시간 : <span style="position:absolute;" id="timer"></span></span>
	</td></tr>
	<tr valign="left" ><td >
		<span style="font-size:24px; font-weight: bold;">현재 가 : <%=formatter.format(realPrice) %>원</span>
	</td></tr>
	<tr><td><hr />
	</td></tr>
	<tr>
	<td>
	<table width="100%" cellpadding="5" id="info" >
	<tr>
	<td width="50%">※주의사항<br />낙찰 후 당일 포함 3일이내(24:00시까지)미주문시 낙찰취소 되어 주문하실 수 없으며,미주문 횟수에 따라 입찰제한이<br />있으니 주의 바랍니다.
	</td><td width="50%"><table width="100%" cellpadding="5" id="info" >
		<tr>
			<td colspan="3" align="center">입찰 내역</td>			
		</tr>
		<tr>
			<td width="30%">입찰자</td><td width="30%">금액</td><td width="40%">입찰 시간</td>
		</tr>
		<% if (pi.getProductAuctionInfo().getAuctionBidderInfo() != null && pi.getProductAuctionInfo().getAuctionBidderInfo().size() > 0 ) {
			for (AuctionBidderInfo abi : pi.getProductAuctionInfo().getAuctionBidderInfo()) { %>
		<tr>
			<td><%=abi.getMi_id() %></td><td><%=formatter.format(abi.getAbi_price()) %></td><td><%=abi.getPai_date() %></td>
		</tr>
		<% }
		} %>
	</table></td>
	</tr>
	</table>
	</td>
	</tr>
	<tr><td colspan="2" align="center">
	<%if (pi.getProductAuctionInfo().getIsend() == 1) { %>	
		종료된 경매 입니다.<br />
	<% if(loginInfo != null && loginInfo.getMi_id().equals(pi.getProductAuctionInfo().getPai_id()) 
	&& Integer.parseInt(String.valueOf(LocalDate.now()).replace("-", "")) - 3 < Integer.parseInt(pi.getProductAuctionInfo().getPai_end().substring(0,10).replace("-", "")) &&
	pi.getPi_status().equals("y")) {%>
		입찰에 성공하셨습니다.<br />
		<input type="button" value="결제 하기" class="smt" onclick="buy();" />
	<% } else { %>
		<input type="text" value="결제 가능 시간이 아닙니다."/>
	<%	} %>
		<% } else { %>
				입찰 금액 : <input type="text" id="price" name="price" />
		<input type="button" value="입찰 하기" class="smt" onclick="bid();" />
		<% } %>
	</td></tr>
	</table>
	</form>
</td>
</tr>
</table>
<br /><br />
<!-- 상품 상세 정보 및 구매 후기 영역 -->
<p style="margin-left: 330px;">상품 상세 정보</p>
<hr style="margin-left:0px; width:740px;" />
<br />
<div class="productDetail" id="menu1">
<img src="" style="width:740px; height:2000px; " />
</div>

</div>

<script>updateTimer();</script>
<%@ include file="../inc/inc_foot.jsp" %>