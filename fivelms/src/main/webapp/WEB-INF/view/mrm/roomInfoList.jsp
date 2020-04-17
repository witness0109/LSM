<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<script type="text/javascript">

//페이징 설정  	
var noticePageSizevue = 3;		// 화면에 뿌릴 데이터 수 
var noticePageBlock = 3;		// 블럭으로 잡히는 페이징처리 수

var vm;
var svm;
var ved;
var ri;

var cPage;
var nowPage;

//var isM = isMobile();
var isM = false;
var popperProps = {
		  popperOptions: {
		    modifiers: {
		      preventOverflow: {
		        padding: 20
		      }
		    },
		    onUpdate: function (data) {
		      console.log(JSON.stringify(data.attributes))
		    }
		  }
		};
		
/* onload 이벤트  */
$(function(){
	
	// 강의 리스트 뿌리기 함수 
	init();
	roomListVue();
	btnClickEvent();
});

$(document).on("keyup", "input:text[numberOnly]", function() {
		$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
	});




function init() {
	// 장비 변수 선언
	ri = new Vue({
		el : '#itemList_vue',
		component : {
			 'itemList' : itemList
		},
		data : {
			  eachItem : [],
			  rm_seq : ''
		},methods: {
		    addEachItem: function () {
			      this.eachItem.push({ item_nm: '',item_vol : '', item_nt : '' });
			      
			    },
			    deleteEachItem: function (index, item_seq) {
			      console.log(index);
			      console.log("item_seq : " + item_seq);
			      console.log(this.eachItem);
			      this.eachItem.splice(index, 1);
			      
			      deleteItemVue(item_seq);
			    },
			    saveEachItem : function (item_seq, rm_seq, item_nm, item_vol, item_nt) {
			    	console.log("item_seq : " + item_seq + "rm_seq : " + rm_seq );
			    	console.log(this.eachItem);
			    	
			    	saveItemVue(item_seq, rm_seq, item_nm, item_vol, item_nt);
			    	
			    }
			  }
	});
	 //items = 넥사크로 dataSet과 같다.
    vm = new Vue({
		  el: '#roomList_vue',
		  components: {
		    'itemTable': itemTable,
		   
		  },
		  data: {
		    items: [],
		  
		    options: {
		    	//  paginated:"paginated"
		    }
		  },
		  methods: {
		     
		      itemList(rm_seq) {
		    	  itemListVue(rm_seq);
		      },
		      roomDelete(rm_seq) {
		    	  roomListManageVue(rm_seq);
		      },
		      roomUpdate(rm_seq) {
		    	  roomListManage(rm_seq);
		      }
		  }		    
		});	  
    ved = new Vue({
        el: '#editvue',  
      data: {
    		  rm_seq : ''
    	     , rm_name : ''
    	     ,rm_size: ''
    	     ,rm_pper: ''
    	     ,rmPic_file : ''
           }
});
	 	
};
// 룸 정보 저장 버튼
function btnClickEvent(rm_seq){
	$('a[name=btn]').click(function(e){
		e.preventDefault();
		
		var btnId = $(this).attr('id');	
		
		switch (btnId){
		case 'btnconfirm_vue' :
			roomInfoSave();
			break;
		case 'btnClose_vue' :
			gfCloseModal();
			break;
		}
	});
}

// 강의실 정보 저장 기능
function roomInfoSave() {

	
	// file form 값 생성
	var frm = document.getElementById("myForm");
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm);
	
	var resultCallback = function(data) {
		roomInfoSaveResult(data);
		init_val();
		gfCloseModal();
		roomListVue();
		
		
	};
	callAjaxFileUploadSetFormData("/mrm/roomRegistAction.do", "post", "json", true, fileData, resultCallback);
	
}
// 강의실  정보 콜백
function roomInfoSaveResult(data) {
	
	if(data.result == "SUCCESS") {
		alert(data.resultMsg);
		$("#rmPic_file").val(""); //첨부파일
	}else {
		//오류 응답 메시지 출력
		alert(data.resultMsg);
	}
}


 /* 강의실 리스트 불러오기  */
 function roomListVue(currentPage){
 	cPage = currentPage;
	 currentPage = currentPage || 1;
	 
	 var rm_name = $("#search_rm_name").val();
	 
	 
	 var param = {
		 currentPage : currentPage ,
		pageSize : noticePageSizevue,
		rm_name2 : rm_name
		 
	 }
	 
 	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
 	
 		roomListCallback(data, currentPage); 
 	}
 	callAjax("/mrm/roomListVue.do","post","json", true, param, resultCallback);
 	
 }
 

 /*강의실 리스트 data를 콜백함수를 통해 뿌려봅시당   */
 function roomListCallback(data, currentPage){
	 //console.log("noticeListResult2 data : " + JSON.stringify(noticeList));
	 //console.log("noticeListResult2 noticeList : " + JSON.stringify(data.noticeList));
	 
	 vm.items=[];
	 vm.items=data.roomList;
	 
	 console.log(data.totalCnt + " : " + currentPage);
	 
	// 리스트의 총 개수를 추출합니다.
	 var totalCnt = data.totalCnt;
	 // * 페이지 네비게이션 생성 (만들어져있는 함수를 사용한다 -common.js)
	 var listnum = $("#tmpListNum").val();
	 var pagingnavi = getPaginationHtml(currentPage, totalCnt, noticePageSizevue,noticePageBlock, 'roomListVue');
	 
	 
	 // 비운다음에 다시 append 
     $("#pagingnavi2").empty().append(pagingnavi); // 위에꺼를 첨부합니다. 
	 
	 // 현재 페이지 설정 
    $("#currentPagevue").val(currentPage);
   
 }
 

 
 
 /* 모달창(팝업) 실행  */
 function roomListManage(rm_seq) {
	 // 신규저장 하기 버튼 클릭시 (값이 null)
	 if(rm_seq == null || rm_seq==""){
		// Tranjection type 설정
		//alert("넘을 찍어보자!!!!!!" + nt_no);
		
		$("#action").val("I"); // insert 
		init_val(); // 이전 강의실 저장 정보 초기화
		
		//모달 팝업 모양 오픈! (빈거) _ 있는 함수 쓰는거임. 
		gfModalPop("#RoomInsert");
		
	 }else{
		// Tranjection type 설정
		$("#action").val("U");  // update
		modalInfo(rm_seq);
		
		
	 }

 };
 
 /* 모달창 정보 입력 */
 function modalInfo(rm_seq) {
	 
	 var param = {rm_seq : rm_seq};
	 
	 var resultCallback = function(data) {
		 console.log(JSON.stringify(data ));
		 modalResult(data);
		 
	 }
	 callAjax("/mrm/simpleInfo.do", "post", "json", true, param, resultCallback);
	 
 }
 
 
   
 /* 모달창 정보 콜백*/
 function modalResult(data) {
	 
	 if(data.resultMsg == "SUCCESS"){
		 //모달 띄우기 
		 gfModalPop("#RoomInsert");
		 
		// 모달에 정보 넣기 
		frealPopModal2(data.result);
	 
	 }else{
		 alert(data.resultMsg);
	 }
	 
	 
	
 }
 function frealPopModal2(object) {
	 $("#rm_seq").val(object.rm_seq); 
		 ved.rm_name = object.rm_name;
		 ved.rm_size = object.rm_size;
		 ved.rm_pper = object.rm_pper;
	 ved.rmPic_file = object.lgc_rm_nm;
 }
 
 
 

 /* 값 초기화 */
 function init_val(object){
	 
			$("#rm_name").val("");
			$("#rm_size").val("");
			$("#rm_pper").val("");
			$("#rmPic_file").val("");
			ved.rm_name = '';
			ved.rm_size = '';
			ved.rmPic_file = '';
			ved.rm_pper = '';
			
 }
 
 // 장비 목록
 function itemListVue(rm_seq) {
	 
	 ri.rm_seq = rm_seq;
	 
	 var param = {
		 rm_seq : rm_seq
	 }
	 
	 	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		 
	 		itemListVueCallback(data); 
	 	}
	 	callAjax("/mrm/itemListVue.do","post","json", true, param, resultCallback);
	 	
	 }
	 

	 /*장비 리스트 data를 콜백함수를 통해 뿌려봅시당   */
	 function itemListVueCallback(data){
		 //console.log("noticeListResult2 data : " + JSON.stringify(noticeList));
		 //console.log("noticeListResult2 noticeList : " + JSON.stringify(data.noticeList));
	
		 ri.eachItem=[];
		ri.eachItem=data.itemList;
		
		 
	 }
	 
	 // 강의실 수정/삭제
	 function roomListManageVue(rm_seq) {
		
		 var param = {
				 rm_seq : rm_seq
			 }
			 
			 	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
				 
			 roomListManageVueCallback(data); 
			 	}
			 	callAjax("/mrm/roomListManageVue.do","post","json", true, param, resultCallback);
			 	
		 
	 }

	 // 강의실 삭제 콜백
	 function roomListManageVueCallback(data) {
		 vm.items=[];
		 vm.items=data.roomList;
		 roomListVue(cPage);
		 
	 }
	 

	 /* 아이템 정보 저장/수정  */
	 function saveItemVue(item_seq, rm_seq, item_nm, item_vol, item_nt){
	 
		 
		 var param = {
				 item_seq : item_seq ,
				 rm_seq : rm_seq,
				 item_nm : item_nm,
				 item_vol : item_vol,
				 item_nt  : item_nt
		 }
		 console.log(param);
	 	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
	 	
			 saveItemVueCallback(data); 
			 itemListVue(rm_seq);
	 	}
	 	callAjax("/mrm/itemManageVue.do","post","json", true, param, resultCallback);
	 	
	 }
	 

	 /* 아이템 리스트 저장 콜백   */
	 function saveItemVueCallback(data){
		 //console.log("noticeListResult2 data : " + JSON.stringify(noticeList));
		 //console.log("noticeListResult2 noticeList : " + JSON.stringify(data.noticeList));
		 
		 vm.eachItem=[];
		 vm.eachItem=data.itemManageVue;
		
		 
	 }
	 
	/* 아이템 리스트 삭제 */
	function deleteItemVue(item_seq) {
		
		var param = {
				item_seq : item_seq
			
		}
		console.log("item_seq : " + item_seq);
		
		var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		 	
			 deleteItemVueCallback(data); 
	 	}
	 	callAjax("/mrm/itemDeleteVue.do","post","json", true, param, resultCallback);
	} 
	
	function deleteItemVueCallback(data) {
		 vm.eachItem=[];
		 vm.eachItem=data.itemManageVue;
	}
 
 
</script>
<body>

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
							<span class="btn_nav bold">강의실 관리</span> 
							<a href="#"class="btn_set refresh">새로고침</a>
						</p>
					</div>
					<h3 class="hidden">강의실 검색 영역</h3>
					<div class="room_searchbox">
						<div class="Rserch_input">
							<input type="text" id="search_rm_name" name="rm_name" v-model="rm_name2" placeholder="강의실 명을 입력해주세요.">
						</div>
						<div class="Rserch_btn">
							<input type="button" value="검색" onclick="roomListVue()">
						</div>
						<div class="Room_register_btn">
							<input type="button" value="강의실 등록" onclick="roomListManage()">
						</div>
					</div>
					<!-- /.room_searchbox -->
					<h3 class="hidden">강의실 목록 조회 영역</h3>
					<div class="roomTotal_listbox">	
					<input type="hidden" id="currentPage" value="1"> <input
							type="hidden" id="currentPagevue" value="1">
						<div class="roomList_box" id="roomList_vue">
						<div id="itemTable">
						<template v-for="row in items" v-if="items.length">
						<button type="button" @click="itemList(row.rm_seq)" class="showItem_btn">
							<div class="roomInfo_box">
								
								<div class="roomInfo_pic" data-field="rm_pic">
								<!-- <img :src="row.lgc_rm_nm"> -->	
									<!--  <img id="img" v-bind:src="smile"/>  -->
<!-- 									<img :src="row.psc_rm_nm" > -->
									<img alt="" :src="row.psc_rm_nm">
								</div>
								<div class="roomInfo_context">
									<div class="roomInfo_tit" data-field="rm_name">
										{{ row.rm_name }}
									</div>
									<div class="roomInfo_size" data-field="rm_size">
										크기 :  {{ row.rm_size }} m<sup>2</sup>
									</div>
									<div class="roomInfo_people" data-field="rm_pper">
										자리수 : {{ row.rm_pper }}
									</div>
								</div>
								
								<div class="roomInfo_btnbox">
									<div class="roomInfo_revise_btn">
										<button type="button" @click="roomUpdate(row.rm_seq)" >수정</button>
									</div>
									<div class="roomInfo_delete_btn">
										<button type="button" @click="roomDelete(row.rm_seq)" >삭제</button>
									</div>
								</div>
							</div>
							</button>
							
							<hr>
							</template>
							</div>
							<div class="paging_area" id="pagingnavi2"></div>
						</div>

						<!-- /.roomList_box -->
						<div class="itemList_box">
							<div class="itemList_titbox">
								장비 목록 관리
							</div>
							<div class="itemList_tablebox" id="itemList_vue">
								<div id = "itemList">
								
									<table>
										<tr>
											<th width="34%">장비명</th>
											<th width="8%">수량</th>
											<th width="38%">비고</th>
											<th width="17%"></th>
										</tr>
									<template v-for="(Irow, index) in eachItem" v-if="eachItem.length">
										<tr>
											<td ><input  v-model="Irow.item_nm"></td>
											<td > <input v-model="Irow.item_vol"></td>
											<td > <input v-model="Irow.item_nt "></td>
											<td >
												<button @click="saveEachItem(Irow.item_seq, rm_seq, Irow.item_nm, Irow.item_vol, Irow.item_nt)">저장</button>
												<button @click="deleteEachItem(index, Irow.item_seq)">삭제</button>
											</td>
										</tr>
									</template>
									</table>
									<div>
										<button @click="addEachItem"> 장비 추가 </button>
									</div>
								</div>
							</div>

						</div>
						<!-- /.itemList_box -->
						<div>
							<div class="clearfix" />
						</div>
					</div>		
					<!-- /.roomTotal_listbox -->
				</li>
			</ul>
		</div>
	</div>
<form id="myForm" action = "">
	<input type="hidden" id="currentPageLsmCod" value="1"> 
		<input type="hidden" id="currentPageLsmDtlCod" value="1"> 
		<input type="hidden" id="tmp_Cod" value=""> 
		<input type="hidden" id="tmp_CodNm" value="">
		<input type="hidden" name="action"  id="action" value="">
		<input type="hidden" name="lms_file_snm" id="lms_file_snm">
		<input type="hidden" name="task_seq" id="task_seq">
		<input type="hidden" name="rm_seq" id="rm_seq" value="">


	<!-- 모달팝업 -->
	<div id="RoomInsert" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" id="rm_seq" name="rm_seq" >
		<!-- 수정시 필요한 num 값을 넘김  -->

		<dl>
			<dt>
				<strong>강의실 등록/수정</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<div id="editvue">
					<table class="row">
						<caption>caption</caption>
							
						<tbody>
							
							<tr>
							
								<th scope="row">강의실명 <span class="font_red">*</span></th>
								<td>
								
									<input type="text" class="inputTxt p100" v-model="rm_name" name="rm_name" id="rm_name"  />
								</td>
								<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" v-model="write_date_vue" name="write_date_vue" id="write_date_vue" /></td> -->
							</tr>
							<tr>
								<th scope="row">강의실 크기 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="inputTxt p100" v-model="rm_size" name="rm_size" id="rm_size" numberOnly /> m<sup>2</sup>
								</td>
							</tr>
							<tr>
								<th scope="row">허용 인원</th>
								<td colspan="3">
									<input type="text" class="inputTxt p100" v-model="rm_pper"  name="rm_pper" id="rm_pper" numberOnly>
								</td>
							</tr>
							<tr>
								<th scope="row">강의실 사진</th>
								<td>	
									<input type="file" class="inputTxt p100" name="rmPic_file" id="rmPic_file">
								</td>
							</tr>

						</tbody>
					</table>
				</div>
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnconfirm_vue" name="btn"><span>확인</span></a>
					<a href="" class="btnType gray" id="btnClose_vue" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
</form>	
</body>
</html>