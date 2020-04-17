<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>진도관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script>

	// Vue 객체 선언
	var ProgListVue;
	var ProgDetailVue;


	//페이징
	var LsmProgPageSize = 5;
	var LsmProgPageSizevue = 5;
	var LsmProgPageBlock = 5;
	
	/* onload이벤트 */
	$(function(){
	
		init();
		fButtonEvent();
		LsmProgList();
		
	});
	
	
	function init(){
		
		//첫화면
		ProgListVue = new Vue({
			el : '#vuetable',
			components : {
				'bootstrap-table' : BootstrapTable
			},
			data : {
				items : [],
				options : {
					
				}
				
			},
			methods:{
				rowClicked : function(row){
					
					var tdArr = new Array();//배열선언
					
					//현재 클릭된 Row(<tr>)
					var tr = $(row);
					var td = tr.children();
					
					td.each(function(i){
						
						tdArr.push(td.eq(i).text());
					});
					
					console.log(tdArr[1]);
					
					selectDetailLsmProg(tdArr[1]);
					
					//alert( "아직 " + tdArr );
				}
			}
		});
		
		//디테일화면
		ProgDetailVue = new Vue({
			el: '#detailtable',
			data : {
				items:[]
/* 				lec_seq: '',
				lec_nm: '',
				lec_enr: '',
				lec_contents : '',
				lec_tm:'',
				lec_st:'',
				lec_ed:'',
				enr_user:'',
				enr_date:'',
				rm_seq:'',
				user_id:'' */
			}
		});
		
		
		
	}; // init
		

	
	function fButtonEvent(){
		
		
	}; // Button이벤트 
	
	//조회
	function LsmProgList(currentPage){
		
		
		var currentPage = currentPage || 1;
		
		var param = {
				currentPage : currentPage
				
		};
		
		var resultCallback = function(data){
			LsmProgResult(data , currentPage);
		}
		
		callAjax("LsmProgList.do","post","json",true, param, resultCallback);
		
		
	}
	
	//조회콜백
	function LsmProgResult(data, currentPage){
		
		console.log(data);
		
		$("LsmProgList").empty();
		
		ProgListVue.items = [];
		ProgListVue.items = data.LsmLectureList;
		
		
	}
	
	//단건조회(수정)
	
	function selectDetailLsmProg(lec_seq){
		
		var param = {
				
				lec_seq : lec_seq
				
		}
		
		
		var resultCallback = function(data){
			
			LsmProgDetail(data);
			
		}
		
		callAjax("selectProgDetail.do","post","json",true, param, resultCallback);
		
	}
	
	
	function LsmProgDetail(data){
		
		console.log(data);
		
		ProgDetailVue.items = [];
		ProgDetailVue.items = data.LsmLectureList;
		
		console.log(ProgDetailVue.items);
		
		LsmProgPopup("#prog_edit");
	}
	
	 
	function LsmProgPopup(id){
		
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
		$(id).fadeIn(100); 
		
		
	}

</script>
</head>
<body>

<form id= "LsmProgForm" action ="" method="" >

	<!-- 모달 배경 -->
	<div id="mask"></div>
	<div class="hiddenData">
		<span id=""></span> 
		<span id=""></span>
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
							 <a href="#" class="btn_set refresh">새로고침</a>
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
							<input type="text" id="searchWord" name="searchWord"
								v-model="searchWord" placeholder="검색할 단어를 입력해주세요"
								style="height: 30px; letter-spacing: -2px;" > 
								<a href="javascript:fSearchWord();" id="searchBtn" name="searchBtn"><strong>검색</strong></a> 
								<!-- <input type="button" class="btn Type blue" name="searchBtn" id="searchBtn" value="검색">  -->
							</span>
						</p>
						<span class="fr">
						 <a class="btnType blue"	href="javascript:fWriterLecDoc();" name="modal"><span>학습자료등록</span></a>
						</span> <br>
						<div></div>
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



						<input type="hidden" id="currentPage" value="1"> 
						<input type="hidden" id="currentPagevue" value="1">

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
												<col width="10%" >
												<col width="10%" style="display: none">
												<col width="15%">
												<col width="15%">
												<col width="25%">
												<col width="10%">
												<col width="10%">
											</colgroup>
											<thead>
												<tr>
													<th data-field="index" >번호</th>
													<th data-field= "lec_seq" style="display:none">강의번호</th>
													<th data-field="lec_nm">과목명</th>
													<th data-field="user_id">강사명</th>
													<th data-field="lec_st">강의시작날</th>
													<th data-field="">진도</th>
													<th data-field="">비고</th>
												</tr>
											</thead>

											<tbody v-for="(list, index) in items" v-if="items.length">
												<tr onclick="ProgListVue.rowClicked(this)">
													<td>{{ index + 1}}</td>
													<td style="display:none"> {{list.lec_seq}}</td>
													<td>{{ list.lec_nm }}</td>
													<td>{{ list.user_id }}</td>
													<td>{{ list.lec_st }}</td>
													<td>진도설정</td>
													<td></td>
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
					<h3 class="hidden">풋터 영역</h3> 
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>

		</div>
	</div>

	<!-- 모달팝업 -->
	<jsp:include page="/WEB-INF/view/lsm/LsmProgressDetail.jsp"></jsp:include> 

	
	<%-- <jsp:include page="/WEB-INF/view/lss/enr/UpdateLectureData.jsp"></jsp:include> --%>
	


</form>
</body>
</html>