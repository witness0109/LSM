<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>설문 결과</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- D3 -->
<style>
//
click-able rows
   .clickable-rows {tbody tr td { cursor:pointer;
	
}

.el-table__expanded-cell {
	cursor: default;
}

</style>

<script type="text/javascript">
	
	//페이징 설정 
	var noticePageSize = 5;       // 화면에 뿌릴 데이터 수 
	/* var noticePageSizevue = 5;  */
	var noticePageBlock = 2;      // 블럭으로 잡히는 페이징처리 수
	
	var loginId = "${sessionScope.loginId}";
	
	
	var isM = false;
	var popperProps = {
	        popperOptions: {
	          modifiers: {
	            preventOverflow: {
	              padding: 20
	            }
	          },
	          onUpdate: function (data) {
	            console.log(JSON.stringify(data.attributes))
	          }
	        }
	      };
	
	/* onload 이벤트 */
	$(function(){
		
		
		selectSurveyList();
		
		});
	
	/* 설문결과 리스트 불러오기 */
	function selectSurveyList(currentPage){
		
		currentPage = currentPage || 1;
		
			
		
		var param = {
				currentPage : currentPage,
				pageSize : noticePageSize
		}
		
		var resultCallback = function(data){
			surveyListResult(data, currentPage);
		}
		
		callAjax("/lsm/surveyList.do", "post", "text", true, param, resultCallback);
			
	}
		// 설문결과 리스트 data를 콜백함수로 뿌려주자
		function surveyListResult(data, currentPage){
			$("#surveyList").empty();
			
			$("#surveyList").append(data);
			
			var totalCnt = $("#totalCnt").val();
			
			// 페이지 네비게이션 만들기
			var list = $("#svrList").val();
			var pagingnavi = getPaginationHtml(currentPage, totalCnt, noticePageSize,noticePageBlock, 'selectSurveyList',[list]); 
			
			
			// 비우고 다시 append
			$("#pagingnavi").empty().append(pagingnavi);
			
			// 현재 페이지 설정해주기
			$("#currentPage").val(currentPage);
		}
		

	

</script>


</head>
<body>
<form id="mySurvey">
	<input type="hidden" id="currentPage" value="1"> <!-- 현재 페이지 항상 1로보이게 -->
	<input type="hidden" id="#svrList" value="">
	

	<div id="wrap_area">


		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">메인</span> <a href="#"
								class="btn_set refresh">새로고침</a>
						</p>

						<!--                         <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" /> -->
						<div id="searcharea">
							제목 : <input id="stitle" name="stitle" v-model="stitle"
								placeholder="제목 검색조건"> <a
								href="javascript:selectNoticeListvue();" id="btn_prelogin2"><strong>조회</strong></a>
							
						</div>

						<div>
							<template id="searcharea2">
							<div class="input-group date" style="width: 150px;">
								<input id="indate" name="indate" type="text"
									class="form-control" v-model="date" /> <span
									class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
							</template>
						</div>

						<input type="hidden" id="currentPage" value="1"> <input
							type="hidden" id="currentPagevue" value="1">
						<div class="dashboard2 mt30 mb20">
							<ul>
								<li>
									<div class="col">
										<p class="tit">
											<em>설 문 결 과</em>
										</p>
										<table class="col2 mb10" style="width: 1000px;">

											<colgroup>
												<col width="8%">
												<col width="8%">
												<col width="18%">
												<col width="15%">
												<col width="15%">
												<col width="10%">
											</colgroup>

											<thead>
												<tr>
													<th>강의 번호</th>
													<th>설문 번호</th>
													<th>강의명</th>
													<th>점수</th>
													<th>등록자</th>
													<th>등록일자</th>

												</tr>
											</thead>
											<tbody id="surveyList"></tbody>

										</table>
									</div>
								</li>
							</ul>

							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi" style= "width: 988px;">
								
                        </div>
							</div>

						</div>
						
					</div>
			

		</div>
	
	</form>
</body>
</html>