<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	// 과제 등록  페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;

	/** OnLoad event */
	$(function() {

		// 목록 조회
		fListSelect();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSaveTasksend':
				fSaveTaskSend();
				break;
			case 'btnDeleteTasksend':
				fDeleteTaskSend();
				break;
			case 'btnCloseTasksend':
				gfCloseModal();
				break;
			}
		});
	}

	/** 과제제출 조회 */
	function fListSelect(currentPage) {

		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSize
		}

		var resultCallback = function(data) {
			fListSelectResult(data, currentPage);
		};
		//Ajax실행 방식
		//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		callAjax("/ssm/listTaskSend.do", "post", "text", true, param,
				resultCallback);
	}

	/** 과제제출 조회 콜백  */
	function fListSelectResult(data, currentPage) {

		console.log(data);

		// 기존 목록 삭제
		$('#listsend').empty();
		//$('#listComnGrpCod').find("tr").remove() 

		var $data = $($(data).html());

		// 신규 목록 생성
		var $listsend = $data.find("#listsend");
		$("#listsend").append($listsend.children());

		// 총 개수 추출
		var $totcnt = $data.find("#totcnt");
		var totcnt = $totcnt.text();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totcnt, pageSize,
				pageBlockSize, 'fListSelect');

		//alert(paginationHtml);
		$("#taskPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);
	}

	/** 과제제출 폼 초기화 */
	function fInitFormSsm(object) {
		$("#ModalSave").focus();
		if (object == "" || object == null || object == undefined) {

			$("#task_seq").val("");
			$("#lec_seq").val("");
			$("#enr_user").val("");
			$("#enr_date").val("");
			$("#upd_user").val("");
			$("#task_file").val("");
			$("#task_seq").css("background", "#FFFFFF");
			$("#task_seq").focus();
			$("#btnDeleteTaskSend").hide();

		} else {

			$("#task_seq").val(object.task_seq);
			$("#lec_seq").val(object.lec_seq).attr("selected", "selected");
			$("#enr_user").val(object.enr_user);
			$("#enr_date").val(object.enr_date);
			$("#upd_user").val(object.upd_user);
			$("#task_tm").val(object.task_tm);
			$("#upd_user").val(object.upd_user);
			$("#upd_date").val(object.upd_date);
			$("#task_seq").css("background", "#F5F5F5");
			$("#task_seq").focus();
			$("#btnDeleteTaskSend").show();

			/** 첨부파일 */
			$("#ssm_file").empty();
			$("#fil_seq").val("");

			/** 첨부파일 설정 */
			$(object.listSsmFileModel).each(
					function(index, taskFilModel) {
						var tag = new StringBuffer();
						if (index == 0)
							tag.append("<a href=\"javascript:fDownloadSsmFil('"
									+ taskFilModel.task_seq + "\");'>");

						$("#dv_ssm_file").append(tag.toString());
					});

			$("#btnDeleteTaskSend").show();
		}
	}

	/** 과제제출 저장 validation */
	function fValidateTaskSend() {

		var chk = checkNotEmpty([ [ "task_nm", "과제명을 입력해주세요" ],
				[ "task_nm", "강의명을 입력해주세요" ] ]);

		if (!chk) {
			return;
		}

		return true;
	}

	/** 과제제출 모달 실행 */
	function fPopModalTaskSend(task_seq) {

		// 신규 저장
		if (task_seq == null || task_seq == "") {
			//alert(task_seq);
			// Tranjection type 설정
			$("#action").val("I");

			// 과제제출 폼 초기화
			fInitFormSsm();

			// 모달 팝업
			gfModalPop("#layer1");

			// 모달 끄기
			gfCloseModal();
		} else {

			// Tranjection type 설정
			$("#action").val("U");

			// 과제제출 단건 조회
			fSelectTaskSend(task_seq);
		}
	}

	/** 과제제출 단건 조회 */
	function fSelectTaskSend(task_seq) {

		var param = {
			task_seq : task_seq
		};

		var resultCallback = function(data) {
			fSelectTaskSendResult(data);
		};

		callAjax("/ssm/selectTaskSend.do", "post", "json", true, param,
				resultCallback);
	}

	/** 과제제출 단건 조회 콜백 */
	function fSelectTaskSendResult(data) {

		if (data.result == "SUCCESS") {
			var selectData = data.ssmInfoModel;
			// 모달 팝업
			gfModalPop("#layer1");
			//alert(data.ssmInfoModel);
			// 과제제출 폼 데이터 설정
			fInitFormSsm(selectData);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 과제제출 저장 */
	function fSaveTaskSend() {
		//alert("11111111111");
		// vaildation 체크
		if (!fValidateTaskSend()) {
			return false;
		}

		if ($("#action").val() == 'I') {
			if (confirm("작성 하시겠습니까?") == false) {
				return;
			}
		}else if($("#action").val() == 'U'){
			if(confirm('변경 내용을 수정 하시겠습니까?') == false){
				return;
		}
	}		
		fSaveSsmFil();
	}

	/** 과제제출 저장 콜백  */
	function fSaveTaskSendResult(data) {

		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPageTaskSend").val();
		}

		if (data.result == "SUCCESS") {

			$("#ssm_file").val("");
			$("#fil_seq").val("");

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 목록 조회
			fListSelect(currentPage);

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}

		// 입력폼 초기화
		fListTaskSend(currentPage);
	}

	/** 파일첨부 */
	function fSaveSsmFil() {

		var frm = document.getElementById("myForm");
		frm.encytpe = 'multipart/form-data';
		var fileData = new FormData(frm);

		var resultCallback = function(data) {
			fSaveSsmFilResult(data);

			console.log(fileData);
			callAjaxFileuploadSetFormData("/ssm/downloadSsmFil.do", "post",
					"json", true, fileData, resultCallback);
		}
	}

	/** 과제제출 삭제 */
	function fDeleteTaskSend() {

		var resultCallback = function(data) {
			fDeleteTaskSendResult(data);
		};

		callAjax("/ssm/deleteTaskSend.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	/** 과제제출 삭제 콜백 함수 */
	function fDeleteTaskSendResult(data) {

		var currentPage = $("#currentPageTaskSend").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 그룹코드 목록 조회
			fListSelect(currentPage);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 과제 등록 모달 실행 */
	 function fPopModalTaskSend(task_seq) {
		
		// 신규 저장
		if (task_seq == null || task_seq=="") {
		alert(task_seq);
			// Tranjection type 설정
			$("#action").val("I");
			
			// 과제제출 폼 초기화
			fInitFormSsm();
			
			// 모달 팝업
			gfModalPop("#layer2");

		// 수정 저장
		} else {
			
			// Tranjection type 설정
			$("#action").val("U");
			
			// 과제제출 단건 조회
			fSelectTaskSend(task_seq);
		}
	}	 

	/** 검색 */
	function fSearchTaskSend() {
		var searchKey = $("#searchKey").val();
		var searchWord = $("#searchWord").val();

		fSearchTaskSend(1, searchKey, searchWord);
	}

	/** 과제 상세 목록 조회 */
	function fTaskSendDtl(currentPage, lec_seq) {
		$("#lec_seq").val(lec_seq);
		//	$("#task_seq").val(task_seq);
		currentPage = currentPage || 1;

		//    console.log("============== jsp ======================> currentPage " + currentPage + " lec_seq : " + lec_seq);

		var param = {
			lec_seq : lec_seq,
			currentPage : currentPage,
			pageSize : pageSize
		};

		var resultCallback = function(data) {
			fTaskSendDtlResult(data, currentPage);
		};

		callAjax("/ssm/taskSendDtl.do", "post", "text", true, param,
				resultCallback);
	}

	/** 과제 상세 조회 콜백 */
	function fTaskSendDtlResult(data, currentPage) {

		console.log("fTaskSendDtlResult   data : " + data)

		$("#tasksendDtl").empty();

		var $data = $($(data).html());

		var $list = $data.find("#tasksendDtl");
		$("#tasksendDtl").append($list.children());

		var $totcnt = $data.find("#totcnt");
		var totcnt = $totcnt.text();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totcnt, pageSize,
				pageBlockSize, 'fTaskSendDtl');

		//alert(paginationHtml);
		$("#taskSendDtlPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);

		console.log(data);

	}
</script>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> <input
			type="hidden" name="action" id="action" value="">

		<!-- 모달 배경 -->
		<div id="mask"></div>

		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

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
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">학습 관리</a> <span class="btn_nav bold">과제제출
								</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>

							<p class="searcharea">
								<select id="searchkey" name="searchkey" style="width: 70px;">
									<option value="lec_nm" id="option1" selected="selected">강의명</option>
									<option value="enr_user" id="option2">작성자</option>
								</select> 
								<input type="text" id="searchword" name="searchword"
									placeholder="" style="height: 28px;"> 
									<a	class="btnType blue" href="javascript:fSearchTaskSend();"
									name="search" id="searchBtn"><span>검색</span></a>
							</p>

							<p class="conTitle">
								<span>과제 제출</span> <span class="fr"> 
								<a	class="btnType blue" href="javascript:fPopModalTaskSend();"
									name="modal"><span>과제 등록</span></a>
								</span>
							</p>

							<div class="divTaskSendList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="25%">
										<col width="15%">
										<col width="15%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">순번</th>
											<th scope="col">강의번호</th>
											<th scope="col">강의명</th>
											<th scope="col">과제번호</th>
											<th scope="col">과제명</th>
										</tr>
									</thead>
									<tbody id="listsend"></tbody>
								</table>
							</div>

							<div class="paging_area" id="taskPagination"></div>

							<p class="conTitle mt50">
								<span>과제 Dtl</span> <span class="fr"> </span>
							</p>

							<div class="divTaskSendDtl">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="30%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">순번</th>
											<th scope="col">작성자</th>
											<th scope="col">작성일</th>
											<th scope="col">수정일자</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="tasksendDtl">
									</tbody>
								</table>
							</div>

							<div class="paging_area" id="taskSendDtlPagination"></div>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!-- 과제 수정 팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>과제 수정</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>

						<tbody id="ModalSave">
							<tr>
								<th scope="row">과제명<span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="task_nm" id="task_nm" /></td>
								<th scope="row">작성자<span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="enr_user" id="enr_user" /></td>
							</tr>
							<tr>			
								<th scope="row">강의명<span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="lec_nm" id="lec_nm" /></td>
								<th scope="row">강사 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="upd_user" id="upd_user" /></td>
							</tr>
							<tr>
								<th scope="row">첨부파일 <span class="font_red">*</span></th>
								<td><input type="file" class="inputTxt p100"
									name="ssm_file" id="ssm_file" /></td>
								<!-- <td colspan="3"><input type="radio" id="radio1-1"
								name="grp_use_poa" id="grp_use_poa_1" value='Y' /> <label for="radio1-1">사용</label>
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"
								name="grp_use_poa" id="grp_use_poa_2" value="N" /> <label for="radio1-2">미사용</label></td> -->
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveTasksend" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDeleteTasksend" name="btn"><span>삭제</span></a>
						<a href="" class="btnType blue" id="btnCloseTasksend" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

		<!-- 과제 등록 모달팝업 -->
		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>과제 등록</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>

						<tbody id="ModalSave">
							<tr>
								<th scope="row">과제명<span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="task_nm" id="task_nm" /></td>
								<th scope="row">작성자<span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="enr_user" id="enr_user" /></td>
							</tr>
							<tr>			
								<th scope="row">강의명<span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="lec_nm" id="lec_nm" /></td>
								<th scope="row">강사 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="upd_user" id="upd_user" /></td>
							</tr>
							<tr>
								<th scope="row">첨부파일<span class="font_red">*</span></th>
								<td><input type="file" class="inputTxt p100"
									name="ssm_file" id="ssm_file">
									<div id="dv_ssm_file"></div></td>
								<!-- <td colspan="3"><input type="radio" id="radio1-1"
								name="grp_use_poa" id="grp_use_poa_1" value='Y' /> <label for="radio1-1">사용</label>
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="radio1-2"
								name="grp_use_poa" id="grp_use_poa_2" value="N" /> <label for="radio1-2">미사용</label></td> -->
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSaveTasksend" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnCloseTasksend" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

		<!--// 모달팝업 -->
	</form>
</body>
</html>