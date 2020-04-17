<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge" />
<title>학습자료</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<script>

var firstVueList;
var detailVueList;
var serachVue;

// 페이징 설정 
var SssPageSize = 5;    	// 화면에 뿌릴 데이터 수 
var SssPageSizevue = 5;
var SssPageBlock = 5;		// 블럭으로 잡히는 페이징처리 수


	$(function(){
		init();
		selectSssList();
		fButtonEvent();
	});
	
	function init(){
		
		firstVueList = new Vue({
			el : '#firstVueTable',
			components : {
				'bootstrap-table' : BootstrapTable
			},
			data : {
				items:[],
			},
			methods:{
				rowClicked:function(row){
					
					var tdArr = new Array(); // 배열
					
					//현재 클릭된 Row(<tr>)
					var tr = $(row);
					var td = tr.children();
					
					td.each(function(i){
						
						tdArr.push(td.eq(i).text());
						
						
					});
					
					console.log(tdArr);
					
					SssDetail(tdArr[1],tdArr[2]);
					
				}
			}
			
			
		});
		
		detailVueList = new Vue({
			el: '#detailvue',
			data:{
					ldo_seq : ''
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
				,	item : [] 
			},
 			methods: {
				DownloadLecDoc:function(){
					if(confirm("다운하시겠습니까?")){
						fDownLoadFIle();
						
					}else{
						alert("취소");
					}
				},
				
				setFileName : function(){
					this.lgc_fil_nm=event.target.files[0].name;
				}
			} 
		});
		
		searchVue = new Vue({
			el: '#searcharea',
			data :{
					pageSize : SssPageSize,
					searchKey : '',
					searchWord : ''
			},
			method:{
				searchBtn:function(){
					selectSSSList(this.currentPage, this.searchKey, this.searchWord);
				}
				
			}
		});
		
		

	}//init
	
	function fButtonEvent(){
		
		$('a[name=btn]').click(function(e){
			e.preventDefault();
			var btnId = $(this).attr('id');
			
			switch (btnId){
			
				case 'btnClose':
					gfCloseModal();
					selectSssList();
					break;
			}
		});
	}

	function selectSssList(currentPage, searchKey, searchWord){
		
		searchVue.searchKey = searchKey || 'lec_title';
		
		var currentPage = currentPage || 1;
		var searchKey = searchKey || '' ;
		var searchWord = searchWord || '';
		
		
		var param = {
				currentPage : currentPage,
				pageSize : SssPageSize,
				searchKey : searchKey,
				searchWord : searchWord
		}
		
		var resultCallback = function(data){
			SssListResult(data, currentPage);			
		}
		
		callAjax("/ldd/SssList.do","post","json",true,param,resultCallback);
	}

	function SssListResult(data, currentPage){
		
		console.log(data);
		
		firstVueList.items = [];
		firstVueList.items = data.SssList;
		
		
		var totalCnt = data.totalCnt;
		
		var pagingnavi = getPaginationHtml(currentPage, totalCnt, SssPageSize, SssPageBlock, 'selectSssList');
		
		 $("#pagingnavi2").empty().append(pagingnavi);
		 
		 //현재페이지 설정
		 $("#currentPage").val(currentPage);
		 
	}
	
	//단건조회
	function SssDetail(ldo_seq, lec_seq){
		
		var param = {
				ldo_seq : ldo_seq,
				lec_seq : lec_seq
		}
		
		var resultCallback = function(data){
			selectSssData(data);
		}
		
		callAjax("/ldd/SssDetail.do","post","json",true, param, resultCallback);
		
	}
	
	//단건조회 결과
	function selectSssData(data){
		console.log(data);
		
/* 		ved.ldo_seq = data.ldo_seq;
		ved.enr_user = data.enr_user;
		ved.lec_title = data.lec_title;
		ved.ldo_cont = data.ldo_cont;
		ved.lgc_fil_nm = data.lgc_fil_nm;
		ved.psc_fil_nm = data.psc_fil_nm;
		ved.fil_siz = data.fil_siz;
		ved.fil_ets = data.fil_ets; */
		
		detailVueList.item = data;
		console.log(detailVueList.item);
		SssPopup("#Sss_Detail");
		
	}
	
	function SssPopup(id) {

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

	function fDownLoadFIle(){
/* 		alert("dd");
		console.log(detailVueList.item);
		 */
		var params = "";
		params += "<input type='hidden' name='ldo_seq' id='ldo_seq' value='"+detailVueList.item.ldo_seq+"'/>";
		params +=  "<input type='hidden' name='lec_seq' id='lec_seq' value='"+detailVueList.item.lec_seq+"'/>";
		
		jQuery("<form action='/ldd/downloadFile.do' method='post'>" + params + "</form>").appendTo('body').submit().remove();
		
		
	}	

	function fSearchWord(){
		var searchKey = $("#searchKey").val();
		var searchWord = $("#searchWord").val();
		
		selectSssList(1,searchKey, searchWord);
	}

</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPage" value="1">
	<input type="hidden" name="action" id="action" value="">
	
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
								class="btn_nav">학습 지원</a> <span class="btn_nav bold">학습 자료</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강의 목록</span> 
							<span class="fr"> 
							<select id="searchKey" name="searchKey" style="height: 30px" v-model="searchKey">
									<option value="lec_title" id="option1" selected = "selected" >강의명</option>
									<option value="enr_user" id="option2">작성자</option>
							</select> 
							<input type="text" id="searchWord" name="searchWord"
								v-model="searchWord" placeholder="검색할 단어를 입력해주세요" @keyup.enter="searchBtn"
								style="height: 30px; letter-spacing: -2px;" > 
								<a href="javascript:fSearchWord();" id="searchBtn" name="searchBtn"><strong>검색</strong></a> 
								<!-- <input type="button" class="btnType blue" id="searchBtn" name="searchBtn" value="  검 색  "> -->
							</span>
						</p>
						
						
						<div id = "firstVueTable">
							<div class="bootstrap-table">
								<div class= "fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right">	</div>
								</div>
								<div class = "fixed-table-container" style = "padding-bottom: 0px;">
									<div class="fixed-table-body">
								<table id="vuetab" class="col2 mb10" style="width: 99%;">
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="20%">
										<col width="15%">
										<col width="*">
										<col width="10%">
									</colgroup>
		
									<thead>
										<tr>
											<th data-field="index">순번</th>
											<th data-field="ldo_seq">과제번호</th>
											<th data-field="lec_seq" style= "display : none">강의번호</th>
											<th data-field="lec_title">강의명</th>
											<th data-field="enr_user">강사명</th>
											<th data-field="enr_date">등록일자</th>
											<th data-field="lgc_fil_nm">비고</th>
										</tr>
									</thead>
									<tbody v-for="(list, index) in items" v-if="items.length" >
										<tr onclick="firstVueList.rowClicked(this)">
													<td>{{ index + 1}}</td>
													<td>{{ list.ldo_seq }}</td>
													<td style="display:none">{{ list.lec_seq}}</td>
													<td>{{ list.lec_title }}</td>
													<td>{{ list.enr_user }}</td>
													<td>{{ list.enr_date }}</td>
													<td>{{ list.lgc_fil_nm  }}</td>
												</tr>
									</tbody>
								</table>
								</div>
								</div>
							</div>
						</div>
					
						<div class="paging_area"  id="pagingnavi2"> </div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
			<jsp:include page="/WEB-INF/view/sss/ldd/SelectLecDoc.jsp"></jsp:include>
	<!--// 모달팝업 -->
</form>
</body>
</html>