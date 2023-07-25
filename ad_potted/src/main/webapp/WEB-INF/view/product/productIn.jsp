<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<style>
.title {color:#1cad0a;}
h2 {font-size:24px;}
tr {height:45px;}
th, td {font-size:17px;}
th {width:130px; text-align:left;}
.pimg {padding:10px; margin-right:10px; border:1px solid #000;}
.psub {display:inline-block; width:178px; padding:10px 7px; text-align:left; font-size:12px; border:1px solid #000;}
.btnBox {margin-right:87px; float:right;}
.insertBtn {width:100px; padding:5px 0;margin-bottom:30px; border:0; background:gray; color:#fff;}
.cancelBtn {display:block; width:100px; padding:5px 0; float:right; text-align:center; border:1px solid #000; margin-left:10px; font-size:13px;}
</style>
<script>
$(document).ready(function() {
    // 대분류가 변경될 때 소분류 값을 가져오는 함수 호출
    $("#bigCategory").change(function() {
        var bigCategoryId = $(this).val();
        fetchSmallCategories(bigCategoryId); // AJAX 호출 함수
    });
});

function fetchSmallCategories(bigCategoryId) {
    // AJAX를 이용해 서버로 소분류 값을 요청하는 부분
    $.ajax({
        type: "POST",
        url: "/SmallCategories",
        data: { "bigCategoryId" : bigCategoryId },
        success: function(data) {
            // AJAX 요청이 성공하면 가져온 데이터로 소분류 select 태그를 갱신
            var smallCategorySelect = $("#smallCategory");
            smallCategorySelect.empty(); // 기존 소분류 목록 제거
            smallCategorySelect.append("<option value=''>선택</option>"); // 기본 선택 옵션 추가

            // 가져온 데이터로 소분류 목록 추가
            for (var i = 0; i < data.length; i++) {
                smallCategorySelect.append("<option value='" + data[i].pcs_id + "'>" + data[i].pcs_name + "</option>");
            }
        },
        error: function() {
            // 실패 시 처리할 내용
            alert("소분류를 가져오는데 실패했습니다.");
        }
    });
}
</script>
<div style="width:1100px; margin:0 auto; overflow:hidden;">
	<h2>상품 등록</h2>
	<table>
		<tr>
			<th class="title">상품 상태</th>
			<td>
				<input type="radio" name="sale" id="ping" />
				<label for="ping">판매중</label>
				<input type="radio" name="sale" id="pstop" />
				<label for="pstop">판매중지</label>
			</td>
		</tr>
		<tr>
			<th class="title">상품 목록</th>
			<td>
				<span style="margin-right:10px; vertical-align:middle;">대분류</span>
				<select id="bigCategory" name="bigCategory" style="width:170px; height:30px; margin-right:20px;">
					<option value="">선택</option>
					<c:forEach items="${bigList}" var="category">
						<option value="${category.pcb_id}">${category.pcb_name}</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<span style="margin-right:10px; vertical-align:middle;">소분류</span>
				<select id="smallCategory" style="width:170px; height:30px;">
				
				</select>
			</td>
		</tr>
		<tr>
			<th class="title">상품 이미지</th>
			<td>
				<input type="file" name="pimg1" class="pimg" /><br />
			</td>
			<td>
				<input type="file" name="pimg2" class="pimg" /><br />
			</td>
			<td>
				<input type="file" name="pimg3" class="pimg" /><br />
			</td>
		</tr>
		<tr>
			<th class="title">상품명</th>
			<td>
				<input type="text" name="pname" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품명을 입력해주세요." /><br />
			</td>
		</tr>	
		<tr>
			<th class="title">추가상품</th>
			<td>
				<input type="checkbox" name="division" id="division" /> <label for="division">분갈이</label>
				<input type="checkbox" name="pot" id="pot" /> <label for="pot">화분</label>
				<input type="checkbox" name="stone" id="stone" /> <label for="stone">마감돌</label>
			</td>
		</tr>
		<tr>
			<th class="title" rowspan="3" style="padding-top:15px; vertical-align:text-top;">서브상품</th>
			<td align="right">
				<span style="vertical-align:super;">분갈이</span>
				<input type="checkbox" name="pds01" id="pds01" style="vertical-align:super;" /> <label for="pds01" class="psub">1-1 직접 분갈이 (분갈이+난석+깔망)</label>
			</td>
			<td align="right">
				<span>화분</span>
				<input type="checkbox" name="pt01" id="pt01" /> <label for="pt01" class="psub">2-1 아트스톤 화분</label> 
			</td>
			<td align="right">
				<span>마감돌</span>
				<input type="checkbox" name="st01" id="st01" /> <label for="st01" class="psub">3-1 마사토</label>
			</td>

		</tr>
		<tr>
			<td align="right" rowspan="3" style="vertical-align:top;">
				<input type="checkbox" name="pds02" id="pds02" /> <label for="pds02" class="psub">1-2 분갈이 요청(분갈이+난석+분갈이)</label>
			</td>
			<td align="right">
				<input type="checkbox" name="pt02" id="pt02" /> <label for="pt02" class="psub">2-2 도자기 화분</label>
			</td>
			<td align="right">
				<input type="checkbox" name="st02" id="st02" /> <label for="st02" class="psub">3-2 화산석</label>
			</td>
		</tr>
		<tr>
			<td align="right">
				<input type="checkbox" name="pt03" id="pt03" /> <label for="pt03" class="psub">2-3 유약분</label>
			</td>
			<td align="right">
				<input type="checkbox" name="st03" id="st03" /> <label for="st03" class="psub">3-3 자갈</label>
			</td>
		</tr>
		<tr>
			<td></td>
			<td align="right">
				<input type="checkbox" name="st04" id="st04" /> <label for="st04" class="psub">2-4 토분</label>
			</td>
		</tr>
		<tr>
			<th class="title">상품원가</th>
			<td>
				<input type="text" name="pcost" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품원가를 입력해주세요." />원
			</td>
		</tr>
		<tr>
			<th class="title">상품판매가</th>
			<td>
				<input type="text" name="pprice" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품판매가를 입력해주세요." />원
			</td>
		</tr>
		<tr>
			<th class="title">상품할인</th>
			<td>
				<input type="text" name="pprice" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="할인가를 입력해주세요." />%
			</td>
		</tr>
		<tr>
			<th class="title">상품수량</th>
			<td>
				<input type="text" name="pprice" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품수량을 입력해주세요." />개
			</td>
		</tr>
		<tr>
			<th class="title">상품설명 이미지</th>
			<td>
				<input type="file" name="peximg" class="pimg" /><br />
			</td>
		</tr>
	</table>
	<div class="btnBox">
		<input type="submit" value="상품 등록" class="insertBtn"/>
		<a href="javascript:void(0);" class="cancelBtn">취소</a>
	</div>
</div>
<%@ include file="../inc/inc_foot.jsp" %>