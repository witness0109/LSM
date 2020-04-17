<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의계획(강사)</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	/*페이지이잉*/
	var pageSizePlist = 5;
	var pageBlockSizePlist = 5;

	/* OnLoad event*/
	$(function() {

		fpList();
		//		alert("OnLoad를 시작합니다.");	
		fRegisterButtonClickEvent();
		//		alert("ButtonClickEvent를 시작 합니다.")

	});
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSave':
				fSavePlist();
				break;
			case 'btnCloseGrpCod':
				gfCloseModal();
				break;
			/* 		case 'searchBtn':
						fSearchPlist();
						break; */
			}
		});
	}
	//키 다운
	function enterKey() {

		if (event.keyCode == '13') {
			fPlist();
		}
	}
	/*강의계획 폼 초기화*/

	/*강의계획리스트 조회*/
	function fpList(currentPage) {

		var searchKey = $("#searchKey").val();
		var searchWord = $("#searchWord").val();

		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSizePlist,
			searchKey : searchKey,
			searchWord : searchWord
		}
		//resultCallback 이란 함수에 data를 넣어 보낸다는 의미인듯!
		var resultCallback = function(data) {

			fpListResult(data, currentPage);
		};
		//Ajax시자악
		callAjax("/lss/pListAll.do", "post", "text", true, param,
				resultCallback);
	}

	function fpListResult(data, currentPage) {
		//	alert("콜백 성공 값은 = "+ data);

		$('#pList').empty();
		var $data = $($(data).html());
		var $pList = $data.find('#pList');

		$('#pList').append($pList.children());

		var $totalCntPlist = $data.find("#totalCntPlist");
		var totalCntPlist = $totalCntPlist.text();
	
		var paginationHtml = getPaginationHtml(currentPage, totalCntPlist,
				pageSizePlist, pageBlockSizePlist, 'fpList');

		$("#pListpagiNation").empty().append(paginationHtml);
		//현재페이지 설정
		$("#currentPagePlist").val(currentPage);

	}
	//모달띄우기
	function fPopModalPlistDtl(lec_seq) {
		//	alert("상세보기 스크립 시작~");
		if (lec_seq == null || lec_seq == "") {
			$("#action").val("I");

			fInitFormPlist();

			gfModalPop("#layer1");

		} else {
			$("#action").val("U");

			fSelectPlist(lec_seq);
		}
	}
	//단건조회 값집어넣기
	function fSelectPlist(lec_seq) {

		var param = {
			lec_seq : lec_seq
		};

		var resultCallback = function(data) {
			fSelectPlistResult(data);
		};

		callAjax("/lss/selectPlist.do", "post", "json", true, param,
				resultCallback);
	}
	function fSelectPlistResult(data) {

		//	alert(data.result);
		if (data.result == "SUCCESS") {

			gfModalPop("#layer1");

			fInitFormPlist(data.plist);
		}

	}
	/*폼 초기화*/
	function fInitFormPlist(object) {
		$("#lec_pl").focus();
		if (object == "" || object == null || object == undefined) {

			$("#lec_nm").val("");
			$("#lec_pl").val("");
			$("#lec_gl").val("");
			$("#rm_seq").val("");
			$("#lec_seq").val("");

		} else {

			$("#lec_nm").val(object.lec_nm);
			$("#lec_gl").val(object.lec_gl);
			$("#rm_seq").val(object.rm_seq);
			$("#lec_seq").val(object.lec_seq);
			$("#lec_pl").val(object.lec_pl);

			$("#lec_nm").attr("readonly", true);
			$("#lec_nm").css("background", "#F5F5F5");

			$("#lec_gl").attr("readonly", true);
			$("#lec_gl").css("background", "#F5F5F5");

			$("#rm_seq").attr("readonly", true);
			$("#rm_seq").css("background", "#F5F5F5");

			$("#lec_seq").attr("readonly", true);
		}
	}
	function fValidatePlist() {
		var chk = checkNotEmpty([ [ "lec_pl", "강의계획을 입력해 주세요." ] ]);
		if (!chk) {
			return;
		}
		return true;
	}

	//강의 리스트 저장
	function fSavePlist() {
		//저장전 vaildation  체크
		if (!fValidatePlist()) {
			return;
		}
		var resultCallback = function(data) {
			fSavePlistResult(data);
		};

		callAjax("/lss/savePlist.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	//그룹코드 저장 콜백 함수
	function fSavePlistResult(data) {
		if (data.result == "SUCCESS") {

			alert("저장되었습니다.");

			//	gfCloseModal();
		} else {
			alert(data.resultMsg);
		}
		gfCloseModal();
	}
	//검색만들자
	/* 	function fSearchPlist() {
	 var searchKey = $("#searchKey").val();
	 var searchWord = $("#searchWord").val();

	 fpList(1, searchKey, searchWord);

	 } */
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<!-- 강의계획페이징 -->
		<input type="hidden" id="currentPagePlist" value="1">
		<!-- 강의계획비우기 -->
		<input type="hidden" id="tmpPlist" value=""> <input
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
						<!-- lnb 영역 --><jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">
							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">학습지원</a> <span class="btn_nav bold">강의계획서
									및 공지</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
							<p class="search">
								<select id="searchKey" name="searchKey" style="width: 80px;">
									<option value="lec_nm" id="option1" selected="selected">강의명</option>
									<option value="rm_seq" id="option2">강의실번호</option>
								</select> <input type="text" id="searchWord" name="searchWord"
									placeholder="" style="height: 28px;"> <a
									class="btnType blue" href="javascript:fpList()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>
							</p>
							<p class="conTitle"><span id="">강의목록</span></p>
							
							<div class="divPlist">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="6%">
										<col width="5%">
										<col width="14%">
										<col width="14%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">강의</th>
											<th scope="col">강의실</th>
											<th scope="col">시작일</th>
											<th scope="col">종료일</th>
											<th scope="col">총일수</th>
										</tr>
									</thead>
									<tbody id="pList"></tbody>
								</table>
							</div>
							<div class="paging_area" id="pListpagiNation"></div>
						
						</div>
					</li>
				</ul>
			</div>
		</div>

		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>강의 관리</strong>
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

						<tbody>
							<tr>
								<th scope="row">과정명 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100" name="lec_nm"
									id="lec_nm" /> <input type="hidden" class="inputTxt p100"
									name="lec_seq" id="lec_seq" /></td>
								<th scope="row">강의실</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="rm_seq" id="rm_seq" /></td>
							</tr>
							<tr>
								<th scope="row">수업목표 <span class="font_red"></span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="lec_gl" id="lec_gl" /></td>
							</tr>
							<tr>
								<th scope="row">수업계획 <span class="font_red">*</span></th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="lec_pl" id="lec_pl" placeholder="수업계획을 입력하세요." /></textarea><span
									class="font_red">※계획변경 후 저장을 눌러주세요.</span></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>