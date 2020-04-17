<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학습자료관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>

click-able rows
	.clickable-rows {tbody tr td { cursor:pointer; } }
	


.el-table__expanded-cell {
	cursor: default;
}

</style>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script>
	var svm;
	var ved;
	var vm;
	var newEnr;
	
	var loginID = '${sessionScope.loginId}';
	
	var lecSeq;
	var lecNm;
	
	
	// 페이징 설정 
	var LecDocPageSize = 10;    	// 화면에 뿌릴 데이터 수 
	var LecDocPageSizevue = 10;
	var LecDocPageBlock = 10;		// 블럭으로 잡히는 페이징처리 수
	
	
	/* onload 이벤트 */
	$(function(){
		
		init();
		selectLecDocList();
		fButtonEvent();
		
	});
	
		//
	function init(){
  
		 
		 //검색 vue
/* 		 new Vue({
			el: '#searcharea2',
			name : 'date-picker',
			props: {
				date:String
			},
			mounted:function(){
													var that = this;
													$(this.$el).datepicker({
														'autoclose':true,
														'minViewMode':0, // day까지 선택
														'maxViewMode':2,
														'format':'yyyy-mm-dd'//날짜포맷
													}).on('changeDate',function(e){
																var year = e.date.getFullYear();
																var month = e.date.getMonth() + 1;
																if(month < 10) month = '0' + month;
																var day = e.date.getDate();
																that.$emit('change',String(year)+'-'+String(month)+'-'+day);
													});
		
			},
			 updated: function(){
				 $(this.$el).datepicker('update',this.date);
			 }
		 }); */
		 
		 	//검색
			svm = new Vue({
				el: '#searcharea',
				data : {
						pageSize : LecDocPageSize,
						searchKey:'',
						searchWord:''
				},
				method:{
					searchbtn:function(){
						selectLecDocList(this.currentPage, this.searchKey, this.searchWord);
					}
				},
				computed:{
					
					
				}
			
			});	 
			
			/* 등록화면 */
			newEnr = new Vue({
				el: '#writevue',
				data:{
						action:''
					,	ldo_seq : ''
					,	lec_seq : ''
					,	enr_user : ''
					,	lec_title : ''
					,	ldo_cont : ''
					,	enr_date: ''
					,  	lgc_fil_nm: ''
					,	psc_fil_nm: ''
					,	fil_siz:''
					,	fil_ets:'' 
					
				}
			});

			ved= new Vue({
				el: '#editvue',
				data:{
						action:''
					,	ldo_seq : ''
					,	lec_seq : ''
					,	enr_user : ''
					,	lec_title : ''
					,	ldo_cont : ''
					,	upd_date: ''
					,	enr_date: ''
					,   lgc_fil_nm: ''
					,	psc_fil_nm: ''
					,	fil_siz:''
					,	fil_ets:''
				}
				
			});

			vm = new Vue({
				el: '#vuetable',
				components : {
					'bootstrap-table': BootstrapTable					
				},
				data : {
					items: [],
					options: {
					}
				},
				methods:{
					rowClicked:function(row){

						var tdArr = new Array(); //배열선언
						
						//현재 클릭된 Row(<tr>)
						var tr = $(row);
						var td = tr.children();
						
						td.each(function(i){
							tdArr.push(td.eq(i).text());
						});
						
						selectDetailLss(tdArr[1] , tdArr[2]);
						
						console.log(tdArr);
						
					}
					
				}

			});
			
			
			
			
		 
		}; //init
		
		//버튼 이벤트
		function fButtonEvent(){
			$('a[name=btn]').click(function(e){
				e.preventDefault();
				var btnId = $(this).attr('id');
				
				switch (btnId){
					case 'btnSave' :
						fSaveLecDocInfo();
						break;
						
					case 'btnUpdate':
						fUpdateLecDoc();
						break;
						
					case 'btnDelete' :
						fDeleteLecDoc();
						break;
						
					case 'btnClose':
						gfCloseModal();
						selectLecDocList();
						break;
				}
			});
		}
		
		
		
	
		//조회
		function selectLecDocList(currentPage, searchKey, searchWord){
			
			svm.searchKey = searchKey || 'lec_title';
			
			var currentPage = currentPage || 1; 
			var searchKey = searchKey || '';
			var searchWord = searchWord || '';
			
			
			var param = {
					currentPage : currentPage,
					pageSize : LecDocPageSize,
					searchKey : searchKey,
					searchWord : searchWord
			};
			
			//모달 닫기
			gfCloseModal();
			
			
			var resultCallback = function(data){
				LecDocListResult(data, currentPage);
			}
			
			callAjax("/enr/LecDocList.do","post","json",true,param,resultCallback);
		}
		
		//조회 콜백
		function LecDocListResult(data, currentPage){
			
			console.log(data);
			
			
			$("#LecDocList").empty();
			
			$("#LecDocList").append(data);
	
			vm.items=[];
			vm.items = data.LecDocList;

			//var $data = $($(data).html());
			//console.log($data);
				
			lecSeq = data.lecSeq;
			lecNm = data.lecNm;
			
			//console.log(lecSeq + "   --  "  + lecNm);
			
				
			for (var count in lecNm){
				
				var option = $("<option value='"+ lecSeq[count] + "'>"+ lecNm[count] +"</option>");
				$("#lec_seq").append(option);
			}
				
			
			//리스트의 총개수 추출
			 var totalCnt = data.totalCnt;
			

			 var pagingnavi = getPaginationHtml(currentPage, totalCnt, LecDocPageSize,LecDocPageBlock, 'selectLecDocList');
			 
			 $("#pagingnavi2").empty().append(pagingnavi);
			 
			 //현재페이지 설정
			 $("#currentPage").val(currentPage);
			 
			
		}
		
		
		//자료등록 버튼
		function fWriterLecDoc(){
			
		//$("#loginID").append(loginID);
		
			newEnr.lec_title = "";
			newEnr.ldo_cont = "";
			
			//console.log(newEnr);
			
			newEnr.enr_user = loginID;
			newEnr.action = "I";

			console.log(newEnr);
			
			$("#lec_title").focus();
			
			lecDocWritePopup("#lecdoc_write");
			
			
		
		}
		

		function lecNmDisplay(form){
			
			var lnm = form.lec_seq.options[form.lec_seq.selectedIndex].text;
		
			console.log(lnm);

		}
		

		
	
		//저장 전 체크
		function fSaveLecDocInfo(){
/* 			if(!ValidateLssCod()){
				return false;
			} */
			
			//신규 저장 판단 
			if($("#action").val() == 'I'){
				if(confirm('저장 하시겠습니까?') == false ){
					return;
				}
			}
			fSaveLecDoc();
		}
		
		
		//저장
		function fSaveLecDoc(){
			
			alert("저장");
			
			newEnr.action = "I";
			
			$("#newaction").val(newEnr.action);
			$("#ldo_cont").val();
			
			var frm = document.getElementById("myLecDocForm");
			frm.enctype = 'multipart/form-data';
			var fileData = new FormData(frm);
			
			
			var resultCallback = function(data){
				fSaveLssResult(data);
				console.log(data);
			};
			
			console.log(fileData);
			
			callAjaxFileUploadSetFormData("/enr/saveFile.do", "post", "json",true, fileData,resultCallback);
		}
		
		//저장 콜백
		function fSaveLssResult(data){
			
			console.log(data);
			
			//목록 조회 페이지 번호
			var currentPage = "1";
			
			if($("#action").val()!="I"){
				currentPage = $("#currentPageLssCod").val();
				console.log(currentPage + "-- ");
			}
			
			if(data.resultMsg == "Success"){
				
				//alert(data.resultMsg);
				$("#lss_file").val("");//첨부파일
				
				gfCloseModal();
				
				//중복제거
			//	$("#lec_seq").html('');
				
				selectLecDocList(currentPage);
				
				
			} else {
				
				alert(data.resultMsg);
				
			}
		}
		
		//단건조회
		function selectDetailLss(lec_seq, ldo_seq){
			
				
			var param = {
					lec_seq : lec_seq,
					ldo_seq : ldo_seq
				}
			
			var resultCallback = function(data){
				selectLssdata(data);
			}
			
			callAjax("/enr/selectDetailLss.do","post","json",true,param,resultCallback);
			
		}

		function selectLssdata(data){
			
			console.log(data);
			
			//ved.item = data;
			//ved.lec_seq = data.lec_seq;
			ved.ldo_seq = data.ldo_seq;
			ved.enr_user = data.enr_user;
			ved.lec_title = data.lec_title;
			ved.ldo_cont = data.ldo_cont;
			ved.lgc_fil_nm = data.lgc_fil_nm;
			ved.psc_fil_nm = data.psc_fil_nm;
			ved.fil_siz = data.fil_siz;
			ved.fil_ets = data.fil_ets;
			
			
			lecDocWritePopup("#lecdoc_edit");
		}
		
		
		//수정
		function fUpdateLecDoc(){
			
			var resultCallback = function(data){
				selectLecDocList();
			};
			
			ved.action='U';
			
			console.log(ved.$data);
			
			callAjax("/enr/saveFile.do","post","json",true, ved.$data, resultCallback);
			
			gfCloseModal();
		}
		
		
		//삭제
		function fDeleteLecDoc(){
			
			var resultCallback = function(data){
				selectLecDocList();
			};
			
			ved.action='D';
			
			callAjax("/enr/saveFile.do","post","json",true, ved.$data, resultCallback);
		}
		


		
		function lecDocWritePopup(id) {

			//var id = $(this).attr('href');
			//alert("asdf");  
			var maskHeight = $(document).height();
			var maskWidth = $(document).width();

			$('#mask').css({'width':maskWidth,'height':maskHeight});

			$('#mask').fadeIn(200);
			$('#mask').fadeTo("fast", 0.5);
			/* $('#wqna_title').focus(); */
			var winH = $(window).height();
			var winW = $(window).width();
			var scrollTop = $(window).scrollTop();

			$(id).css('top', winH/2-$(id).height()/1.5+scrollTop);
			$(id).css('left', winW/2-$(id).width()/2);

			$(".layerPop").hide();
			$(id).fadeIn(100); //페이드인 속도..숫자가 작으면 작을수록 빨라집니다.
		}
		
		
		//검색
		function fSearchWord(){
			var searchKey = $("#searchKey").val();
			var searchWord = $("#searchWord").val();
			
			selectLecDocList(1,searchKey, searchWord);
		}
				

</script>
</head>
<body>

<form id= "myLecDocForm" action ="" method="" >

	<!-- 모달 배경 -->
	<div id="mask"></div>
	<div class="hiddenData">
		<span id="lecSeq">${lecSeq}</span> <span id="lecNm">${lecNm}</span>
	</div>
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
							<a href="#" class="btn_set home">메인으로</a>
							 <span class="btn_nav bold">학습지원</span> 
							 <span class="btn_nav bold">학습자료등록</span> 
							 <a href="javascript:selectLecDocList();" class="btn_set refresh">새로고침</a>
						</p>

						<!--                         <input type="text" id="EMP_ID" name="lgn_Id" placeholder="아이디" onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" style="ime-mode:inactive;" /> -->
						<p class="conTitle" id="searcharea">
							<span> 학습자료 등록 리스트 </span> <span class="fr"> 
							<select id="searchKey" name="searchKey" style="height: 30px" v-model="searchKey">
									<option value="lec_title" id="option1" selected = "selected" >
										제목</option>
									<option value="enr_user" id="option2">작성자</option>
									<option value="ldo_cont" id="option3">내용</option>
							</select> 
							<input type="text" id="searchWord" name="searchWord" 	v-model="searchWord" placeholder="검색할 단어를 입력해주세요" 
								style="height: 30px; letter-spacing: -2px;" > 
								<a class="btnType blue"  href="javascript:fSearchWord();" id="searchBtn" name="searchBtn"><span>검색</span></a> 
								<a class="btnType blue" href="javascript:fWriterLecDoc();" name="modal"><span>학습자료등록</span></a>
								<!-- <input type="button" class="btn Type blue" name="searchBtn" id="searchBtn" value="검색">  -->
							</span>
						</p>
						<span class="fr"> 
						
						</span> 
						
						<!-- <div>
							<template id="searcharea2">
							<div class="input-group date" style="width: 50px;">
								<input id="indate" name="indate" type="text"
									class="form-control" v-model="date"
									style="width: 75px; , text_align: center;" /> <span
									class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
							</template>
						</div> -->



						<input type="hidden" id="currentPage" value="1"> <input
							type="hidden" id="currentPagevue" value="1">

						<div id="vuetable">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right">	</div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

										<table id="vuedatatable" class="col2 mb10" style="width: 99%;">
											<colgroup>
												<col width="10%" style="display: none">
												<col width="10%" style="display: none">
												<col width="10%">
												<col width="25%">
												<col width="20%">
												<col width="15%">
											</colgroup>
											<thead>
												<tr>
													<th data-field="index" style="display: none">번호</th>
													<th data-field="lec_seq" > 강의번호</th>
													<th data-field="ldo_seq">자료 번호</th>
													<th data-field="lec_title">제 목</th>
													<th data-field="enr_date">등록일</th>
													<th data-field="loginID">작성자</th>
												</tr>
											</thead>

											<tbody v-for="(list, index) in items" v-if="items.length">
												<tr onclick="vm.rowClicked(this)">
													<td style="display: none">{{ index + 1}}</td>
													<td>{{ list.lec_seq }} </td>
													<td>{{ list.ldo_seq }}</td>
													<td>{{ list.lec_title }}</td>
													<td>{{ list.enr_date }}</td>
													<td>{{ list.enr_user }}</td>
												</tr>

											</tbody>
										</table>
										<div>
											<div>
												<div class="clearfix" />
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="paging_area" id="pagingnavi2"></div>
					</div>
				</li>
			</ul>

		</div>
	</div>

	<!-- 모달팝업 -->
	<jsp:include page="/WEB-INF/view/lss/enr/WriteLectureData.jsp"></jsp:include>

	<!-- 상세화면 모달   -->
	<jsp:include page="/WEB-INF/view/lss/enr/UpdateLectureData.jsp"></jsp:include>

</form>
</body>
</html>