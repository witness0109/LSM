<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge" />
<title>진도관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script>

	// Vue 객체 선언
	var ProgListVue;
	var ProgDetailVue;
	var ProgSearchVue;

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
				items : []
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
/* 			lec_seq: '',
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
		
		ProgSearchVue = new Vue({
			el: '#searcharea',
			data : {
				pageSize : LsmProgPageSize,
				searchKey: '' ,
				searchWord : ''
			},
			method:{
				searchbtn:function(){
					LsmProgList(this.currentPage, this.searchKey, this.searchWord);
					
				}
				
			}
			
		});
		
		
		
		
	}; // init
		

	
	function fButtonEvent(){
		$('a[name=btn]').click(function(e){
			e.preventDefault();
			
			var btnId =$(this).attr('id');
			
			switch(btnId){
				case 'btnSave' :
					fSaveProg();
					break;
					
				case 'btnClose' :
					gfColseModal();
					LsmProgList();
					break;
			}
			
			
		})
		
		
		
		
	}; // Button이벤트 
	
	//조회
	function LsmProgList(currentPage, searchKey, searchWord){
		
		ProgSearchVue.searchKey = searchKey || 'lec_nm';
		
		var currentPage = currentPage || 1;
		var searchKey = searchKey || '';
		var searchWord = searchWord || '';
		
		var param = {
				currentPage : currentPage,
				pageSize : LsmProgPageSize,
				searchKey : searchKey,
				searchWord : searchWord
			
		};
		
		var resultCallback = function(data){
			LsmProgResult(data , currentPage);
		}
		
		callAjax("LsmProgList.do","post","json",true, param, resultCallback);
		
		
	}
	
	function fGetProgress(data){
	/* 	
		//console.log(data);
		
		var st = new Array();
		var ed = new Array();
		
		for(var i = 0; i < data.length; i++ ){
		
			st[i] = data[i].lec_st;
			ed[i] = data[i].lec_ed;
			
		}
		
		var st_year = st[0].substr(0,4);
		var st_month = st[0].substr(5,2);
		var st_day = st[0].substr(8,2); 
		console.log(st_year+ " " + st_month + " " +  st_day);
		
		var ed_year = ed[0].substr(0,4);
		var ed_month = ed[0].substr(5,2);
		var ed_day = ed[0].substr(8,2); 
		console.log(ed_year+ " " + ed_month + " " +  ed_day);

		var startLec = new Date(st_year,st_month,st_day).getDate();
		var endLec = new Date(ed_year,ed_month,ed_day).getDate();
		var todayLec = new Date()
		
		console.log(endLec);
		console.log(todayLec);
		
	
		var wholeday = endLec - startLec;
		var today = endLec  - todayLec;
		
		console.log(wholeday +''+ today);
 */
	
	}
	
	//조회콜백
	function LsmProgResult(data, currentPage){
		
		console.log(data);
		
				/* $("#add").val(avgDay); */
		
		
/* 		$("LsmProgList").empty();
		$("#LsmProgList").append(data); */
		
		//날짜 진도율 구하기
		fGetProgress(data.LsmLectureList);
		
		
		ProgListVue.items = [];
		ProgListVue.items = data.LsmLectureList;
		
		var $data = $($(data).html());
		var $LsmLectureList = $data.find("#LsmLectureList");
		var totalCntProg = $LsmLectureList.text();
		var totalCnt = data.totalCnt;
		var pagingnavi = getPaginationHtml(currentPage, totalCnt, LsmProgPageSize
				, LsmProgPageBlock,'LsmProgList');
		
		//console.log(pagingnavi);
		
		$('#pagingnavi2').empty().append(pagingnavi);
		
		$('#currentPageProg').val(currentPage);
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
	
	function fSearchWord(){
		
		var searchKey = $('#searchKey').val();
		var searchWord = $('#searchWord').val();
		
		LsmProgList(1, searchKey, searchWord);
		
	}
	
	function fSaveProg(){
		
	
		
		var frm = document.getElementById("LsmProgForm");
		
		console.log(frm);
		
		var resultCallback = function(data){
			fSaveProgResult(data);
			console.log(data);
		};
		
		CallAjax("updateProg.do","post","json",true, param, resultCallback);
		
		
	}
	
	function fSaveProgResult(data){
		
		console.log(data);
		
		var currentPage = '1';
		
		if(data.resultMsg == "Success"){
			
			LsmProgList(currentPage);
			
			
		}
		
		
	}
	

</script>
<style>
/* progress {
	board-style: none;
	float: left;
	-webkit-writing-mode: horizontal-tb !important;
	-webkit-appearance: progress-bar;
	box-sizing: border-box;
	display: inline-block;
	height: 1em;
	width: 10em;
	vertical-align: -0.2em;
}

#add {
	height: 28px;
	font-family: "맑음고딕";
	font-weight: bold;
	font-size: medium;
} */

</style>
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
							<span> 진도관리 리스트 </span>
							 <span class="fr"> 
							<select id="searchKey" name="searchKey" style="height: 30px" v-model="searchKey">
									<option value="lec_nm" id="option1" selected = "selected" >
										강의명</option>
									<option value="enr_user" id="option2">강사명</option>
							</select> 
							<input type="text" id="searchWord" name="searchWord"
								v-model="searchWord" placeholder="검색할 단어를 입력해주세요"
								style="height: 30px; letter-spacing: -2px;" > 
								<a class="btnType blue" href="javascript:fSearchWord();" id="searchBtn" name="searchBtn"><span>검색</span></a> 
								<!-- <input type="button" class="btn Type blue" name="searchBtn" id="searchBtn" value="검색">  -->
							</span>
						</p>
						
						<input type="hidden" id="currentPageProg" value="1"> 
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
													<th data-field="avgDay">진도</th>
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
													<td></td>
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
		 <jsp:include page="/WEB-INF/view/lsm/prog/LsmProgDetail.jsp"></jsp:include> 
	


</form>
</body>
</html>