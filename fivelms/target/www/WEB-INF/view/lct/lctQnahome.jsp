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
var replyvue;
var upOV;
		
/* onload 이벤트  */
$(function(){
	init();
	qnaListVue();
	fRegisterButtonClickEvent();
});


function init() {
	
	Vue.use(VueQuillEditor)
	
	
	upOV = new Vue({
		el:'#updateOption',
		data:{
			enr_user:'',
			option:false
		},
		methods:{
			changeOption:function(){
				event.preventDefault();
				setdoption();
				this.option=true;
			},
			deleteqna:function(){
				 if(confirm("삭제하시겠습니까?")){
     	    		 fdeleteQna();
     	    	  }else{
     	    		  alert("취소되었습니다.");
     	    	  }
			}
		}
	});
	
	
	/* 댓글 vue */
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
	
	/* 검색 vue */
	svm = new Vue({
        el: '#searcharea',  
      data: {
    	  	enr_user:'',
     	    searchkey: 'qna_title',
      		searchword: ''
      },
      methods:{
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
			editorOption:{
 				theme: 'snow'
			},
    	    items: [],
    	    option:false
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
     	    	
     	      },
     	     setfilename:function(){
     	    	 this.file_nm=event.target.files[0].name;
     	     },
     	    minusClickEvent:function(){
     	    	this.file_nm="";
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
      	      },
      	    setfilenm:function(){
      	    	this.file_nm=event.target.files[0].name;
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
};

function setdoption(){
	ved.option = true;
};

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


function fdeleteQna(){

	
	var param ={
			action:'D',
			qna_seq:ved.qna_seq
	}
	
	var resultCallback = function(data) {
		alert(data.resultMsg);
		qnaListVue();
	};

	callAjax("/lct/saveQna.do", "post", "json",true, param,resultCallback);
	
	gfCloseModal();
};


function fsaveQna(){

	$("#action").val("I");
	$("#wqna_contents").val(wvue.qna_contents);
	//alert(wvue.$data);
	var frm = document.getElementById("myQnasendForm");
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm);
	
	var resultCallback = function(data) {
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
	
	callAjaxFileUploadSetFormData("/lct/saveFileTest.do", "post", "json",true, fileData,resultCallback);
	
	
	gfCloseModal();
}


/* 파일다운로드 */
function fDownloadQnaFile() {
	
	var params = "";
	params += "<input type='hidden' name='qna_seq' value='"+ ved.qna_seq +"' />";
	
	
	jQuery("<form action='/lct/downloadQnaFile.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
}



function fupdateQna(){
	var resultCallback = function(data) {
		qnaListVue();
	};
	/* alert(ved.qna_seq);
	$("#action2").val("U"); 
	$("#qna_seq2").val(ved.qna_seq); */
	
	ved.action='U';
	
	
	//callAjax("/stuQna/saveStuQna.do", "post", "json",true, $("#detailQna").serialize(),resultCallback);
	callAjax("/lct/saveQna.do", "post", "json",true, ved.$data ,resultCallback);
	
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
		printQnaList(data,currentPage); 
	};

	callAjax("/lct/selectQnaList.do", "post", "json", true, param,resultCallback);

}


/* qna 리스트 불러오기  */
function qnaListVue(currentPage,searchkey,searchword){
	
	currentPage = currentPage || 1; 	
	searchword =svm.searchword;
	searchkey =svm.searchkey;

	var param = {		
			pageSize : pageSize,  	
			pageBlock : pageBlock,
			currentPage : currentPage, 
			searchkey:searchkey,
			searchword:searchword	
	}
	
	var resultCallback = function(data){ 
		printQnaList(data,currentPage); 
	}
	
	
	callAjax("/lct/qnaList.do","post","json", true, param, resultCallback);
	
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
	
	var paginationHtml = 
		getPaginationHtml(currentPage, totalCnt,
						pageSize,pageBlock, 'qnaListVue');
	
	$("#pagingnavi2").empty().append(paginationHtml);
}

function selectDetailQna(qna_seq){
	
	var param = {
			qna_seq:qna_seq
	}
	
	var resultCallback = function(data){ 
		selectQna(data); 
	}
	
	callAjax("/lct/selectQna.do","post","json", true, param, resultCallback);	
}

function fWriterQna(){
	
	
  	wvue.qna_seq='';
  	wvue.qna_contents='';
  	wvue.qna_cnt='';
  	wvue.file_nm='';
  	wvue.file_loc=''; 
  	wvue.file_size='';
  	wvue.enr_date='';
  	wvue.upd_user='';
  	wvue.upd_date='';
  	
  	wvue.qna_title='';
	
	
	wvue.enr_user="${sessionScope.loginId}";
	$(".ql-editor").css("height","300px");
	
	$("#wqna_title").focus();
	qnaWritePopup("#writeqna");
}

function selectQna(data){
	
	upOV.option=false;
	ved.option =false;
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
    
    relpyGetList();
    qnaWritePopup("#noticevue");
}


function fSearchQna(){
	
	var searchkey=$("#searchkey").val();
	var searchword=$("#searchword").val();
	svm.searchkey=$("#searchkey").val();
	svm.searchword=$("#searchword").val();
	
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
	/* $('#wqna_title').focus(); */
	var winH = $(window).height();
	var winW = $(window).width();
	var scrollTop = $(window).scrollTop();

	$(id).css('top', '8px');
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
	}
	callAjax("/lct/getListReply.do","post","json", true, param, resultCallback);
}

/*  댓글 등록이요~  */
function replyInsert(){

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

		replyvue.replyContent="";
		relpyGetList();
	}
	callAjax("/lct/insertReply.do","post","json", true, param, resultCallback);
}



 
 
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
								<a href="#" class="btn_nav">커뮤니티</a> 
								<span class="btn_nav bold">Q%A</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" id="searcharea">
								<span>Q & A</span> 
								<span class="fr">
								
								<select id ="searchkey" name ="searchkey"  style="width: 104px;" v-model="searchkey">
									<option value="qna_title"  >제목</option>
									<option value="enr_user"  >작성자</option>
									<option value="qna_contents">내용</option>
								</select>
								<input type="text" id="searchword" name="searchword"  
								          placeholder="입력하세요" style="height: 28px;" @keyup.enter="searchQna" v-model="searchword"> 
								<a class="btnType blue" href="javascript:fSearchQna();" name="search"id="searchBtn"><span>검색</span></a>
								</span>
								
							</p>
						
						<!-- 리스트 데이터   -->
						<jsp:include page="/WEB-INF/view/lct/lctQnaList.jsp"></jsp:include>
						
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
	
						<!-- 상세화면 모달   -->
						<jsp:include page="/WEB-INF/view/lct/lctQnadetail.jsp"></jsp:include>
						
						<!-- 글쓰기 모달   -->
						<jsp:include page="/WEB-INF/view/lct/lctQnaWrite.jsp"></jsp:include>
	
	
	
</body>
</html>