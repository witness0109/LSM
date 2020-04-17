
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>
	// onLoad
	$(function(){
		
		btnClickEvent();
		
	});
	
	function btnClickEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault();
			
			var btnId = $(this).attr('id');	
			
			switch (btnId){
			case 'btnSave' :
				alert(btnId);
				roomInfoSave();
				
				break;
			}
		});
	}
	
			
	// 저장 기능
	function roomInfoSave() {
	
		// file form 값 생성
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);
		
		var resultCallback = function(data) {
			roomInfoSaveResult(data);
			
		};
		callAjaxFileUploadSetFormData("/mrm/roomRegistAction.do", "post", "json", true, fileData, resultCallback);
		
	}
	function roomInfoSaveResult(data) {
		
		if(data.result == "SUCCESS") {
			alert(data.resultMsg);
			$("#rmPic_file").val(""); //첨부파일
		}else {
			//오류 응답 메시지 출력
			alert(data.resultMsg);
		}
	}
</script>
</head>
<body>
<form id="myForm" action = "">
	<input type="hidden" id="currentPageLsmCod" value="1"> 
		<input type="hidden" id="currentPageLsmDtlCod" value="1"> 
		<input type="hidden" id="tmp_Cod" value=""> 
		<input type="hidden" id="tmp_CodNm" value="">
		<input type="hidden" name="action"  id="action" value="">
		<input type="hidden" name="lms_file_snm" id="lms_file_snm">
		<input type="hidden" name="task_seq" id="task_seq">
	<!-- 모달 배경 -->
	<div id="mask"></div>

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
					<div class="home_area">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">강의실 등록</span> 
							<a href="#"class="btn_set refresh">새로고침</a>
						</p>
					</div>
					
					<h3 class="hidden">강의실 검색 영역</h3>
					<div class="room_registerbox">
						<div class="room_register_tit">
							강의실 등록
						</div>
						<div class="room_name_area">
							<div class="room_name_tit">
								강의실명
							</div>
							<div class="room_name_input">
								<input type="text" name="rm_name">
							</div>
						</div>
						<div class="room_size_area">
							<div class="room_size_tit">
								강의실 크기
							</div>
							<div class="room_size_input">
								<input type="text" name="rm_size"> m<sup>2</sup>
							</div>
						</div>
						<div class="room_chair_area">
							<div class="room_chair_tit">
								허용 자리수
							</div>
							<div class="room_chair_input">
								<input type="text" name="rm_pper">
							</div>
						</div>
						<div class="room_pic_area">
							<div class="room_pic_tit">
								강의실 사진 <input type="file" name="rmPic_file" id="rmPic_file">
							</div>
							
						</div>
					</div>
					<!-- /.room_registerbox -->
						<div class="btn_areaC mt30">
							<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						</div>
					
					<!-- /.roomRegister_box -->
					
				</li>
			</ul>
		</div>
	</div>

</form>
</body>
</html>