<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge" />
<title>과제관리리스트</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>
	// 과제관리 페이지 설정
	var pageSizeLsmCod = 5;
	var pageBlockSizelsmCod = 5;
	
	// 과제제출 페이징 설정
	var pageSizeLsmStuCod = 5;
	var pageBlockSizeLsmStuCod = 10;
	
	var loginId = '${sessionScope.loginId}';
	
    var lecSeq = "";
    var lecNm = "";
    
    var result = "";
    var resultMsg = "";
	
	/* OnLoad event */
	$(function() {

		fselectLsmList();

		fRegisterButtonClickEvent();
	});
	
	/* 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault();
			
			var btnld = $(this).attr('id');
			
			switch (btnld){
				case 'btnSaveLsmCod' :
					fSaveLsmInfo();
					break;
				case 'btnDeleteLsmCod':
					fDeleteLsmCod();
					break;
				case 'btnCloseLsmCod':
					gfCloseModal();
					break;
			}
		});
	}

	function fselectLsmList(currentPage) {

		currentPage = currentPage || 1;

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeLsmCod
		}

		var resultCallback = function(data) {
			lsmListResult(data, currentPage);
		}

		callAjax("/lsm/listLsmCod.do", "post", "text", true, param,
				resultCallback);

		// async 응답이 올때까지 기다리지 않는다.
		// sync 응답이 올때까지 기다린다.
	}

	// 조회 콜백 함수
	function lsmListResult(data, currentPage) {

		//alert(data);

		//console.log(data + "-------------" + currentPage);
 
		//기존 목록 삭제
		$('#listLsmCod').empty();

		var $data = $($(data).html());
		
		//강의번호, 강의명 받음
		lecSeq = $data.find("#lecSeq").text();
		lecNm = $data.find("#lecNm").text();

		//신규 목록 생성
		var $listLsmCod = $data.find("#listLsmCod");
		$("#listLsmCod").append($listLsmCod.children());

		//총개수 추출
		var $totalCntLsmCod = $data.find("#totalCntLsmCod");
		var totalCntLsmCod = $totalCntLsmCod.text();

		lecSeq = $data.find("#lecSeq").text();
		lecNm = $data.find("#lecNm").text();
		
		//페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCntLsmCod,
				pageSizeLsmCod, pageBlockSizelsmCod, 'fselectLsmList');

		//alert(paginationHtml);
		$('#lsmCodPagination').empty().append(paginationHtml);

		//현재 페이지 설정
		$("#currentPageLsmCod").val(currentPage);
      
		//alert("lecSeq : " + lecSeq + "lecNm :" + lecNm) ;
		
		var lecSeqarr = lecSeq.replace("[", "").replace("]", "").split(',');
		var lecNmarr = lecNm.replace("[", "").replace("]", "").split(',');
		
		$('#lec_seq').empty();
		         
		for ( var count in lecSeqarr ) {	
		                var option = $("<option value='" + lecSeqarr[count]  + "'>"+lecNmarr[count]+"</option>");
		                $('#lec_seq').append(option);
	   }
	
	}

	function lecNmDisplay(form){
		
		var lnm = form.lec_seq.options[form.lec_seq.selectedIndex].text;
		
		console.log(lnm);
		
		form.lec_nm.value = lnm;
		
	}
	
	
	
	/** 리스트 폼 초기화 */
	function fInitFormLsm(object) {
		$("#task_seq").focus();
		if (object == "" || object == null || object == undefined) {

			//console.log(object);	
				
			$("#lec_seq").val("");
			$("#task_seq").val("");
			$("#lec_nm").val("");
			$("#task_nm").val("");
			$("#enr_user").val("${sessionScope.loginId}");
			$("#task_cont").val("");
			$("#lsm_file").val("");
			$("#task_seq").css("background", "#FFFFFF");
			$("#task_seq").focus();
			
			$("#lsm_file").empty();
			$("#dv_lsm_file").empty();
			
			$("#btnDeleteLsmCod").hide();

		} else {

			//console.log(object);	
			
			var a = object.lsmCodModel;
			var b = object.listLsmFileModel;
			
			//console.log(a);
			
			console.log(b);

			$("#lec_seq").val(a.lec_seq).attr("selected","selected");
			$("#task_seq").val(a.task_seq);
			$("#lec_nm").val(a.lec_nm);
			$("#task_nm").val(a.task_nm);
			$("#enr_user").val(a.enr_user);
			$("#task_cont").val(a.task_cont);
			$("#task_seq").attr("readonly", true);
			$("#lec_seq").attr("readonly", true);
			$("#task_seq").css("background", "#F5F5F5");
			$("#task_seq").focus();
			
			/* 첨부파일 */
			$("#dv_lsm_file").empty();
			$("#fil_seq").val(""); // 일련번호?
			
			//첨부파일 설정
			$(b).each(function(index, listFilModel){
				
			
				var tag = new StringBuffer();
				if(index == 0) tag.append("<br/>");
				
				tag.append("<p id='lsm_file_"+ listFilModel.snm+"'>");
				tag.append("<a href=\"javascript:fDownloadLsmFil('"+ listFilModel.task_seq + 
						"','"+ listFilModel.snm+"')\">"+ listFilModel.lgc_fil_nm+"</a>["+g_fFormatSizeUnits(listFilModel.fil_siz)+"]");
				tag.append("<a href='javascript:fDeleteLsmFile(\""+listFilModel.snm+"\");'>");
				tag.append("삭 제 </a></p>");
				
			
				$("#dv_lsm_file").append(tag.toString());
			
			});
			
			$("#btnDeleteLsmCod").show();
			
		}
		 gfModalPopTop('#layer1');
	}
	
	/* lsm 과제 등록 validation */
	function fValidateLsmCod(){
		
		var chk = checkNotEmpty(
			[
	  	        ["lec_seq", "강의 코드를 입력해주세요" ]
			 ,  ["lec_name", "강의명을 입력해주세요"]
			]
		);
		
		if(!chk){
			return;			
		}
		
		return true;
	}
	

	/* 단건 조회 */
	function fSelectLsmCod(task_seq, lec_seq) {

		var param = { 
								task_seq : task_seq 
								, lec_seq : lec_seq
								};

		var resultCallback = function(data) {
			fSelectLsmResult(data);
			console.log(data);
		};

		callAjax("/lsm/selectLsmCod.do", "post", "json", true, param,	resultCallback);

	}
	
	/* 단건조회 콜백 */
	function fSelectLsmResult(data) {

		if(data.result == "Success"){
			
			//모달 팝업
			gfModalPop("#layer1");
			
			console.log(data.lsmModel);
			
			//폼 데이터 설정
			fInitFormLsm(data.lsmModel);
			
			console.log(data.lsmModel);
			
		} else {
			
			alert(data.resultMsg);
			
		}	
	}

	/*모달실행*/
	function fPopModalLsmCod(task_seq,lec_seq) {

		console.log(task_seq +" " +  lec_seq );
	
		//신규저장
		if (task_seq == null || task_seq == "" || task_seq == "undefined") {

			//Tranjection type 설정
			$("#action").val("I");
			
		//	$("#enr_user").val(loginId);
			$("#enr_user").val('${sessionScope.loginId}');
			
			//리스트 폼 초기화
			fInitFormLsm();
			
			console.log('${sessionScope.loginId}');

			//모달 팝업
			gfModalPop("#layer1");

		} else {

			// Tranjection type 설정
			$("#action").val("U");

			//console.log(task_seq +" " +  lec_seq);
			
			//단건 조회
			fSelectLsmCod(task_seq, lec_seq, fil_seq);
			
	

		}
	}
	
	/* 저장 */
	function fSaveLsmInfo(){
	
		//vaildation 체크
		if(!fValidateLsmCod()){
			return false;
		}
		
		//시스템 ID 유무로 신규/수정 판단하기
		if($("#action").val() == 'I'){
			if(confirm('저장 하시겠습니까?') == false){
				return;
			}
		}else if($("#action").val() == 'U'){
			if(confirm('변경 내용을 수정 하시겠습니까?') == false){
				return;
			}
	}
		fSaveLsmCod();
	}

	/*  */
	function fSaveLsmCod(){
		/* 파일첨부 */
		var frm = document.getElementById("myForm");
		console.log(frm);
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);
		console.log(frm);

		var resultCallback = function(data){
			fSaveLsmResult(data);
		};
		
		console.log(fileData);
		
		callAjaxFileUploadSetFormData("/lsm/saveLsmCod.do","post","json",true, fileData , resultCallback);
		
	}
	
	
	/* 저장 콜백  */
	function fSaveLsmResult(data){
		
		console.log(data + "331");
		
		
		//목록 조회 페이지 번호
		var currentPage = "1";
		
		if ($("#action").val() != "I"){
			currentPage = $("#currentPageLsmCod").val();
			console.log(currentPage);
		}
		
		if(data.result == "Success"){
			
			
			$("#lsm_file").val(""); //첨부파일
			$("#fil_seq").val(""); // 일련번호
			
			//응답 메시지 출력
			alert(data.resultMsg);
			
			//모달 닫기
			gfCloseModal();
			
			//목록 조회
			fselectLsmList(currentPage);
			
		} else {
			//오류 응답 메시지 출력
			alert(data.resultMsg);
		}
			
		
		fselectLsmList(currentPage);
		//입력폼 초기화
		//fselectLsmList();
		
	}
	
	
	/* 삭제 */
	function fDeleteLsmCod(){
		
		var resultCallback = function(data){
			fDeleteLsmResult(data);
		};
		
		callAjax("/lsm/deleteLsmCod.do", "post", "json", true, $("#myForm").serialize(), resultCallback);	
	}
	
	/*  삭제 리콜 */
	function fDeleteLsmResult(data){
		
		var currentPage = $("#currentPageLsmCod").val();
		
		
		if(data.result == "Success"){
			
			//응답메시지 출력
			alert(data.resultMsg);
			
			//모달 닫기
			gfCloseModal();
			
			//목록 조회
			fselectLsmList(currentPage);
			
		} else {
			alert(data.resultMsg);
		}
	}
	
	function fDownloadLsmFil(task_seq, snm){
		
		var params = "";
		params += "<input type='hidden' name='task_seq' value='"+ task_seq +"' />";
		params += "<input type='hidden' name='snm' value='"+ snm +"' />";
		
		jQuery("<form action='/lsm/downloadLsmFil.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
	}
	
	function fDeleteLsmFile(snm){
		
		var fil_seq = $("#fil_seq").val();
		if(fil_seq != "") fil_seq += ",";
		fil_seq += snm;
		
		$("#fil_seq").val(fil_seq);    	// 첨부파일 일련번호
		$("#lsm_file_"+snm).empty();				// 첨부파일 화면 삭제
		
		
	}
	
	//학생 과제 다운로드
	function fDownloadLsmStuFil(task_seq, lec_seq){
		
		var params = "";
		params += "<input type='hidden' name='task_seq' value='"+ task_seq +"' />";
		params += "<input type='hidden' name='lec_seq' value='"+ lec_seq +"' />";
		
		jQuery("<form action='/lsm/downloadLsmStuFil.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
		
		
	}
	
	// 과제 제출 학생 조회
	
	function fStuLsmCod( task_seq, lec_seq){
		
		var currentPage = currentPage || 1;
		
		//정보 설정
		$("#lec_seq").val(lec_seq);
		$("#task_seq").val(task_seq);
		
		var param = {
					lec_seq : lec_seq
				,	task_seq : task_seq
				,	pageSize : pageSizeLsmStuCod
				,   currentPage : currentPage
				
		}
		
		var resultCallback = function(data) {
			fileStuCodResult(data, currentPage);
		};
		
		callAjax("/lsm/LsmStuCod.do", "post", "text" , true, param, resultCallback);
		
	}
	
	// 제출 학생 조회 콜백 
	
	function fileStuCodResult (data, currentPage) {

		//console.log(data);
		
		var $data = $($(data).html());
		
		result  = $data.find("#result").text().replace(/^\s*/, "") ;;
		resultMsg = $data.find("#resultMsg").text();
		
/* 		console.log(result);
		console.log("Success") */
		
		if(result  == "Success"){
			
			$("#LsmStuList").empty();
			
			var $data = $($(data).html());
			
			//신규목록
			var $LsmStuList = $data.find("#LsmStuList");
			$("#LsmStuList").append($LsmStuList.children());
			
			//총 개수 추출
			var $totalLsmStu = $data.find("#totalCntLsmStu");
			var totalLsmStu = $totalLsmStu.text();
			
			//페이지 네비게이션 생성
			var  paginationHtml = getPaginationHtml(currentPage, totalLsmStu,pageSizeLsmStuCod, pageBlockSizeLsmStuCod, 'fStuLsmCod');
			$("#LsmStuPagination").empty().append(paginationHtml);
			
			//현재페이지 설정
			$("#currentPageLsmDtlCod").val(currentPage);
			
			console.log(data);
			
		} else {
			
			alert(  data.resultMsg );
			
		}	
	}
		
</script>
</head>
<body>
	<form id="myForm"  action=""  method="">
	
		<input type="hidden" id="currentPageLsmCod" value="1"> 
		<input type="hidden" id="currentPageLsmDtlCod" value="1"> 
		<input type="hidden" name="action"  id="action" value="">
		<input type="hidden" name="fil_seq" id="fil_seq">



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
								<a href="#" class="btn_set home">메인으로</a> 
								<a href="#"  class="btn_nav">학습 관리</a> 
								<span class="btn_nav bold"> 과제  관리</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>과제 등록 리스트</span> 
								<span class="fr"> 
								<a class="btnType blue" href="javascript:fPopModalLsmCod();" 	name="modal"><span>과제 등록</span></a>
								</span>
							</p>

							<div class="divLsmCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="8%">
										<col width="8%">
										<col width="18%">
										<col width="15%">
										<col width="18%">
										<col width="*">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">순번</th>
											<th scope="col">과제번호</th>
											<th scope="col" style="display:none">강의번호</th>
											<th scope="col">강의명</th>
											<th scope="col">과제명</th>
											<th scope="col">강사명</th>
											<th scope="col">등록시간</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="listLsmCod"></tbody>
								</table>
							</div>

							<div class="paging_area" id="lsmCodPagination"></div>
							
						<p class="conTitle mt50">
							<span>학생 목록</span> 
						</p>
	
						<div class="divLsmStuCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
										<col width="8%">
										<col width="15%">
										<col width="15%">
										<col width="20%">
										<col width="*%">
										<col width="*%">
								</colgroup>
	
								<thead>
									<tr>
											<th scope="col">순번</th>
											<th scope="col" style="display:none">강의번호</th>
											<th scope="col">강의명</th>
											<th scope="col">학생명</th>
											<th scope="col">파일</th>
											<th scope="col">등록시간</th>
											<th scope="col">비고</th>
									</tr>
								</thead>
							
									<tbody id="LsmStuList">
									<c:if test="${totalCntLsmDtlCod eq 0}">
									<tr><td colspan="12">과제를 선택해 주세요.</td></tr>
									</c:if>
										
								 </tbody>

							</table>
						</div>
						
							<div class="paging_area" id="LsmStuPagination"></div>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> 
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div> 
		
		<!-- 모달팝업 -->
			<div id="layer1" class="layerPop layerType2" style="width: 700px; height: 500px;">
		<dl>
			<dt>
				<strong>과제 관리</strong>
			</dt>
			<dd class="content" >
			
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
								<td style="display : none"><input type="hidden" name="task_seq" id="task_seq" ></td>
							</tr>
							<tr>
								<th scope="row"  id="nm"  >강의선택 <span class="font_red">*</span></th>
								<td >
								        <select name="lec_seq" id="lec_seq" onchange ="lecNmDisplay(this.form)" >
					
									    </select>
								</td>
								<th scope="row">강의명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="lec_nm" id="lec_nm" value=""/>
							    </td>
							</tr>
							<tr>
								<th scope="row">과제명</th>
								<td><input type="text" class="inputTxt p100" name="task_nm" id="task_nm" /></td>
								<th scope="row">담당 강사명</th>
								<td>
									<input type="text" name="enr_user"  id="enr_user"  value=""  readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<th scope="row"  rowspan= "3"> 내용 </th>
								<td rowspan="3" colspan="3"><textarea class="inputTxt p100"  name="task_cont" id="task_cont"  style =  "resize : none"></textarea></td>
							</tr>
							<tr></tr>
							<tr></tr>
							<tr>
								<th scope="row">파일첨부</th>
								<td colspan="3">
								<input type="file" class="inputTxt p100" name="lsm_file" id="lsm_file">
								<div id="dv_lsm_file"></div>
								</td>
							</tr>
					
					</tbody>
					
				</table>
		
				<!-- e : 여기에 내용입력 -->
			
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveLsmCod" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDeleteLsmCod" name="btn"><span>삭제</span></a>  
					<a href=""	class="btnType gray"  id="btnCloseLsmCod" name="btn"><span>취소</span></a>
				</div>
					
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
			
	
	</form>
</body>
</html>