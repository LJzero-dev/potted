<%@page import="java.text.DecimalFormat"%>
<%@page import="com.mysql.cj.PingTarget"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
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
.share { width:84px; height:80px; border-radius: 50px; cursor: pointer; }
.shareTxt { text-align:center; font-size:14px; }
</style>
<script>
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
	<input type="hidden" name="pi_price" value="<%=pi.getPi_price()%>" />
	<input type="hidden" name="pi_img1" value="<%=pi.getPi_img1() %>" />
	<input type="hidden" name="pi_dc" value="<%=pi.getPi_dc()%>" />
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
		<span style="font-size:24px; font-weight: bold;"><%=realPrice %>원</span>
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
			<option value="<%=pos.getPos_idx() + ":" + pos.getPos_id() + "," + pos.getPos_price()%>"><%=pos.getPos_id() %>&nbsp;<%=pos.getPos_price() %></option>
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
			<div style="text-align:right; font-weight:bold;"><span id=""><%=realPrice %></span>원</div>
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
		<div style="margin-right:50px; font-size: 15px; font-weight:bold; margin-bottom:10px;" >구매 가격 : <span id="total"><%=realPrice %></span>원</div>
	</td></tr>
	<tr><td colspan="2" align="left">
		<input type="button" value="장바구니 담기" class="smt" onclick="buy('c');" />
		<input type="button" value="바로 구매하기" class="smt" onclick="buy('d');" />
	</td></tr>
<% } %>
	<tr><td align="center"><table style="margin-top:40px;">
	<tr><td><img src="/potted/resources/images/product/kakao.png" class="share" onclick="sendLinkDefault();" /></td><td width="10%"></td>
	<td><img src="/potted/resources/images/product/url.png" class="share" onclick="shareUrl();" /></td><td width="20%"></td></tr>
	<tr><td class="shareTxt">카카오톡 공유</td><td width="10%"></td><td class="shareTxt">URL 복사</td><td width="20%"></td></tr>
	</table></td></tr>
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
<table>
<tr><td><img src="" width="80" height="80"/></td></tr>
</table>
<hr />
</div>
</div>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
try {
   function sendLinkDefault() {
   Kakao.init('0c7b57fda6cd714148d4d0ef5fbdd8e9')
   Kakao.Link.sendDefault({
     objectType: 'feed',
     content: {
       title: 'POTTED',
       description: '<%=pi.getPi_name()%> | <%=realPrice%>원',
       imageUrl:'http://localhost:8086/ad_potted/resources/images/product/apple.png',
       link: {
         mobileWebUrl: 'https://developers.kakao.com',
         webUrl: 'http://localhost:8086/potted/productView?piid=<%=pi.getPi_id() %>',
       },
     },
     buttons: [
       {
         title: '자세히 보기',
         link: {
           mobileWebUrl: 'https://developers.kakao.com',
           webUrl: 'http://localhost:8086/potted/productView?piid=<%=pi.getPi_id() %>',
         },
       },
     ],
   })
}
; window.kakaoDemoCallback && window.kakaoDemoCallback() }
catch(e) { window.kakaoDemoException && window.kakaoDemoException(e) }

function shareUrl() {
	var url = "";
	var textarea = document.createElement("textarea");
	document.body.appendChild(textarea);
	url = window.document.location.href;
	textarea.value = url;
	textarea.select();
	document.execCommand("copy");
	document.body.removeChild(textarea);
	alert("URL이 복사되었습니다.")
}
</script>

<%@ include file="../inc/inc_foot.jsp" %>