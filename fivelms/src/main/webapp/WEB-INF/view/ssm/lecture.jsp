
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
	//수강목록 페이징 설정
	var pageSizeLecList = 5;
	var pageBlockSizeComnGrpCod = 5;

	/*OnLoad event*/
	$(function() {
		//수강목록 조회
		flectureList();
		//버튼 이벤트 등록
		fRegisterButtonClickEvent();
		$('#add').attr('readonly', true);
		$('#add2').attr('readonly', true);
		$('#lec_gl').attr('readonly', true);
		$('#lec_pl').attr('readonly', true);
		$('#lec_contents').attr('readonly', true);

	});

	/*버튼 이벤트 등록*/
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case '':

			}
		});
	}

	/*수강목록 조회*/
	function flectureList(currentPage) {
		var currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeLecList
		}
		var resultCallback = function(data) {
			flecListResult(data, currentPage);
		};

		callAjax("/ssm/lectureListgo.do", "post", "text", true, param,
				resultCallback);
	}

	/*수강목록 조회 콜백 함수*/
	function flecListResult(data, currentPage) {
		//기존 목록 삭제임다

		//console.log(data);
		$("#lectureList").empty();

		var $data = $($(data).html());
		//신규목록 생성
		var $lectureList = $data.find('#lectureList');
		$("#lectureList").append($lectureList.children());
		//console.log("11111111111111 : " + $lectureList.children() + " : " + $data.find("#totalCntlecList").text());

		//총 갯수는?~
		var $totalCntlecList = $data.find("#totalCntlecList");
		var totalCntlecList = $totalCntlecList.text();
		//페이지 네비게이션 생성
		var pagenationHtml = getPaginationHtml(currentPage, totalCntlecList,
				pageSizeLecList, pageBlockSizeComnGrpCod, 'flectureList');

		$("#lecturepageNation").empty().append(pagenationHtml);
		//현재페이지 설정
		$("#currentPagelectureList").val(currentPage);

	}

	/*그룹코드 단건 조회*/
	function flecDet(lec_seq) {

		var param = {
			lec_seq : lec_seq
		};

		var resultCallback = function(data) {
			fselectLecDetResult(data);
		};
		callAjax("/ssm/selectLecDet.do", "post", "json", true, param,
				resultCallback);
	}
	/*그룹코드 단건 조회 콜백 함수*/
	function fselectLecDetResult(data) {
		if (data.result == "SUCCESS") {
			// 1번째 방법
			// Json에서 html 형식으로 넘기기
			/* 			 
			$("#lecDet").empty();
			var selectdata = data.list; 
			var innerHtml = "<tr><td>" + selectdata.lec_contents + "</td><td>" + selectdata.prog  + "</td></tr>";
			$("#lecDet").append(innerHtml);
			 */
			// 2번째 방법 
			// Json 데이터 핸들링하기
			var selectdata = data.map;
			var avgPDay = "";
			//펑균값 구하기
			var avgDay = Math.floor(parseInt(selectdata.prog)
					/ parseInt(selectdata.total) * 100);
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			console.log("여기는 (avgDay)진도 = 양수인지 음수인지 확인 =" + avgDay);
			console.log("여기는 (prog)진행일  = " + selectdata.prog);
			console.log("여기는(reProg)남은일 = " + selectdata.reProg);
			console.log("여기는(reProg)남은일 = " + selectdata.total);
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

			//음수 일 경우 완료처리
			if (avgDay<0 || avgDay>100) {
				avgPDay = 100;
				console.log("음수일때 if문(true) avgPDay= " + avgPDay);
			} else {
				//남은일자%
				console.log("양수일때 if문()(avgDay) = " + avgDay);
				avgPDay = avgDay;

			}
			$("#lec_contents").val(selectdata.lec_contents);
			$("#lec_gl").val(selectdata.lec_gl);
			$("#lec_pl").val(selectdata.lec_pl);
			$("#prog").val(selectdata.prog);
			$("#add").val(avgPDay);
			$("#add2").val(avgPDay + "%");

		} else {
			alert("실패");
		}
	}

	/* 
	 $('#divlecList').click(function () {  
	 if($(".divLecDet").css("display") == "none"){   
	 $('.divLecDet').css("display", "block");   
	 } else {  
	 $('.divLecDet').css("display", "none");   
	 }  
	 });
	 */
</script>

<style>
progress {
	board-style: none;
	float: left;
	-webkit-writing-mode: horizontal-tb !important;
	-webkit-appearance: progress-bar;
	box-sizing: border-box;
	display: inline-block;
	height: 2em;
	width: 30em;
	vertical-align: -0.2em;
}

#add2 {
	height: 28px;
	font-family: "맑음고딕";
	font-weight: bold;
	font-size: medium;
}
</style>

</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPagelectureList" value="1"> <input
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
									class="btn_nav">학습 관리</a> <span class="btn_nav bold">수강목록및
									진도 관리</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle">
								<span>수강목록</span><span class="fr"> </span>
							</p>
							<div class="divlecList">
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
											<th scope="col">강사</th>
											<th scope="col">시작일</th>
											<th scope="col">종료일</th>
											<th scope="col">강의실</th>
											<th scope="col">총일수</th>
										</tr>
									</thead>
									<tbody id="lectureList"></tbody>
								</table>
							</div>
							<div>
								<div class="paging_area" id="lecturepageNation"></div>
							</div>
								<p class="conTitle">
								<span>상세정보</span><span class="fr" > </span>
							</p>
							<!--  첫번째 방법 -->
							<!--  div class="divLecDet">
								<table class="col">
									<thead>
										<tr>
											<th>강의내용</th>
											<th>진도</th>
										</tr>
									</thead>
									<tbody id="lecDet">
									</tbody>
								</table>
							</div>	
						</div -->

							<!--  두번째 방법 -->
							<div class="divLecDet">
								<table class="col">
									<tbody>
										<tr>
											<td>진도</td>
											<td><progress id="add" name="add" max="100"></progress>
												<input type="text" id="add2" name="add2"
												style="border-style: none; float: left;" ></td>
										</tr>
										<tr>
											<td>목표</td>
											<td><input type="text" id="lec_gl" name="lec_gl"
												style="border-style: none; background-color: #F2F2F2; float: left;">
											</td>
										</tr>
										<tr>
											<td>계획</td>
											<td><input type="text" id="lec_pl" name="lec_pl"
												style="border-style: none; float: left;"></td>
										</tr>
										<tr>
											<td>강의내용</td>
											<td><textarea id="lec_contents" name="lec_contents"></textarea></td>
										</tr>
										<tr>
										</tr>
										<tr>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>