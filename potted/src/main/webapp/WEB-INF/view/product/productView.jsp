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

List<ProductOptionStock> productOptionStock = (List<ProductOptionStock>)request.getAttribute("productOptionStock");
List<ProductOptionBig> productOptionBig = (List<ProductOptionBig>)request.getAttribute("productOptionBig");


long realPrice = pi.getPi_price();			// 수량 변경에 따른 가격 연산을 위한 변수
String price = pi.getPi_price() + "원";		// 가격 출력을 위한 변수
if (pi.getPi_dc() > 0) {	// 할인율이 있으면
	realPrice = Math.round(realPrice * (1 - pi.getPi_dc()));
	price = "<del>" + pi.getPi_price() + "</del>&nbsp;&nbsp;&nbsp;";
}

int total = 0;
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
.btn1 { border: 0; width:350px; font-size: 14px; background: #fff; padding-bottom: 8px; cursor: pointer; }
.btn1:hover { font-weight: bold; }
.btn2 { border: 0; width:350px; font-size: 14px; background: #fff; padding-bottom: 8px; cursor: pointer; }
.btn2:hover { font-weight: bold; }
#menu1 {}
#menu2 { display:none; }
</style>
<script>
// 상품 구매, 장바구니 이동시 들고갈 배열 
var arr = [];

function showBig(img){
	var big = document.getElementById("bigImg");
	//큰 이미지를 보여주는 img태그를 big이라는 이름의 객체로 받아옴.
	big.src = "/potted/resources/images/product/" + img;
}

function opDel(idx) {
	// 선택했던 옵션을 지워주는 메소드	
 	const div = document.getElementById(idx);
	var tp = document.getElementById("total").innerHTML;
	var opprice = document.getElementById(idx+"p").innerHTML;
//	alert(opprice);
//	alert(tp);
	document.getElementById("total").innerHTML = Number(tp) - opprice;

	div.remove();
}

function selectOption(tmp){
// 옵션을 선택하면 하단에 선택한 옵션이 추가되고 구매 총 금액이 바뀌는 메소드
	var idx = tmp.substring(0, tmp.indexOf(":"));
	var op = tmp.substring(tmp.indexOf(":") + 1, tmp.indexOf(","));
	var opprice = Number(tmp.substring(tmp.indexOf(",") + 1));
	

	var opinfo = "<div id='" + idx + "'><div class='op'><span style='font-weight: bold; font-size: 15px;'>&nbsp;" + op + 
	"</span><input type='button' id='del' value='X' style='float:right;' onclick=opDel(" + idx + "); /><br /><hr style='border-width:1px 0 0 0; border-style:dotted; border-color:#bbb;' />" + 
	"<div style='text-align:right; font-weight:bold;'><span id='" + idx + "p'>" + opprice + "</span>원</div></div><br /></div>";
	
	document.getElementById("addOp").innerHTML = document.getElementById("addOp").innerHTML+ "" + opinfo + "";
	arr.push(idx);
	document.getElementById("option").value = arr;
	
	
	var tp = document.getElementById("total").innerHTML;
//	alert(opprice);
//	alert(tp);
	document.getElementById("total").innerHTML = Number(tp) + opprice;
	
	document.getElementById("opprice").value = opprice;
	
	
	
	
}

function setCnt(num){
	var price = <%=realPrice %>;
	var cnt = parseInt(frm.cnt.value);
	var max = <%=pi.getPi_stock()%>
	var total = document.getElementById("total").innerHTML;
	if (num == "+" && cnt < max) {
		document.frm.cnt.value = cnt + 1;
		document.getElementById("total").innerHTML = Number(total) + formatter.format(price);
	}		
	if (num == "-" && cnt > 1) {
		document.frm.cnt.value = cnt - 1;
		document.getElementById("total").innerHTML = Number(total) - formatter.format(price);
	}
}


function buy(kind) {
	var frm = document.frm;
// 옵션 정보 들어갈 부분
	var totalPrice = document.getElementById("total").innerHTML;
	document.getElementById("totalPrice").value = totalPrice;
	var option = frm.option.value;
	var cnt = frm.cnt.value;
	var price = frm.totalPrice.value;
	
	if (kind == "c") {	// 장바구니 담기일 경우
		$.ajax({
			type : "POST", url : "/potted/cartProc", data : {"piid" : "<%=pi.getPi_id()%>", "option" : option, "cnt" : cnt, "price" : price},
			success : function(chkRs) {
				if (chkRs == 0) {	// 장바구니 담기에 실패했을 경우
					alert("장바구니 담기에 실패했습니다.\n다시 시도해 보세요.");
				} else {	// 장바구니 담기에 성공했을 경우
					if (confirm("장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?")){
						location.href = "cartView";
					}
				}
			}
		});
	} else {	// 바로 구매하기일 경우
//		alert(totalPrice);
		frm.action = "orderForm";
		frm.submit();
	}
}

var cmenu = 1;
function showMenu(num) {
// 상품 상세정보와 구매 후기를 보여주는 메소드
	var obj = document.getElementById("menu" + cmenu);
	obj.style.display = "none";
	
	var menu = document.getElementById("menu" + num); 
	menu.style.display = "block"; 
	cmenu = num;
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
		<img src="/potted/resources/images/product/<%=pi.getPi_img1() %>" width="260" height="230" id="bigImg" />
	</td></tr>
	<tr align="center">
	<td width="33.3%">
		<img src="/potted/resources/images/product/<%=pi.getPi_img1() %>" class="imgs"  onclick="showBig('<%=pi.getPi_img1() %>');" />
	</td>
	<td width="33.3%">
<% if (pi.getPi_img2() != null && !pi.getPi_img2().equals("")) { %>
		<img src="/potted/resources/images/product/<%=pi.getPi_img2() %>" class="imgs" onclick="showBig('<%=pi.getPi_img2() %>');" />
<% } %>
	</td>
	<td width="33.3%">
<% if (pi.getPi_img3() != null && !pi.getPi_img3().equals("")) { %>
		<img src="/potted/resources/images/product/<%=pi.getPi_img3() %>" class="imgs" onclick="showBig('<%=pi.getPi_img3() %>');" />
<% } %>
	</td>
	</tr>
	</table>
</td>
<td width="*">
<!-- 상품 정보 관련 영역 -->
<%
String dc = "", delprice = "";
if (pi.getPi_dc() != 0) {
	dc = (pi.getPi_dc() * 100) + "";
	dc = dc.substring(0, dc.indexOf(".")) + "%";
	delprice = price;
} else {
	dc = "";
	price = "";
}

%>
	<form name="frm" method="post">
	<input type="hidden" name="kind" value="d" />
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
	<tr><td><%=price %></td></tr>
	<tr valign="left" ><td >
		<span style="color:#0B9649; font-size:20px; font-weight: bold; margin-right:8px;"><%=dc %></span>
		<span style="font-size:24px; font-weight: bold;"><%=formatter.format(realPrice) %>원</span>
	</td></tr>
	
<% 
int i = 0, j = 0;
if (productOptionStock.size() > 0) {
	for (i = 0 ; i < productOptionBig.size() ; i++) {
		ProductOptionBig pob = productOptionBig.get(i);
%>
		<tr><td><%=pob.getPob_id().substring(2) %></td></tr>
		<tr><td><select name="opb" onchange="selectOption(this.value);">
			<option value="no"><%=pob.getPob_id() %>&nbsp;(선택)</option>
<%
		for (j = 0 ; j < productOptionStock.size() ; j++) {
			ProductOptionStock pos = productOptionStock.get(j);
			if (pob.getPob_id().equals(pos.getPob_id())){
%>
			<option value="<%=pos.getPos_idx() + ":" + pos.getPos_id() + "," + pos.getPos_price()%>"><%=pos.getPos_id() %>&nbsp;<%=formatter.format(pos.getPos_price()) %></option>
<%
			}
		}
%>
		</select></td>
		</tr>
<%
	}
}
%>
	<tr><td>
		<div class="so">
			<span style="font-weight: bold; font-size: 15px;"><%=pi.getPi_name() %>&nbsp;🌱</span>
			<br /><hr style="border-width:1px 0 0 0; border-style:dotted; border-color:#bbb;" />수량
			<input type="button" value="-" onclick="setCnt(this.value);" />
			<input type="text" name="cnt" id="cnt" value="1" readonly="readonly" />
			<input type="button" value="+" onclick="setCnt(this.value);" />
			<div style="text-align:right; font-weight:bold;"><span id=""><%=formatter.format(realPrice) %></span>원</div>
		</div>
	</td></tr>
	<tr><td><span id="addOp"></span></td></tr>
<%
if (pi.getPi_stock() <= 0) {
%> 
	<tr><td><div style="padding: 6px 20px; font-size: 20px; color: white; text-align: center; width:400px; height:30px; 
	border:0px; margin-bottom:10px; background: #EC3E3E; border-radius: 20px;">SOLD OUT!</div>!현재 조회하신 상품이 재입고 대기 중입니다!</td></tr>
<% } else { %>
	<tr><td colspan="2" align="right" >
		<div style="margin-right:50px; font-size: 15px; font-weight:bold;" >구매 가격 : <span id="total"><%=formatter.format(realPrice) %></span>원</div>
	</td></tr>
	<tr><td colspan="2" align="left">
		<input type="button" value="장바구니 담기" class="smt" onclick="buy('c');" />
		<input type="button" value="바로 구매하기" class="smt" onclick="buy('d');" />
	</td></tr>
<% } %>
	</table>
	</form>
</td>
</tr>
</table>
<br /><br />
<!-- 상품 상세 정보 및 구매 후기 영역 -->
<input type="button" class="btn1" value="상품 상세 정보" onclick="showMenu(1);" />
<input type="button" class="btn2" value="구매후기" onclick="showMenu(2);"/>
<hr style="margin-left:0px; width:740px;" />
<br />
<div class="productDetail" id="menu1">
<img src="" style="width:740px; height:2000px; " />
</div>
<div class="productReview" id="menu2">
구매후기 내용~~~
</div>

</div>


<%@ include file="../inc/inc_foot.jsp" %>