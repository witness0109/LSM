<!-- 
writer : 이승현 
process : 학생, 강사 관리를 할수 있다 (등록,삭제,수정)
comment : 단건 처리 , 다중 처리가 가능하다  
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge"/>
<title>인원관리</title>
<style type="text/css">
.tdCk{
	width: 24px;
	height: 24px;
}
.tdSlct,.tb_txtbox{
	width: 72px;
    height: 31px;
    border: 0;
}
.tb_txtboxlong{
	width: 250px;
}
.txtboxColor{
background-color:#f3f3f3 
}
.btn-del-color{
background-color: gray;
color: red;
}
.img-box{
width: 300px;
}
</style>
<style type="text/css">
.table-box-wrap .table-tbody-box {
	height : 280px;
    max-height: 320px;
    overflow: auto;
    /* width: 1020px; */
}
.table-thead-box {
    /* width: 1003px; */
}
.input-btn{
width: 100%;
height: 100%;
}


.file_input_textbox {
    float:left;
    height:29px;
}
.file_input_div {
    position:relative;
    width:80px;
    height:36px;
    overflow:hidden;
}
.file_input_img_btn {
    padding:0 0 0 5px;
}
.file_input_hidden {
    font-size:29px;
    position:absolute;
    right:0px;
    top:0px;
    opacity:0;
    filter: alpha(opacity=0);
    -ms-filter: alpha(opacity=0);
    cursor:pointer;
}

</style>

<style type="text/css">
	.file_input_textbox {float:left; height:29px;}
	.file_input_div {position:relative; width:80px; height:36px; overflow:hidden;}
	.file_input_img_btn {padding:0 0 0 5px;}
	.file_input_hidden {font-size:29px; position:absolute; right:0px; top:0px; opacity:0; filter: alpha(opacity=0); -ms-filter: alpha(opacity=0); cursor:pointer;}
</style>


<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<jsp:include page="/WEB-INF/view/login/login.jsp"></jsp:include>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
 <!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> -->  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 

<script type="text/javascript">
var user_type ='${user_type}';
var filePath = "";
var fileNm = "";

	


	 
		/*
		date : 20200324
		writer : 이승현
		comment : as-is : 페이지 방식 -> to_be : 스크롤 형식
 		*/
     //학생관리 페이지 설정
     //var studentPageSize = 5;
     //var studentPageBlockSize =5;
     

     
     /* onload 이벤트  */
    $(function initdate(){
    	if(user_type == 'T'){
    		$("#container").find(".btn_nav:eq(1)").text("강사 관리");
    	}else{
    		$("#container").find(".btn_nav:eq(1)").text("학생 관리");
    	}
	    init(); 	
	    
	   replaceLginForm();
	   selectUserInfoList();
	   
	 	$(document).on("click","#btnSend",function(){
	 		gfCloseModal();
	 		f_fileUpload();
	 	});
	 	$(document).on("click","#btnDelete",function(){
	 		gfCloseModal();
	 		$("#action").val("D");//login.jsp 에 있음
	 		f_processUserInfo();
	 	});
	 	$("#loginaddr,#searchTxt").keydown(function(key) {
			if(key.keyCode  == '13'){
				var idVal = $(this).attr("id");
				if(idVal == 'loginaddr'){
					execDaumPostcode($(this).val());
				}else if(idVal == 'searchTxt'){
					selectUserInfoList();
				}
			}
		});
	 	$(document).on("change",".list-txt",function(){
	 		//console.log(this);
	 		var tmpStr = $(this).attr("id");
	 		var tmpNum = tmpStr.charAt(tmpStr.length-1);
	 		$("#actMode"+tmpNum).attr("value","U");
	 	});
	 	$(document).on("click","#btnPtView",function(){
	 		  var url = "/mpm/openTchFace.do";
	          var name = "popup test";
	          var option = "width = 300, height = 300,location = no,top="+(screen.availHeight/2-100)+",left="+(screen.availWidth/2-100)+"";
	          window.open(url, name, option);
	 	});
	 	
	 	selectUserInfoList();
	     

	      
	     
  });
     
     
     
     //로그인폼은 그대로 되 속성 값은 변경
     function replaceLginForm() {
    	 //200409 추가 :강사 사진 추가 기능
    	 if(user_type == 'T'){
    		 var indexTr = $("#layer1").find("tbody > tr:eq(0)");
    		var $tr = $('<tr/>').append($("#hdnPtTr").html());
    		$(indexTr).after($tr);
    	 }


    	 
    	 
    	 
 	    var $span = $('<span>').text("삭제");
 	    var $a = $('<a>').attr("class","btnType blue").attr("id","btnDelete").attr("href","javascript:f_delete()");
 	    $a.append($span);
 	    var $div = $("<div>");
 	    
 	    
 	   $div.append($a);
 	   $("#RegisterForm").find("#RegisterCom").attr("href","javascript:");
 	   $("#RegisterForm").find("#RegisterCom").attr("id","btnSend");
 	   
 	   $("#RegisterForm").find("#btnSend").before($div.html()+' ');
 	    
	}
     
     
      function init() {
    	  //incluse login.jsp display none;
    	  $("#myForm").attr("style","display:none");	
    	 var dateFormat = "yy/mm/dd";
         //시작일
         fromDt = $("#fromDt").datepicker({ 
        	 dateFormat: dateFormat,
         }); 
         toDt = $("#toDt").datepicker({ 
        	 dateFormat: dateFormat,
         });
         
         $("#fromDt").change(function() {
        	 $("#toDt").datepicker("option", "minDate", $(this).val());
		 })
		 $("#toDt").change(function() {
        	 $("#fromDt").datepicker("option", "maxDate", $(this).val());
		 })
         
	} 
     
     
     //date 지정 시작일과 끝

      /*학생관리 폼 초기화*/
      
      function initFormStudent(object){
    	 
    	 if( object == "" || object == null || object == undefined){
          $("#registerName").val("");//name
    	  $("#registerId").val("");//id
    	  $("#registerPwd").val("");//pw
    	  $("#registerPwdOk").val("");//pw_re
    	  $("#detailaddr").val("");//post
    	  $("#loginaddr").val("");//addr
    	  $("#loginaddr1").val("");//addr detail
    	  $("#registerEmail").val("");//pw
    	  $("#uploadFile").val("");
    	  $("#fileNameTxt").val("");
    	  $("#registerId").attr("readonly", false);
    	  $("#registerId").css("background","FFFFFF");
    	  $("#task_seq").focus();
    	  $("#btnSend").find("span").text("회원가입 완료");
    	  $("#btnDelete").hide();
    	  $("#btnPtView").hide();
    	 }
    	 else {
    		 var info = object['0'];
    		 console.log(info);
    	  $("#registerName").val(info.name);//name
       	  $("#registerId").val(info.loginID);//id
       	  $("#registerPwd").val(info.password);//pw
       	  $("#registerPwdOk").val(info.password);//pw_re
       	  $("#loginaddr").val(info.user_post);//post
       	  $("#loginaddr").val(info.user_addr);//addr
       	  $("#loginaddr1").val(info.addr_detail);//addr detail
       	  $("#registerEmail").val(info.user_email);//pw
       	  $("#fileNameTxt").val(info.fileNm);
       	  $("#fileNm").val(info.fileNm);
       	  $("#filePath").val(info.filePath);
    	  $("#registerId").attr("readonly", true);
    	  $("#registerId").css("background","FFFFFF");
    	  $("#registerName").focus();
    	  $("#layer1").find("strong").text("가입 정보");
    	  $("#btnSend").find("span").text("수정 하기");
    	  $("#btnDelete").show();
    	  $("#btnPtView").show();
    	 }
    	  
      }//initFormStudent
     
      /*유효성 체크 함수*/
      function fValidateCheck(){
    	  
    	  var chk = checkNotEmpty(
    			  [
    				  ["searchTxt","학생명을 입력해주세요."]
    			  ]
    	  );  
    	  
    	  if(!chk){
    		  return;
    	  }
    	  
    	  return true;
      }//유효성 체크 함수
      
    	 
      /*가입 유저 리스트 불러오기*/	 
      function selectUserInfoList(){
    	  
    	  	 var $fromDt = $('#fromDt');//시작일
    	  	 var $toDt = $('#toDt');//끝
    	  	 var $searchTxt = $('#searchTxt');//학생명
    		   
    	  	 var param = {
    			        user_type : user_type,
    			        searchTxt : $searchTxt.val(),
    			        fromDt : $fromDt.val(),
    			        toDt : $toDt.val()
    			   		
    		  }
    	  
    	  var resultCallback = function(data){
    		  userInfoListCallBack(data);
    		  
    		  f_scrollCheck();
    	  }
    	  callAjax("/mpm/openUserInfoList.do","post","json",true,param,resultCallback);
      }
      
      
      function f_scrollCheck() {
	 }
      
      
      
      function f_fileUpload() {
    	  var $fileForm = $("#RegisterForm")[0];
      	
      	$fileForm.enctype = 'multipart/form-data';
    		
    		var formData = new FormData($fileForm);
    		
    		var resultCallback2 = function(data){
    		  $("#filePath").val(data.filePath);
    		  $("#fileNm").val(data.fileNm);
    		  f_processUserInfo();
    	    }
    		
    		callAjaxFileUploadSetFormData("/mpm/fileProcess.do", "post", "json", true, formData, resultCallback2);
	  }
      
      //>>
      /*학생관리 프로세싱*/	 
      function f_processUserInfo(type){
    	  
    	  
    	

  		
    	  var param = {
    			  userInfo:{
    			    	 loginID : $("#registerId").val(),
    				     password : $("#registerPwd").val(),
    				     name : $("#registerName").val(),
    				     user_type : user_type, //학생 페이지의 경우 자동으로 S 매칭
    				     user_email : $("#registerEmail").val(), 
    				     user_addr : $("#loginaddr").val(), // user_post 의 id가 좀 이상하게 지정되 있음 ..
    				     addr_detail : $("#loginaddr1").val(),
    				     user_post : $("#detailaddr").val(),
    				     act_mode : $("#action").val(),
    				     filePath : $("#filePath").val(),
    				     fileNm : $("#fileNm").val()
    			  },
    	  }
		  if(type != null && type == 'list'){
			  param.userInfoList = fn_makeArray();
		  }    	  
    	  
    	  param = fn_parsingParam(param);
    	  
    	  var resultCallback = function(data){
    		  selectUserInfoList();
    		  fSaveStudentResult(data);
    	  }
    	  
    	  callAjax("/mpm/userInfoProcess.do","post","json",true,param,resultCallback);
    	  
    	  
    	  
    	  
    	  
    	  
    		 
    
      }
      
      
      function userInfoListCallBack(data) {
    	  var list = data.userInfoList;
		  makingList(list);
		  slctOptionSet(list,'status_yn');
	 }
      
     function slctOptionSet(list,objStr) {
		
		$('select[name='+objStr+']').each(function(index,value) {
			
			this.value = list[index].status_yn;
		});
     }
      
     function makingList(list) {
		var totCnt = list.length;
		var $tbody = $('<tbody></tbody>');
	    
	    
	    var userInfo;
	   for (var i = 0; i < totCnt; i++) {
		   
		userInfo = list[i];
		var $tr = $('<tr></tr>');
		
		var $checkbox = $('<input type ="checkbox" class="tdCk" id="chk'+i+'" name="list1Check" >');
		
		var $indexTd = $('<td>'+(i+1)+'</td>');
		var lginId = "";
		var $td = $('<td hidden="true" id="actMode'+i+'"></td>');
		$tr.append($td);
		var $td = $('<td hidden="true" id="lginID'+i+'" value="'+userInfo.loginID+'"></td>');
		$tr.append($td);
		var $td = $('<td></td>');
		$td.append($checkbox);
		$tr.append($td);
		$tr.append($indexTd);
		
		for (var j = 0; j < $(".th_info").size(); j++) {
		
				for ( var key in userInfo) {
					if(key == 'loginID'){
						lginId = userInfo[key];
					}
					
				
					if(key == $(".th_info").eq(j).attr("data-field")){
							if(key == 'status_yn'){
							$td = $('<td/>');
							var optionsY = $('<option>').attr("value","Y").text("가입중");
							var optionsN = $('<option>').attr("value","N").text("탈퇴");
							var $select = $('<select>').attr("class","tdSlct list-txt" ).attr("id",key+i).attr("name",key);//.attr("disabled",true);
							if(i%2!=0){$select.addClass("txtboxColor");}
							$select.append(optionsY);
							$select.append(optionsN);
							$td.append($select);
							}else if(key == 'user_email'){
								$td = $('<td/>');
								var $txtbox = $('<input type ="text" id="'+(key+i)+'"name="'+key+'" value="'+userInfo[key]+'" >').attr({"class":"tb_txtbox tb_txtboxlong list-txt"});
								if(i%2!=0){$txtbox.addClass("txtboxColor");}
								$td.append($txtbox);
							}else if(key == 'password'){
								$td = $('<td>'+userInfo[key]+'</td>');
							}else{
							//$td = $('<td id='+(key+i)+' name='+key+'>'+userInfo[key]+'</td>');
							$td = $('<td/>');
							var $txtbox = $('<input type ="text" id="'+(key+i)+'"name="'+key+'" value="'+userInfo[key]+'" >').attr({"class":"tdSlct tb_txtbox txtBox-tab1 list-txt"});
							if(i%2!=0){$txtbox.addClass("txtboxColor");}
							$td.append($txtbox);	
							
						}
							$tr.append($td);
					}
			}
			
		 
		 
		 //console.log($tr);
		 //console.log(JSON.stringify($tr.html));
			
		}
		$td = $('<td></td>');
		var $modifyButton =$('<button>').attr("type","button").attr("onclick","fRegister1('"+lginId+"')").text("수정"); //'"+lginId+"'
		var $deleteButton =$('<button>').attr({"type":"button","class":"btn-del-color","onclick":"fn_del_tr("+i+")"}).text("삭제"); 
		$td.append($modifyButton).append(' ').append($deleteButton);
		$tr.append($td);
		//console.log($tr.html());
		$tbody.append($tr);
		//console.log($tbody.html());
	    //>>
	}
	   
	   
	   
	   $("#listTbody").html($tbody.html());
	   
	}
    
    
    function fn_del_tr(index) {
    	$("#actMode"+index).attr({"value":"D"});
    	$("#chk"+index).attr("checked",true);
		$("#listTbody").find("tr:eq("+index+")").hide(500);
	} 
      
      
      function fRegister1(loginId){
    	  
    	  if(loginId == null || loginId == ""){
    		
    		  // Tranjection type 설정
    		  $('#action').val("I");
    		  
    		  
    		  
    		  //모달 팝업
        	  gfModalPop("#layer1");
    		  
        	//학생관리 폼 초기화
    		  initFormStudent();
        	  
        	  $("#user_type").val(user_type);
    		  
    		  
    	  //수정 저장	  
    	  } else {
    		  
    		  // Tranjection type 설정
    		  $("#action").val("U");
    		  
    		  //학생관리 단건 조회
    		  fSelectStudent(loginId);  
    	  }
    	  //학생목록 다시불러오기
    	  //selectStudentList();
    	  
      }//학생관리 신규등록
      
      /*학생관리 단건조회*/
      function fSelectStudent(loginID){
    	  
    	  var param = { loginID : loginID };
    	  
    	  var resultCallback = function(data){
    		  fSelectStudentResult(data);
    	  }
    	  
    	  callAjax("/mpm/selectUserInfo.do","post","json",true,param,resultCallback);  
      }
      
      /*학생관리 단건조회 콜백함수*/
      function fSelectStudentResult(data){
    	  
    	  if(data.result == "SUCCESS"){
    		  gfModalPop("#layer1");
    		  
    		  initFormStudent(data.list);
    	  }
    	  else{
    		  alert(data.resultMsg);
    	  }	    	  
      }
      
      /*학생관리 저장 콜백함수*/
      function fSaveStudentResult(data){
      	//console.log(data);
         if(data.result == "SUCCESS"){
        	 
        	 if(data.totCnt != 'undefined' &&  data.totCnt > 0){
        		 var cnt = data.totCnt;
        		 alert(cnt +" 건 처리가 완료 되었습니다.");
        	 }else{
        		 alert(data.resultMsg);	 
        	 }
        	 
         }
         else{
        	 //오류 응답 메시지 출력
        	 alert(data.resultMsg);
         }
           //입력폼 초기화
           initFormStudent();
         
       }//학생관리 저장 콜백함수   
       
       /*학생관리 검색*/
       function fSeacrchStudent(){
    	   
    	   //유효성 체크함수 불러오기
    	   if( ! fValidateCheck() ){
    		   return;
    	   }
    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   
       }
      
      
      
         	 
</script>

</head>
<body>
<form id="myStudent" action="" method="">
	  <input type="hidden" id="currentPageStudent" value="1">
      <input type="hidden" id="action" name="action" value="">
</form>
	  <input type="hidden" id="filePath" name="">
	  <input type="hidden" id="fileNm" name="">
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
					<h3 class="hidden">contents 영역</h3>
					<div>
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">인원 관리</a> <span class="btn_nav bold">학생
								관리</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<table style="height: 90px">
							<colgroup></colgroup>
							<colgroup></colgroup>
							<colgroup></colgroup>
							<colgroup></colgroup>
							<thead>
							</thead>
							<tbody>
								<tr style="">
									<td><span>가입 일자 : </span></td>
									<td><input type="text" style="height: 31px; width: 110px;"
										class="txtInput" id="fromDt" name="fromDt"></td>
									<td><span><b>&nbsp ~ &nbsp</b></span></td>
									<td><input type="text" style="height: 31px; width: 110px"
										class="txtInput" id="toDt" name="toDt"></td>
								</tr>
								<tr>
									<td><span>학생명 : </span></td>
									<td colspan="4"><input type="text" style="height: 31px;"
										id="searchTxt" name="searchTxt" class="txtInput"> <span
										width="110" height="60" style="font-size: 120%"> <a
											href="javascript:selectUserInfoList()" class="btnType gray"
											id="btnSearch" name="btn"><span>검색</span></a>
									</span></td>
								</tr>
							</tbody>
						</table>

						<div>
							<div class="table-thead-box">
								<table class="col" style="width: 1003px;">
									<colgroup>
										<col width="5%">
										<col width="5%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="40%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th class="th_info" hidden="true">
											<th class="th_info"><input type="checkbox"
												style="width: 24px; height: 24px;" id="allChk"
												onclick="allCheckYn(this,'list1Check')"></th>
											<th class="th_info" data-field="index">순번</th>
											<th class="th_info" data-field="name">이름</th>
											<!-- name  -->
											<th class="th_info" data-field="status_yn">상태</th>
											<!-- status_yn  -->
											<th class="th_info" data-field="password">비밀번호</th>
											<!-- password   -->
											<th class="th_info" data-field="user_email">이메일</th>
											<!-- email  -->
											<th class="th_info">업데이트</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<div class="table-box-wrap">
							<div class="table-tbody-box">
								<table class="col" style="width: 1003px;">
									<colgroup>
										<col width="5%">
										<col width="5%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="40%">
										<col width="10%">
									</colgroup>
									<tbody id="listTbody"">
									</tbody>
								</table>
							</div>
						</div>

						<div>
							<p class="conTitle" style="float: right; border: none;">
								<span> <a class="btnType blue"
									href="javascript:fRegister1()" name="modal"
									style="background: none;"> <span>신규등록</span></a>
								</span> <span> <a class="btnType blue"
									href="javascript:f_processUserInfo('list')" name="modal"
									style="background: none;"> <span>대량 데이터 처리(테스트)</span></a>
								</span>
								<!-- <span>
								<a class="btnType blue" href="javascript:f_processUserInfo('D')" name="modal" style="background: none;">
								  <span>삭제</span></a>
								  </span> -->
							</p>
						</div>
					</div> <!-- content -->


					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>

				</li>
				<!-- content -->
			</ul>
		</div>
		<!-- container -->
	</div>
	<!-- wrap_area -->
	<div class="hdn-fileUpload-wrap" style="display: none;">
		<table>
		<tr id="hdnPtTr">
		<th scope="row" >사진추가</th>
			<td colspan="2"><input type="text" id="fileNameTxt" class="file_input_textbox" readonly>
				<div class="file_input_div">
					<img src="/images/mpm/open.jpg" class="file_input_img_btn" alt="open" />
					<input type="file" name="uploadFile" id="uploadFile" class="file_input_hidden" onchange="javascript: document.getElementById('fileNameTxt').value = this.value" />
					
				</div>
				
				</td>
				<td><input type="button" id="btnPtView" value="사진보기" style="width: 100%; height: 100%"></td>
		</tr>
	</table>
	</div>




</body>
<script type="text/javascript">
/* 

check box 상위 체크 하위 모든 check
 */
 function allCheckYn(checkYn,nameP) {
	
	
	var checkYn = checkYn.checked;
	var nameP = $('[name='+ nameP + ']');
	
	
	if(checkYn){
		$(nameP).each(function(index,value) {
			this.checked = true;
		});	
	}else{
		$(nameP).each(function(index,value) {
			this.checked = false;
		});	
	}
	
}

    $.fn.hasScrollBar = function() {
	    return (this.prop("scrollHeight") == 0 && this.prop("clientHeight") == 0)
	            || (this.prop("scrollHeight") > this.prop("clientHeight"));
	};

	function fn_parsingParam(obj) {
		console.log(obj);
	var asisParam = obj;	
	var tobeParam = {};	
		
	for ( var key in asisParam) {
		var tmpObject = asisParam[key];
		var length = asisParam[key].length;
		if(length != 'undefined' && length > 0){
			for ( var key2 in tmpObject) {
				var listObj = tmpObject[key2];
				
				for ( var key3 in listObj) {
					tobeParam[key+'['+key2+'].'+key3] = listObj[key3];
				}
			}	
		}else{
			for ( var key2 in tmpObject) {
				var propertyStr = key+'.'+key2;
				tobeParam[propertyStr] = tmpObject[key2];
			}		
		}
	}
		return tobeParam;
		
	}
	function fn_makeArray() {
		var param =[];
		
		$(".tdCk").each(function(index,val) {
			if(this.checked){
				param.push(fn_makeObject(index));
			}
		})
		return param;
	}
	function fn_makeObject(index) {
		var obj ={};
		obj.loginID =  $("#lginID"+index).attr("value");
		obj.act_mode = $("#actMode"+index).attr("value");
		obj.name = $("#name"+index).val();
		obj.status_yn = $("#status_yn"+index).val();
		obj.user_email = $("#user_email"+index).val();
		return obj;
	}


</script>
</html>