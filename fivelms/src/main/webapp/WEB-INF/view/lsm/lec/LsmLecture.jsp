<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JobKorea</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 강의목록 페이지 설정
	var pageSize = 5;
	var pageBlockSize = 5;
	
	/** OnLoad event */
	$(function() {
	
	// 강의목록 조회
	flecList();
	});
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case '':
			}
		});
	}	
	
	/** 전체 조회 */
	function flecList(currentPage, searchKey, searchWord) {
		
		searchKey = searchKey || 'lec_nm';
		searchWord = searchWord || '';
		
		var currentPage = currentPage || 1;
		var searchKey = searchKey || '';
		var searchWord = searchWord || '';
		
		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			searchKey : searchKey,
			searchWord : searchWord
		}
		var resultCallback = function(data) {
		
			flecListResult(data, currentPage);
		};
		//alert("전체 조회 제발");
		callAjax("/lec/lecList.do", "post", "text", true, param, 
				resultCallback);
	}	
	
	
	/** 전체 조회 콜백 */
	function flecListResult(data, currentPage) {
		//alert("콜백띠");
		
		// 기존 목록 비움
		$("#lecList").empty();
		
		var $data = $($(data).html());
		
		// 신규목록 생성
		var $lecList = $data.find('#lecList');
		$("#lecList").append($lecList.children());
		
		// 총 갯수
		var $totalCount = $data.find("#totalCount");
		var totalCount = $totalCount.text();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCount,
			pageSize, pageBlockSize, 'flecList');
			
		$("#lecPagination").empty().append(paginationHtml);
		
		// 현재페이지 설정
		$("#currentPage").val(currentPage);
	}
	
	/** 학생 조회 */
	function fselectlecDtl(currentPage, lec_seq) {
		
		$("#lec_seq").val(lec_seq);
		
		currentPage = currentPage || 1;
		
		var param = {
					lec_seq : lec_seq,
					currentPage : currentPage,
					pageSize : pageSize
		};
		
		var resultCallback = function(data) {
			fselectlecDtlResult(data, currentPage);
			console.log(data);
		};
	
		callAjax("/lec/selectlecDtl.do", "post", "text", true, param,
				resultCallback);
		}
	
		/** 학생 조회 콜백 */
		function fselectlecDtlResult(data, currentPage) {
			
			console.log("fselectlecDtlResult	data : " + data)
			
			// 기존 목록 비움
			$("#selectlecDtl").empty();
			
			var $data = $($(data).html());
			
			// 신규 목록 생성
			var $selectlecDtl = $data.find("#selectlecDtl");
			$("#selectlecDtl").append($selectlecDtl.children());
			
			// 총 갯수
			var $totalCount = $data.find("#totalCount");
			var totalCount = $totalCount.text();
			
			// 페이지 네비게이션 생성
			var paginationHtml = getPaginationHtml(currentPage, totalCount,
				pageSize, pageBlockSize, 'fselectlecDtl');
			
			$("#lecDtlPagination").empty().append(paginationHtml);
			
			// 현재페이지 설정
			$("#currentPage").val(currentPage);
			
			console.log(data);
		}		
			/** 검색 */
			function fSearchLec() {
				var searchKey = $("#searchKey").val();
				var searchWord = $("#searchWord").val();
				
				flecList(1, searchKey, searchWord);
			}
			
			/** 달력 */
			$(function() {
				
				$("#datepicker1, #datepicker2").datepicker({
					
					onSelect : function(dateText, inst) {
						
						changeYear: true
						
						changeMonth : true
						
						console.log(dateText);
					}
				
			});
				
		});		
				
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageLecList" value="1"> <input
			type="hidden" name="action" id="action" value="">

		<div id="wrap_area">
			<h2 class="hidden">header</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">contents</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						<!--// lnb 영역 -->
					</li>

					<li class="contents">
						<div class="content">
							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">학습 관리</a> <span class="btn_nav bold">수강인원/강의목록
									</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" id="searcharea">
								<span>강의목록</span> <span class="fr"> 
								<select id="searchkey" name="searchkey" style="width: 70px;">
										<option value="lec_nm" id="option1" selected="selected">강의명</option>
										<option value="enr_user" id="option2">학생명</option>
										
								</select> 
								<input type="text" id="searchWord" name="searchWord"
									   placeholder=""
									   style="height: 28px;">
								<!-- 	작성일 
									<input type="text" name="date" id="datepicker1" style="height: 28px; width: 70px;" />
									~ 
									<input type="text" name="date" id="datepicker2"style="height: 28px; width: 70px;" />--> 
									<a class="btnType blue" href="javascript:fSearchLec();" name="search"
									id="searchBtn" style="width: 70px;"><span>검색</span></a> 
								</span>
							</p>

							<div class="divLecList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="6%">
										<col width="14%">
										<col width="14%">
										<col width="5%">
										<col width="5%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">강의명</th>
											<th scope="col">시작일</th>
											<th scope="col">종료일</th>
											<th scope="col">강의실</th>
											<th scope="col">강사명</th>
										</tr>
									</thead>
									<tbody id="lecList"></tbody>
								</table>
							</div>

							<div class="paging_area" id="lecPagination"></div>

							<p class="conTitle mt50">
								<span>학생 목록</span> <span class="fr"> </span>
							</p>
							
							<div class="divlecListDtl">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">학생명</th>
										</tr>
									</thead>
									<tbody id="lecListDtl">
									</tbody>
								</table>
							</div>

							<div class="paging_area" id="lecDtlPagination"></div>
						</div> <!--// content -->
					</li>
				</ul>			
			</div>
		</div>
	</form>
</body>
</html>
