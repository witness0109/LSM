<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강의계획 (관리자)</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp" />

<script type="text/javascript">
	//페이징
	var pageSizeaPlist = 5;
	var pageBlockSizeaPlist = 5;

	$(function() {

		faPlist();

		fRegisterButtonClickEvent();

	});
	/*버튼 이벤트*/
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
			case 'btnDeletePlist':
				fDeletePlist();
			}
		});
	}
	//키 다운
	function enterKey() {

		if (event.keyCode == '13') {
			faPlist();
		}
	}

	/*강의계획리스트 조회*/
	function faPlist(currentPage, searchWord) {

		var searchKey = $("#searchKey").val();
		var searchWord = $("#searchWord").val();

		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeaPlist,
			searchKey : searchKey,
			searchWord : searchWord
		}

		//resultCallback 이란 함수에 data를 넣어 보낸다는 의미인듯!
		var resultCallback = function(data) {

			fpListResult(data, currentPage);
		};
		//Ajax시자악
		callAjax("/mss/aPlist.do", "post", "text", true, param, resultCallback);
	}
	/*강의계획 조회 콜백 함수*/
	function fpListResult(data, currentPage) {
		//	alert("콜백 성공 값은 = "+ data);

		$('#aPlist').empty();
		var $data = $($(data).html());
		var $aPlist = $data.find('#aPlist');

		$('#aPlist').append($aPlist.children());

		var $totalCntaPlist = $data.find("#totalCntaPlist");
		var totalCntaPlist = $totalCntaPlist.text();
		var paginationHtml = getPaginationHtml(currentPage, totalCntaPlist,
				pageSizeaPlist, pageBlockSizeaPlist, 'fapList');

		$("#apListpagiNation").empty().append(paginationHtml);
		//현재페이지 설정
		$("#currentPageaPlist").val(currentPage);
	}

	//팝업 모달
	function fPopModalPlistDtl(lec_seq) {
		// 신규 저장
		if (lec_seq == null || lec_seq == "") {
			
			$("#action").val("I");

			fInitFormaPlist();

			gfModalPop("#layer1");
			
			
		} else {
			$("#action").val("U");

			fSelectPlist(lec_seq);
		}
	}
	
	/*강의리스트 단건 조회*/
	function fSelectPlist(lec_seq) {

		var param = {
			lec_seq : lec_seq
		};

		var resultCallback = function(data) {
			fSelectPlistResult(data);
		};

		callAjax("/mss/selectaPlist.do", "post", "json", true, param,
				resultCallback);
	}

	/*강의리스트 단건  조회 콜백 함수*/
	function fSelectPlistResult(data) {

		//	alert(data.result);
		if (data.result == "SUCCESS") {

			gfModalPop("#layer1");

			fInitFormaPlist(data.plist, data.loginId);
		}

	}
	/*강의 목록 폼 모델 초기화*/
	function fInitFormaPlist(object, object2) {
	
		if (object == "" || object == null || object == undefined) {
	
			$("#lec_nm").val("");
			$("#lec_pl").val("");
			$("#lec_gl").val("");
			$("#rm_seq").val("");
			$("#lec_seq").val("");
			$("#lec_enr").val("");
			$("#lec_tm").val("");
			$("#lec_st").val("");
			$("#lec_ed").val("");
			$("#enr_user").val("");
			$("#enr_date").val("");
			$("#user_id").val("");
			$("#lec_contents").val("");
			$("#btnDeletePlist").hide();
		} else {
			$("#lec_nm").val(object.lec_nm);
			$("#lec_pl").val(object.lec_pl);
			$("#lec_gl").val(object.lec_gl);
			$("#rm_seq").val(object.rm_seq);
			$("#lec_seq").val(object.lec_seq);
			$("#lec_enr").val(object.lec_enr);
			$("#lec_tm").val(object.lec_tm);
			$("#lec_st").val(object.lec_st);
			$("#lec_ed").val(object.lec_ed);
			$("#enr_user").val(object.enr_user);
			$("#enr_date").val(object.enr_date);
			$("#upd_user").val(object2);
			$("#upd_date").val(object.upd_date);
			$("#user_id").val(object.user_id);
			$("#lec_contents").val(object.lec_contents);
			/*CSS 부분*/
			$("#upd_user").attr("readonly", true);
			$("#upd_user").css("background", "#F5F5F5");
			$("#upd_date").attr("readonly", true);
			$("#upd_date").css("background", "#F5F5F5");
			$("#btnDeletePlist").show();
		/* 	$("#lec_enr").attr("readonly", true);
			$("#lec_enr").css("background", "#F5F5F5"); */
		}
	}
	//체크
	function fValidatePlist() {
		var chk = checkNotEmpty( 
		                         
		        [ "lec_nm", "강의명을 입력해 주세요.ㅅㅂ" ],
				[ "lec_pl", "수업계획을 입력해 주세요." ], 
				[ "lec_gl", "수업목표을 입력해 주세요." ],
				[ "rm_seq", "강의실을 입력해 주세요." ], 
				[ "lec_seq", "강의번호를 입력해 주세요." ],
				[ "lec_tm", "강의시간을 입력해 주세요." ],
				[ "lec_st", "강의시작일을 입력해 주세요." ], 
				[ "lec_ed", "종강날을 입력해 주세요." ],
				[ "enr_user", "등록자를 입력해 주세요." ],
				[ "lec_enr", "등록날짜를 입력해 주세요." ],
				[ "lec_contents", "강의내용을 입력해 주세요." ],
				[ "enr_date", "강의등록일을 입력해 주세요." ] 
		       );

		if (!chk) {
			return;
		}
		return true;
	}

	//강의리스트 저장
	function fSavePlist() {
		
		//목록 조회 페이지 번호
 	 	if (!fValidatePlist()) {
			return;
		}   
		var resultCallback = function(data) {
			fSavePlistResult(data);
		};

		callAjax("/mss/saveaPlist.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	//강의리스트 저장 콜백 함수
	function fSavePlistResult(data) {
		
		var currentPage = "1";
		if ($("#action").val() != "I"){
			currentPage = $("#currentPageaPlist").val();
		}
		
		if (data.result == "SUCCESS") {
		
			alert("저장 되었습니다.");
			
			gfCloseModal();
			
			faPlist(currentPage, searchWord);
		} else {
			alert("띠용" + data.resultMsg);
		}
		fInitFormaPlist();
	}

	//그룹코드 삭제
	function fDeletePlist() {

		var resultCallback = function(data) {
			fDeletePlistResult(data);
		};

		callAjax("/mss/deletePlist.do", "post", "json", true, $("#myForm")
				.serialize(), resultCallback);
	}

	//그룹코드 삭제 콜백
	function fDeletePlistResult(data) {

		var currentPage = $("#currentPageaPlist").val();

		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 그룹코드 목록 조회
			faPlist(currentPage, searchWord);

		} else {
			alert(data.resultMsg);
		}
	}
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageaPlist" value="1"> <input
			type="hidden" id="tmpaPlist" value=""> <input type="hidden"
			name="action" id="action" value="">

		<div id="mask"></div>

		<div id="wrap_area">
			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp" />

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb"><jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp" /></li>
					<li class="contents">
						<h3 class="hidden">contents 영역</h3>
						<div class="content">
							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">학습지원</a> <span class="btn_nav bold">강의관리</span>
								<a href="#" class="btn_set refresh">새로고침</a>
							</p>
							<p class="search">
								<select id="searchKey" name="searchKey" style="width: 80px;">
									<option value="lec_nm" id="option1" selected="selected">강의명</option>
									<option value="rm_seq" id="option2">강의실번호</option>
								</select> <input type="text" class="searchEnter" id="searchWord"
									onkeydown="enterKey()" name="searchWord" placeholder=""
									style="height: 28px;"> <a class="btnType blue"
									href="javascript:faPlist()" name="search"> <span id="">검색</span>
								</a>
							</p>
							<p class="conTitle">
								<span>강의목록</span><span class="fr"> <a
									class="btnType blue" href="javascript:fPopModalPlistDtl();"	name="modal"><span>강의등록</span></a>
								</span>
							</p>

							<div class="divaPlist">
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
									<tbody id="aPlist"></tbody>
								</table>
							</div>
							<div class="paging_area" id="aPlistpagiNation"></div>
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
							<a><span class="font_red">※등록/수정 후 저장을 눌러주세요.</span></a>
							<tr>
								<th scope="row">강의명 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100" name="lec_nm"
									id="lec_nm" /> <input type="hidden" class="inputTxt p100"
									name="lec_seq" id="lec_seq" /></td>
								<th scope="row">강의실</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="rm_seq" id="rm_seq" /></td>
							</tr>
							<tr>
								<th scope="row">강사 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100" name="user_id"
									id="user_id" />
								<th scope="row">수업시간</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="lec_tm" id="lec_tm" /></td>
							</tr>
							<tr>
								<th scope="row">시작일 <span class="font_red"></span></th>
								<td><input type="date" class="inputTxt p100" name="lec_st"
									id="lec_st" style="font-size: 15px" />
								<th scope="row">종료일</th>
								<td colspan="3"><input type="date" class="inputTxt p120"
									name="lec_ed" id="lec_ed" style="font-size: 15px" /></td>
							</tr>
							<tr>
								<th scope="row">등록자 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="enr_user" id="enr_user" />
								<th scope="row">수정자</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="upd_user" id="upd_user" /></td>
									
							</tr>
							<tr>
								<th scope="row">수업계획 <span class="font_red"></span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="lec_pl" id="lec_pl" /></td>
							</tr>
							<tr>
								<th scope="row">수업목표 <span class="font_red"></span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="lec_gl" id="lec_gl" /></td>
							</tr>
							<tr>
								<th scope="row">강의내용 <span class="font_red">*</span></th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="lec_contents" id="lec_contents"
										placeholder="수업계획을 입력하세요." /></textarea></td>
							</tr>
					
							<tr>
								<th scope="row">강의등록일 <span class="font_red"></span></th>
								<td><input type="date" class="inputTxt p100" name="lec_enr"
									id="lec_enr" style="font-size: 15px" />
								<th scope="row">등록일</th>
								<td colspan="3"><input type="date" class="inputTxt p120"
									name="enr_date" id="enr_date" style="font-size: 15px" /></td>
							</tr>
					</table>


					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnDeletePlist" name="btn"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		
		
		<!-- 모달팝업2 -->
		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
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
							<a><span class="font_red">※등록/수정 후 저장을 눌러주세요.</span></a>
							<tr>
							
								<th scope="row">강의명 <span class="font_red"><input type="hidden" class="inputTxt p100" name="lec_seq" id="lec_seq" /></span></th>
								<td><input type="text" class="inputTxt p100" name="lec_nm"
									id="lec_nm" ></td>
									
								<th scope="row">강의실</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="rm_seq" id="rm_seq" /></td>
							</tr>
							<tr>
								<th scope="row">강사 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100" name="user_id"
									id="user_id" />
								<th scope="row">수업시간</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="lec_tm" id="lec_tm" /></td>
							</tr>
							<tr>
								<th scope="row">시작일 <span class="font_red"></span></th>
								<td><input type="date" class="inputTxt p100" name="lec_st"
									id="lec_st" style="font-size: 15px" />
								<th scope="row">종료일</th>
								<td colspan="3"><input type="date" class="inputTxt p120"
									name="lec_ed" id="lec_ed" style="font-size: 15px" /></td>
							</tr>
							<tr>
								<th scope="row">등록자 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="enr_user" id="enr_user" />
								<th scope="row">수정자</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="upd_user" id="upd_user" /></td>
							</tr>
							<tr>
								<th scope="row">수업계획 <span class="font_red"></span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="lec_pl" id="lec_pl" /></td>
							</tr>
							<tr>
								<th scope="row">수업목표 <span class="font_red"></span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="lec_gl" id="lec_gl" /></td>
							</tr>
							<tr>
								<th scope="row">강의내용 <span class="font_red">*</span></th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="lec_contents" id="lec_contents"
										placeholder="수업계획을 입력하세요." /></textarea></td>
							</tr>
							<tr>
								<th scope="row">강의등록일 <span class="font_red"></span><input type="hidden" name="upd_date" id="upd_date"/></th>
								<td><input type="date" class="inputTxt p100" name="lec_enr" id="lec_enr" style="font-size: 15px"/></td>
									
								<th scope="row">등록일 <span class="font_red"></span></th>
								<td><input type="date" class="inputTxt p100" name="enr_date" id="enr_date" style="font-size: 15px"/></td>
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
		</div>
	</form>
</body>
</html>