<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>잡코리아 dashboard</title>



<script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<!-- Quill JS Vue -->
<script src="https://cdn.jsdelivr.net/npm/vue-quill-editor@3.0.6/dist/vue-quill-editor.js"></script>
<!-- Include stylesheet -->
<link href="https://cdn.quilljs.com/1.3.4/quill.core.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.snow.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.bubble.css" rel="stylesheet">








<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- D3 -->
<style>
//
click-able rows
	.clickable-rows {tbody tr td { cursor:pointer;

.chosghi { visibility: hidden;}
	
}

.el-table__expanded-cell {
	cursor: default;
}

.ql-editor{
	
    height: 300px;
	
}
}
</style>
<script type="text/javascript">



// 페이징 설정 
var pageSize = 5;    	// 화면에 뿌릴 데이터 수 
var pageBlock = 5;		// 블럭으로 잡히는 페이징처리 수

var vm;
var svm;
var ved;
var upOV;

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
	/* alert("시작"); */
	// 자유게시판 리스트 뿌리기 함수 
	//$("#option1").attr("selected","selected");
	init();
	qnaListVue();
	//$("#option1").attr("selected","selected");
	// 버튼 이벤트 등록
	fRegisterButtonClickEvent();
	
	
	
});

/** 버튼 이벤트 등록 */
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');

		switch (btnId) {
			case 'btnSaveDtlCod' :
				//alert("클릭이벤트");
				fsaveQna();
				break;
			case 'btnupdateQna' :
				fupdateQna();
				break;
			case 'btnClose_vue' :
			case 'writeClose' :
				gfCloseModal();
				qnaListVue();
				break;
		}
	});
}

function fsaveQna(){
	//alert("저장함수 ");
	$("#action").val("I");
	$("#wqna_contents").val(wvue.qna_contents);
	var frm = document.getElementById("myQnasendForm");
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm);
	var rr= fileData.entries();
	console.log(rr.next());
	console.log(rr.next());
	console.log(rr.next());
	console.log(rr.next());
	console.log(rr.next());
	console.log(rr.next());
	console.log("끝?");
	console.log(fileData.has('wfile_nm'));
	console.log(fileData.has('wqna_contents'));
	
	
	
	var resultCallback = function(data) {
		//alert('돌아옴');
		//alert(data);
		//alert("다시 list 뽑자~")
		//printQnaList(data,currentPage); 
		
		
		qnaListVue();
	};
	
	/* 폼을 넘겨주는것이 아닌 $data 정보를 넣겨주기때문에 아래처럼해야함. 
	$("#action").val("I"); 
	wvue.action='I';*/
	
	
	/* 폼 보낼떄사용 */
	//callAjax("/stuQna/saveStuQna.do", "post", "json",true, $("#myQnasendForm").serialize(),resultCallback);
	/* vue 사용  */
	//callAjax("/stuQna/saveStuQna.do", "post", "json",true, wvue.$data,resultCallback);
	/* 파일업로드할떄사용 */
	//alert("보낸다");
	
	callAjaxFileUploadSetFormData("/stuQna/saveFileTest.do", "post", "json",true, fileData,resultCallback);
	
	
	gfCloseModal();
}


/* 파일다운로드 */
function fDownloadQnaFile() {
	
	var params = "";
	params += "<input type='hidden' name='qna_seq' value='"+ ved.qna_seq +"' />";
	
	
	jQuery("<form action='/stuQna/downloadQnaFile.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
}



function fupdateQna(){
	var resultCallback = function(data) {
		
		qnaListVue();
	};

	ved.action='U';
	
	
	//callAjax("/stuQna/saveStuQna.do", "post", "json",true, $("#detailQna").serialize(),resultCallback);
	callAjax("/stuQna/saveStuQna.do", "post", "json",true, ved.$data ,resultCallback);
	
	gfCloseModal();
	
}









function fSearchQnaList(){
	
	var searchkey=$("#searchkey").val();
	var searchword=$("#searchword").val();

	
	qnaListVue(1,searchkey,searchword);
	
}

function qnaSearchList(currentPage,searchkey,searchword){
	
	currentPage = currentPage || 1;
	searchkey = searchkey || "";
	searchword = searchword || "";
	svm.searchkey=searchkey;
	svm.searchword=searchword;
	var param = {
		currentPage : currentPage,
		pageSize : pageSize,
		pageBlock : pageBlock,
		searchkey : searchkey,
		searchword : searchword
	}

	var resultCallback = function(data) {
		//alert(data);
		//alert(data.list.length);
		
		printQnaList(data,currentPage); 
		
	};
	//alert("go");
	callAjax("/stuQna/selectQnaList.do", "post", "json", true, param,resultCallback);
	
	
}


/* qna 리스트 불러오기  */
function qnaListVue(currentPage,searchkey,searchword){
	
	currentPage = currentPage || 1;   // or		
	searchword =svm.searchword;
	searchkey =svm.searchkey;
	//alert(currentPage+" , "+searchword+" , "+searchkey);
	var param = {
			
			pageSize : pageSize,  	
			pageBlock : pageBlock,
			currentPage : currentPage, 
			searchkey:searchkey,
			searchword:searchword
			
			
	}
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		printQnaList(data,currentPage); 
	}
	
	
	callAjax("/stuQna/qnaList.do","post","json", true, param, resultCallback);
	
	/* $.ajax({
		url : "/stuQna/qnaList.do",
		type : "post",
		dataType : "json",
		async :true,
		data : param,
		success : function(data) {
			
			printQnaList(data);
		},
		error : function(xhr, status, err) {
			console.log("xhr : " + xhr);
			console.log("status : " + status);
			console.log("err : " + err);
				alert('A system error has occurred.' + err);
		},
		complete: function(data) {
			$.unblockUI();
		}
	}); 
	*/
	
}

function printQnaList(data,currentPage){
	
	var currentPage = currentPage || 1;
	
	vm.items=[];
	vm.items=data.list;
	
	var totalCnt= data.totalCnt;
	//alert(data.totalCnt);
	
	var paginationHtml = 
		getPaginationHtml(currentPage, totalCnt,
						pageSize,pageBlock, 'qnaListVue');
	
	$("#pagingnavi2").empty().append(paginationHtml);
}

function selectDetailQna(qna_seq){
	
	upOV.option=false;

	var param = {
			qna_seq:qna_seq
	}
	
	var resultCallback = function(data){ 
		selectQna(data); 
	}
	
	callAjax("/stuQna/selectQna.do","post","json", true, param, resultCallback);
	
	
	
}

function fWriterQna(){
	
	wvue.qna_contents='';
	wvue.file_nm='';
	wvue.qna_title='';
	wvue.enr_user="${sessionScope.loginId}";
	$(".ql-editor").css("height","300px");
	
	$("#wqna_title").focus();
	qnaWritePopup("#writeqna");
}


function fdeleteQna(){
	
	var param = {
			qna_seq:ved.qna_seq
	}
	
	var resultCallback = function(data){ 
		alert(data.msg);
		
		gfCloseModal();
		qnaListVue();
	}
	
	callAjax("/stuQna/deleteQna.do","post","json", true, param, resultCallback);
	
	
};












function selectQna(data){
	//alert(data[0].qna_seq);
	//ved.items= data;
	//alert( data.qna_contents);
	ved.qna_seq = data.qna_seq;
    ved.qna_title=data.qna_title;
    ved.qna_contents=data.qna_contents;
	ved.enr_user= data.enr_user;
    ved.enr_date=data.enr_date;
    ved.upd_user=data.upd_user;
    ved.upd_date=data.upd_date;
    ved.qna_cnt=data.qna_cnt;
    ved.file_loc=data.file_loc;
    ved.file_nm=data.file_nm;
    ved.file_size=data.file_size;
   
    upOV.enr_user=data.enr_user;
    
    relpyGetList();
    qnaWritePopup("#noticevue");
}


function fSearchQna(){
	//alert(svm.searchword);
	
	var searchkey=$("#searchkey").val();
	var searchword=$("#searchword").val();
	svm.searchkey=$("#searchkey").val();
	svm.searchword=$("#searchword").val();
	//alert(svm.searchkey+" , "+svm.searchword);
	
	qnaSearchList(1,searchkey,searchword);
}

/* 
------------모달 */
function qnaWritePopup(id) {

	//var id = $(this).attr('href');
	//alert("asdf");  
	var maskHeight = $(document).height();
	var maskWidth = $(document).width();

	$('#mask').css({'width':maskWidth,'height':maskHeight});

	$('#mask').fadeIn(200);
	$('#mask').fadeTo("fast", 0.5);
	$('#wqna_title').focus();
	var winH = $(window).height();
	var winW = $(window).width();
	var scrollTop = $(window).scrollTop();

	$(id).css('top', "5px");
	$(id).css('left', winW/2-$(id).width()/2);

	$(".layerPop").hide();
	$(id).fadeIn(100); //페이드인 속도..숫자가 작으면 작을수록 빨라집니다.
}


/*  댓글 리스트 출력이요~  */
function relpyGetList(){
	
	
	param={
			
			qna_seq : ved.qna_seq /* 상세 qna 번호  */
		}
	
	var resultCallback = function(data){ 
		replyvue.replys=data.list;
		
		//alert("출력."+data.list[0].rpy_lvl);
	}
	callAjax("/stuQna/getListReply.do","post","json", true, param, resultCallback);
}

/*  댓글 등록이요~  */
function replyInsert(){

	//alert("replyvue.action : "+replyvue.action);
	
	var param = {
			action:replyvue.action,
			qna_seq : ved.qna_seq,
			rpy_seq:replyvue.rpy_seq,
			rpy_lvl:replyvue.rpy_lvl || 0,
			rpy_contents:replyvue.replyContent,
			enr_user:replyvue.enr_user,	
			upd_user:replyvue.enr_user
	}
	
	var resultCallback = function(data){ 
		//alert("등록"+data.msg);
		replyvue.replyContent="";
		relpyGetList();
	}
	callAjax("/stuQna/insertReply.do","post","json", true, param, resultCallback);
}




function init() {
	
	Vue.use(VueQuillEditor)
	
	
	upOV = new Vue({
		el:'#updateOption',
		data :{
			enr_user:'',
			option:false
			
		},
		methods:{
			updateOptionChange:function(){
				event.preventDefault();
				this.option = true;
				
			},
			deleteQna:function(){
				fdeleteQna();	
			}
		}
	});
	
	replyvue = new Vue({
		el:"#replyList",
		data: {
			action:'', /* 대댓인지 구별. */
			replyContent:'',
			enr_user: '${sessionScope.loginId}',
			replys : [],
			rpy_seq:'',
			rpy_lvl:''
		},
		methods:{
			insertReply:function(ev){
				replyInsert();
			},
			addreplytag:function(row){
				replyvue.rpy_seq=row.rpy_seq;
				replyvue.action='1';
				replyvue.rpy_lvl='1';
				$("#replyContent").val("@"+row.enr_user+"  ");
				
			}
		}
	});
	
	
	
	svm = new Vue({
        el: '#searcharea',  
      data: {
    	  	enr_user:'',
     	    searchkey: '',
      		searchword: ''
      },
      methods :{
    	  searchQna:function(){
    		  
    		  fSearchQna();
    	  }
      }
	}); 
	
	/* 모달 팝업. 상세보기. */
	ved = new Vue({
        el: '#editvue',  
      data: {
    	  	action :'',
    	  	qna_seq:'',
    	  	qna_contents:'',
    	  	qna_cnt:'',
    	  	file_nm:'',
    	  	file_loc:'', 
			file_size:'',
			 enr_date:'',
			 upd_user:'',
			 upd_date:'',
    	     enr_user:'',
    	     qna_title:'',
    	     qna_contents :'',
    	     editorOption: {
     			  theme: 'snow'
    			 }
    	     ,
    	    	 items: []
           },
           methods: {
     	      onEditorBlur:function(quill) {
     	    	 
     	        console.log('editor blur!', quill)
     	      },
     	      onEditorFocus:function(quill) {
     	    	 
     	        console.log('editor focus!', quill)
     	      },
     	      onEditorReady:function(quill) {
     	    	 
     	        console.log('editor ready!', quill)
     	      },
     	     fDownloadQnaFileEvent:function(){
     	    	  if(confirm("다운받으시겠습니까?")){
     	    		 fDownloadQnaFile();
     	    	  }else{
     	    		  alert("취소되었습니다.");
     	    	  }
     	    	
     	      }
     	    },
     	   computed: {
     	      editor:function() {
     	    	 // alert( this.$refs.quillEditor.quill.getText());
     	        return this.$refs.quillEditor.quill
     	      }
     	    },
     	    mounted:function() {
     	      console.log('this is quill instance object', this.editor)
     	    }
	}); 
	
	
	wvue = new Vue({
        el: '#writevue',  
      data: {
    	  	action :'',
    	  	qna_seq:'',
    	  	qna_contents:'',
    	  	qna_cnt:'',
    	  	file_nm:'',
    	  	file_loc:'', 
			file_size:'',
			 enr_date:'',
			 upd_user:'',
			 upd_date:'',
    	     enr_user:'',
    	     qna_title:'',
    	     
    	     editorOption: {
    			  theme: 'snow'
   			 },
    	    	 items: []
           },
           methods: {
      	      onEditorBlur:function(quill) {
      	    	 
      	        console.log('editor blur!', quill)
      	      },
      	      onEditorFocus:function(quill) {
      	    	 
      	        console.log('editor focus!', quill)
      	      },
      	      onEditorReady:function(quill) {
      	    	 
      	        console.log('editor ready!', quill)
      	      },
      	    
      	     minusClickEvent:function(){
      	    	$("#wfile_nm").val("");
      	      }
      	    },
      	   computed: {
      	      editor:function() {
      	    	 // alert( this.$refs.quillEditor.quill.getText());
      	        return this.$refs.quillEditor.quill
      	      }
      	    },
      	    mounted:function() {
      	      console.log('this is quill instance object', this.editor)
      	    }
	}); 
	
   vm = new Vue({
		  el: '#vuetable',
		  components: {
		    'bootstrap-table': BootstrapTable
		  },
		  data: {
		    items: [],
		    options: {
		    	//  paginated:"paginated"
		    }			    
		  },
		  methods: {
		      rowClicked:function(row) {
		    	  
	                var tdArr = new Array();    // 배열 선언
	                    
	                // 현재 클릭된 Row(<tr>)
	                var tr = $(row);
	                var td = tr.children();
	                
	                td.each(function(i){
	                    tdArr.push(td.eq(i).text());
	                }); 
	                
					selectDetailQna(tdArr[0]);
					
		        	$(".ql-editor").css("height","300px");
		       
		        
		      }
		  }		      
		});	



	 /*  공지사항 상세 조회 -> 콜백함수  
	 function fdetailResult2(data){

		 //alert("공지사항 상세 조회  33");
		 if(data.resultMsg == "SUCCESS"){
			 //모달 띄우기 
			 gfModalPop("#noticevue");
			 
			// 모달에 정보 넣기 
			frealPopModal2(data.result);
		 
		 }else{
			 alert(data.resultMsg);
		 }
	 } */
};

 
 
</script>

</head>
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
					<div class="content">

						<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> 
								<a href="#" class="btn_nav">학습관리</a> 
								<span class="btn_nav bold">Q%A</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" id="searcharea">
								<span>Q & A</span> 
								<span class="fr">
								
								<select id ="searchkey" name ="searchkey"  style="width: 104px;" >
									<option value="qna_title" id="option1" selected="selected">제목</option>
									<option value="enr_user" id="option2" >작성자</option>
									<option value="qna_contents"id="option3">내용</option>
								</select>
								<input type="text" id="searchword" name="searchword"  @keyup.enter="searchQna"
								          placeholder="입력하세요" style="height: 28px;" v-model="searchword"> 
								<a class="btnType blue" href="javascript:fSearchQna();" name="search"id="searchBtn"><span>검색</span></a>
								</span>
								
							</p>

						<div id="vuetable">
							<div class="bootstrap-table">
								<div class="fixed-table-toolbar">
									<div class="bs-bars pull-left"></div>
									<div class="columns columns-right btn-group pull-right">
									</div>
								</div>
								<div class="fixed-table-container" style="padding-bottom: 0px;">
									<div class="fixed-table-body">

										<table id="vuedatatable" class="col2 mb10" style="width: 1000px;">
											<colgroup>
												<col width="30px">
												<col width="200px">
												<col width="30px">
												<col width="60px">
												<col width="50px">
											</colgroup>
											<thead>
												<tr>
													<th data-field="no">번호</th>
													<th data-field="qna_title">제목</th>
													<th data-field="enr_user">작성자</th>
													<th data-field="enr_date">작성일</th>
													<th data-field="qna_cnt">조회수</th>
													
												</tr>
											</thead>
											<!-- vue 적용.  -->
											<tbody>
												<template v-for="(row, index) in items" v-if="items.length">
												<tr onclick="vm.rowClicked(this)">
													<td class="hidden">{{ row.qna_seq }}</td>
													<td>{{ index + 1}}</td>
													<td>{{ row.qna_title }}
													<img v-if="row.file_nm !=''"
													 src="/images/treeview/file.gif">
													</td>
													<td>{{ row.enr_user }}</td>
													<td>{{ row.enr_date }}</td>
													<td>{{ row.qna_cnt }}</td>
													
												</tr>
												</template>
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
						<br>
						 <span class="fr"> <a class="btnType blue"
								href="javascript:fWriterQna();" name="modal"><span>글쓰기</span></a>
						</span> 
						
					</div>
				</li>
			</ul>

		</div>
	</div>

	

	<!-- 모달팝업 -->
	<form id="detailQna" action="" method="">
	<div id="noticevue" class="layerPop layerType2" style="width: 1000px; hight: 1000px;">
		<input type="hidden" name="action" id="action2" value="">
		<input type="hidden" name="qna_seq" id="qna_seq2" value="">
		<!-- 수정시 필요한 num 값을 넘김  -->

		<dl>
			<dt>
				<strong>Q&A 상세보기 </strong>
			</dt>
			<dd class="content">
				<div id="editvue">
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="140px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">제목 </th>
								<td>
								<input type="text" class="inputTxt p100" name="qna_title" id="qna_title" v-model="qna_title"/>
								</td>
								<th scope="row">작성자 </th>
								<td><input type="text" class="inputTxt p100" name="enr_user" id="enr_user" v-model="enr_user" />
								</td>
								<th scope="row">등록일 </th>
								<td><input type="text" class="inputTxt p100" name="enr_date" id="enr_date" v-model="enr_date"/>
								</td>
							</tr>
							<tr >
								<th scope="row" >내용<span class="font_red">*</span></th>
								<td colspan="5">
								<!-- <input type="text" style="height: 300px;" class="inputTxt p100" name="qna_contents" id="qna_contents" v-model="qna_contents"/> -->
								<div id="vueapp"  style="width: 900px;"  name="qna_contents" id="qna_contents">
								 
								  <quill-editor
								    ref="quillEditor" class="editor" v-model="qna_contents" :options="editorOption"
								    @blur="onEditorBlur($event)"
								    @focus="onEditorFocus($event)"
								    @ready="onEditorReady($event)"
								  />
								  <br>
								 
								</div>
								
								
								</td>
							</tr>
							<tr>
								<th scope="row" >파일<span class="font_red">*</span></th>
								<td colspan="5">
							
									
									<div v-if="file_nm !=''" @click="fDownloadQnaFileEvent" id="filearea">
										<img src="/images/treeview/file.gif" name="file_nm"id="file_nm">
										<span >{{file_nm}}</span>
										<span style="font-size: xx-small;" >  {{file_size}}Byte</span>
										<img v-if="mOk"  src="/images/treeview/minus.gif" @click="minusClickEvent">
									</div>
									
									
								</td>
							</tr>
						</tbody>
					</table>
				</div>
					<jsp:include page="/WEB-INF/view/ssm/qna/qnaReply.jsp"></jsp:include>
				<div class="btn_areaC mt30" id="updateOption">
				
						<a v-if="enr_user == '${sessionScope.loginId}' & option"  class="btnType blue" @click="deleteQna"><span>삭제</span></a>
						<a v-if="enr_user == '${sessionScope.loginId}' & option"  class="btnType blue" id="btnupdateQna" name="btn"><span>저장</span></a>
						
						<a v-if="enr_user == '${sessionScope.loginId}' & !option"  class="btnType blue" @click="updateOptionChange"><span>수정</span></a>
						
						<a href="" class="btnType gray" id="btnClose_vue" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	</form>
	
	
	
	<form id="myQnasendForm" action="" method="" >
	<!-- 글쓰기 -->
	<div id="writeqna" class="layerPop layerType2" style="width: 1000px; hight: 1000px;">
		<!-- 업데이트냐 수정이냐 ~  vue 사용으로 필요없음. $data를 보내기때문 -->
		<input type="hidden" name="action" id="action" value="">
		<input type="hidden"  name="qna_contents" id="wqna_contents"  value="">
	
	

		<dl>
			<dt>
				<strong>q&a 글쓰기</strong>
			</dt>
			<dd class="content">
				<div id="writevue">
					<table class="row" id="studentQnawriteFromID">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3">
								<input type="text" class="inputTxt p100" name="qna_title" id="wqna_title" v-model="qna_title" autofocus required/>
								</td>
								<th scope="row">작성자 </th>
								<td><input type="text" class="inputTxt p100" name="enr_user" id="wenr_user" v-model="enr_user" />
								</td>
								
							</tr>
							<tr >
								<th scope="row" >내용<span class="font_red">*</span></th>
								<td colspan="5">
								
								<div id="vueapp"  style="width: 900px;" >
								 
								  <quill-editor
								    ref="quillEditor" class="editor" v-model="qna_contents" :options="editorOption" 
								    @blur="onEditorBlur($event)"
								    @focus="onEditorFocus($event)"
								    @ready="onEditorReady($event)"
								  />
								  <br>
								  <div class="content ql-editor" v-model="qna_contents" ></div>
								</div>
								</td>
							</tr>
							<tr>
								<th scope="row" >파일<span class="font_red">*</span></th>
								<td colspan="5">
									<!--multiple="multiple" -->
									<input type="file" name="file_nm" id="wfile_nm" v-model="file_nm" ></input>
									<img v-if="file_nm !='' "src="/images/treeview/minus.gif" @click="minusClickEvent">
									
								</td>
							</tr>
						</tbody>
					</table>
				</div>
					
				<div class="btn_areaC mt30">
					
						<a href="" class="btnType blue" id="btnSaveDtlCod" name="btn"><span>저장</span></a>
		
						<a href="" class="btnType gray" id="writeClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	</form>
	
		
	
	
	
	

</body>
</html>