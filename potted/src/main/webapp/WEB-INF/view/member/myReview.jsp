<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
ArrayList<ReviewList> reviewList = (ArrayList<ReviewList>)request.getAttribute("reviewList");
%>
<c:set var="loginInfo" value="<%=loginInfo %>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style>
input {	padding:5px 12px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; }
#title { font-size:20px; font-weight: bold; }
#listbox { margin-left:60px; }
#table { border-bottom:1.5px solid #CFD4CD; border-collapse:collapse; text-align:left; }
.rimg { width:120px; hegiht:120px; }
</style>
</head>
<body>
<!-- 회원 후기 리스트 시작 -->
<div id="listbox"><br />
	<span id="title">나의 후기</span>
	<br /><br />
	<div v-for="item in reviewArr" :key="item.rlidx">
	<review-list :object="item" v-on:review-del="reviewDel"></review-list>
	</div>
	<div style="margin-left:300px;">
	<c:if test="${pi.getRcnt() > 0}">
		<c:if test="${pi.getCpage() == 1}">
			<<&nbsp;&nbsp;&nbsp;<&nbsp;&nbsp;
		</c:if>
		<c:if test="${pi.getCpage() > 1}">
			<a href="orderInfo?cpage=1${pi.getSchargs()}"><<</a>&nbsp;&nbsp;&nbsp;
			<a href="orderInfo?cpage=${pi.getCpage() - 1}${pi.getSchargs()}"><</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach var="i" begin="${pi.getSpage()}" end="${pi.getSpage() + pi.getBsize() - 1 < pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }" >
			<c:if test="${i == pi.getCpage()}">
				&nbsp;<strong>${i}</strong>&nbsp;
			</c:if>
			<c:if test="${i != pi.getCpage()}">
				&nbsp;<a href="orderInfo?cpage=${i}${pi.getSchargs()}">${i}</a>&nbsp;
			</c:if>
		</c:forEach>
		
		<c:if test="${pi.getCpage() == pi.getPcnt()}">
			&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;>>
		</c:if>
		<c:if test="${pi.getCpage() < pi.getPcnt()}">
			&nbsp;&nbsp;<a href="orderInfo?cpage=${pi.getCpage() + 1}${pi.getSchargs()}">></a>
			&nbsp;&nbsp;&nbsp;<a href="orderInfo?cpage=${pi.getPcnt()}${pi.getSchargs()}">>></a>
		</c:if>
	</c:if>
	</div>
</div>
<!-- 회원 후기 리스트 종료 -->
</body>
<script>
var reviewList = {
	props: ["object"], 
	template:`<table id="table" width="850px;" >
		<tr><td width="23%"><img :src="object.rlimg" class="rimg" /></td><td width="*"><a :href="object.pilnk" />{{object.rlname}}</a><br />{{object.rlgood}}
		<p>{{object.rlcontent}}</p>{{object.rldate}}</td><td width="8%"><input type="button" value="삭제" v-on:click="reviewDel(object.rlidx)" /></td></tr>
		</table>
	`,	
	methods: {
		reviewDel(rlidx) { 
			if(confirm("정말 삭제하시겠습니까?")) {
				this.$emit("review-del", rlidx);
			}
		}
	}
}

new Vue({
	el: "#listbox", 
	data: {
		reviewArr: [
<%
String obj = "", good = "", pilnk = "", img = "";
for (int i = 0 ; i < reviewList.size() ; i++) {
	ReviewList rl = reviewList.get(i);
	if(rl.getRl_good().equals("a")) {
		good = "좋아요";
	}  else { good = "별로에요"; }
	
	pilnk = "http://localhost:8086/potted/productView?piid=" + rl.getPi_id();
	img = "http://localhost:8086/potted/resources/images/review/" + rl.getRl_img();
	
	if (rl.getRl_img().equals("null")) {
		img = "http://localhost:8086/potted/resources/images/main/no_img.jpg";
	}
	
	obj = (i == 0 ? "" : ", ") + "{rlidx:\"" + rl.getRl_idx() + "\", rlname:\"" + rl.getRl_name() + "\", rlimg:\"" + img + "\", rlcontent:\"" + rl.getRl_content() + 
		"\", rlgood:\"" + good + "\", rldate:\"" + rl.getRl_date() + "\", pilnk:\"" + pilnk + "\"}";
		out.println(obj);
}
%>
		]
	},
	components: {
		"review-list": reviewList
	},
	methods: {
		reviewDel(rlidx) {
			axios.get("./reviewDel?rlidx=" + rlidx)
			.then(response => {		// GET 요청 성공시 실행
				for (var i = 0 ; i < this.reviewArr.length ; i++) {
					if (this.reviewArr[i].rlidx == rlidx) {
						this.reviewArr.splice(i, 1);
						break;
					}
				}
			})
			.catch(e => {
				alert("후기 삭제에 실패했습니다. 다시 시도하세요.");
				console.log(e);
			})
		}
	}
});

</script>
</html>