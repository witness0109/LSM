<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge"/>
<title>인원관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<%-- <jsp:include page="/WEB-INF/view/common/grid/commonGrid.jsp"></jsp:include> --%><!-- vue.js 로 구현 어려움 패스 -->
<script type="text/javascript">
var vm;
var user_type ='${user_type}'; 
//var user_type = 'S';
	 
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
    	init();
	    //날짜 지정형식 	
	    var dateFormat = "yy/mm/dd";
	    
	    
	    setTimeout(function() {
	    	selectUserInfoList(user_type);	
		}, 0);
	     
	    
  });//date 지정 시작일과 끝

  function init() {
		
		/* new Vue({
		     el: '#searcharea2',
		     name: 'date-picker',
		     props: {
		      date: String
		     },
		     mounted: function() {
											      var that = this;
											      $(this.$el).datepicker({
											          'autoclose':true,
											          'minViewMode':0, //day까지 선택할수 있게 선언
											          'maxViewMode':2,
											          'format':'yyyy.mm.dd' //날짜 포맷
											      }).on('changeDate', function(e){
															       var year = e.date.getFullYear();
															       var month = e.date.getMonth() + 1;
															       if(month < 10) month = '0' + month;
															       var day = e.date.getDate();
															       that.$emit('change',String(year)+'.'+String(month)+'.'+day);
											      });
		     },
		     updated: function(){
		            $(this.$el).datepicker('update', this.date);
		     }   
		});		 */
		
	    vm = new Vue({
			  el: '#vuetable',
			  components: {
			    'bootstrap-table': BootstrapTable
			  },
			  data: {
			    items: [],
			    options: {
			    	//  paginated:"paginated"
			    },
			    checkNm:"list1Check"
			  }
			  /*
			  methods: {
			      rowClicked(row) {
			    	 //alert("1111111111111111");
			        //this.$refs.tableData.toggleRowExpansion(row);
			        //console.log("row : " + row);
			        
			        var str = "";
	                var tdArr = new Array();    // 배열 선언
	                    
	                // 현재 클릭된 Row(<tr>)
	                var tr = $(row);
	                var td = tr.children();
	                
	                td.each(function(i){
	                    tdArr.push(td.eq(i).text());
	                });
	                        
	                fNoticeModal2(tdArr[1]);
	                //console.log("배열에 담긴 값 : "+tdArr[1]);
			        
			      }
			  }
			  */
			});	  
	    	
	    
	    	/*
	        $("#vuedatatable tr").click(function(){  
	        	var str = "";
	            var tdArr = new Array();    // 배열 선언
	                
	            // 현재 클릭된 Row(<tr>)
	            var tr = $(this);
	            var td = tr.children();
	            
	            //console.log("td : " + td);
	    	}); 
	    	*/
	    
	    
	};  
  
      /*학생관리 폼 초기화*/
      
      function initFormStudent(object){
    	 $("#st_name").focus();
    	 //console.log("initFormStudent1 : " + object);
    	 //console.log("initFormStudent2 : " + JSON.stringify(object));
    	 
    	 if( object == "" || object == null || object == undefined){
    	  //alert("new");
          $("#st_name").val("");
    	  $("#loginID").val("");
    	  $("#st_birthday").val("");
    	  $("#st_reg_date").val("");
    	  $("#st_phone_number").val("");
    	  $("#st_password").val("");
    	  $("#st_name").attr("readonly", false);
    	  $("#st_name").css("background","FFFFFF");
    	  $("#st_name").focus();
    	  $("#btnDelete").hide();
    	  $("#st_reg_date").hide();
    	 }
    	 else {
    	  $("#st_name").val(object.st_name);
    	  $("#loginID").val(object.loginID);
    	  $("#st_birthday").val(object.st_birthday);
    	  //$('#st_reg_date').val(object.st_reg_date);
    	  $("#st_phone_number").val(object.st_phone_number);
    	  $("#st_password").val(object.st_password);
    	  $("#loginID").attr("readonly", true);
    	  $("#loginID").css("background","FFFFFF");
    	  $("#st_name").focus();
    	  $("#st_reg_date").hide();
    	  $("#btnDelete").show();
    	 }
    	  
      }//initFormStudent
     
      /*유효성 체크 함수*/
      function fValidateCheck(){
    	  
    	  var chk = checkNotEmpty(
    			  [
    				  ["st_name1","학생명을 입력해주세요."]
    			  ]
    	  );  
    	  
    	  if(!chk){
    		  return;
    	  }
    	  
    	  return true;
      }//유효성 체크 함수
      
    	 
      /*가입 유저 리스트 불러오기*/	 
      function selectUserInfoList(user_type){
    	  
    	  var param ={
    			  user_type : user_type    			  
    	  }
    	  
    	  var resultCallback = function(data){
    		  userInfoListCallBack(data);
    	  }
    	  callAjax("/mpm/openUserInfoList.do","post","json",true,param,resultCallback);
      }
      
      
      //>>
      /*학생관리 프로세싱*/	 
      function updateStudent(){
    	  
    	  //안먹혀서 주석
    	  /* var param = {
    			  stuendInfo:$("#stuendInfo").serialize()    			  
    	  } */
    	  var param = $("#stuendInfo").serialize();    			  
    	  
    	  //$("#stuendInfo").serialize();
    			  //studentList : JSON.stringify(studentList),
    			  
    				  //vm.items
    	  
    	  //param = JSON.stringify(param);
    	  
    	  //param = JSON.stringify(param);
    	  
    	  
    	  var resultCallback = function(data){
    		  fSaveStudentResult(data);
    	  }
    	  
    	  callAjax("/mpm/studentProcess.do","post","json",true,param,resultCallback);
      }
      
      
      function userInfoListCallBack(data) {
    	  //console.log(data.userInfoList);
    	  vm.vm = [];
		  vm.items = data.userInfoList;
    	  
		  
	 }
      
      
      
      /*학생관리 삭제*/
      function fDelete(){
    	  
    	  var resultCallback = function(data){
    		  fDeleteResult(data);
    	  };
    	  
    	  callAjax("/peopleA/deleteStudent.do", "post", "json", true, $("#myStudent").serialize(), resultCallback);
      }//학생관리 삭제
      
      /*학생관리 삭제 콜백 함수*/
      function fDeleteResult(data){
    	  
    	  var currentPage = $("#currentPageStudent").val();
    	  
    	  if(data.result == "SUCCESS"){
    		  
    		  
    		  //응답 메시지 출력
    		  alert(data.resultMsg);
    		  
    		  setTimeout(function() {
    			  gfCloseModal();
    			}, 1000);
    		  
    		  //학생관리 목록 출력
    		  selectStudentList();
    		  
    	  }else{
    		  alert('else1');
    		  alert(data.resultMsg);
    	  }
      }   
      
      /*학생관리 신규등록*/
      function fRegister(loginID){
    	  
    	  //신규 저장
    	  if(loginID == null || loginID == ""){
    		
    		  // Tranjection type 설정
    		  $('#action').val("I");
    		  
    		  //학생관리 폼 초기화
    		  //initFormStudent();
    		  
    		  //모달 팝업
        	  gfModalPop("#userInfoPopup");
        	  $("#user_type").val(user_type);
    		  
    		  
    	  //수정 저장	  
    	  } else {
    		  
    		  // Tranjection type 설정
    		  $("#action").val("U");
    		  
    		  //학생관리 단건 조회
    		  fSelectStudent();  
    	  }
    	  //학생목록 다시불러오기
    	  selectStudentList();
    	  
      }//학생관리 신규등록
      
      /*학생관리 단건조회*/
      function fSelectStudent(loginID){
    	  
    	  var param = { loginID : loginID };
    	  
    	  var resultCallback = function(data){
    		  fSelectStudentResult(data);
    	  }
    	  
    	  callAjax("/peopleA/selectStudent.do","post","json",true,param,resultCallback);  
      }
      
      /*학생관리 단건조회 콜백함수*/
      function fSelectStudentResult(data){
    	  
    	  if(data.result == "SUCCESS"){
    		  
    		  //모달 팝업
    		  gfModalPop("#layer1");
    		  
    		  //학생관리 폼 데이터 설정
    		  initFormStudent(data.studentJYOModel);
    	  }
    	  
    	  else{
    		  alert(data.resultMsg);
    	  }	    	  
      }
      
      /*학생관리 저장 콜백함수*/
      function fSaveStudentResult(data){
      
         if(data.result == "SUCCESS"){
        	 //응답 메시지 출력
        	 alert(data.resultMsg);
        	 gfCloseModal();
        	 //목록조회
        	 selectStudentList(currentPage);
         }
         else{
        	 //오류 응답 메시지 출력
        	 alert(data.resultMsg);
         }
         
           //입력폼 초기화
           initFormStudent();
         
       }//학생관리 저장 콜백함수   
       
       /*학생관리 검색*/
       function fSeacrchStudent(currentPage){
    	   
    	   //유효성 체크함수 불러오기
    	   if( ! fValidateCheck() ){
    		   return;
    	   }
    	   
    	   //var from = $('#from');//시작일
     	   //var to = $('#to');//끝
     	   var st_name1 = $('#st_name1');//학생명
    	   
    	   currentPage = currentPage || 1;
    	   
    	   var param = {
    			        currentPage : currentPage,
    			        pageSize : studentPageSize,
    			        st_name1 : st_name1.val()
    			        //from : from.val(),
    			        //to : to.val()
    			   
    	   }
    	   
    	   var resultCallback = function(data){
    		   studentListResult(data, currentPage);
    	   };
    	   
    	   alert("검색되었습니다.");
    	   
    	   callAjax("/peopleA/studentList.do", "post", "text", true, param, resultCallback);
    	   
    	   
       }
      
      
      
         	 
</script>

</head>
<body>
<form id="myStudent" action="" method="">
	  <input type="hidden" id="currentPageStudent" value="1">
      <input type="hidden" id="action" name="action" value="">
</form>
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
						<div class="content">
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
									<tr style=""><td><span>가입 일자 : </span></td>
									<td><input type="text" style="height: 31px; width: 110px;" class="txtInput" id="from" name="" ></td>
									<td><span><b>&nbsp ~ &nbsp</b></span></td>
									<td><input type="text" style="height: 31px; width: 110px" class="txtInput" id="to" name="to"></td>
									</tr>
									<tr><td><span>학생명 : </span></td>
									<td colspan="4" ><input type="text" style="height: 31px;" id="st_name1" name="st_name1" class="txtInput">
									<span width="110" height="60" style="font-size: 120%"> 
							   
							   <a href="javascript:fSeacrchStudent()" class="btnType gray"  id="btnSearch" name="btn"><span>검색</span></a>
							</span>
									</td>
									</tr>
								</tbody>
							</table>
							 
														
							<div class="divStudentList" id="vuetable">
							<div class="bootstrap-table" style=" width: 1000px; overflow-y: scroll;">
							<form action="/mpm/studentProcess.do" id="updateForm">
								<table class="col" style="width: 1000px;">
									<caption>caption</caption>

									<colgroup>
										<col width="5">
										<col width="5">
										<col width="20">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="20">
										<col width="40">
										<col width="40">
									</colgroup>
									<thead>
										<tr>
											<th hidden="hidden"></th>
											<th><input type="checkbox" style="width: 24px; height: 24px;" id="allChk" onclick="allCheckYn(this,'list1Check')"></th>
											<th data-field="index" >순번</th> 
											<th data-field="name" >이름</th>	<!-- name  -->
											<th data-field="status_yn" >상태</th>	<!-- status_yn  -->
											<th data-field="password" >비밀번호</th><!-- password   -->
											<th data-field="user_type" >구분</th>
											<th data-field="user_email" >이메일</th><!-- email  -->
											<th>수정</th><!-- email  -->
										</tr>
									</thead>
									<tbody style="height: 400px;">
										<!-- <tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr> -->
										<template v-for="(row, index) in items" v-if="items.length">
											            <tr>
											               <td hidden="">Y</td>
											               <td><input type="checkbox" style="width: 24px; height: 24px;" v-bind:name="checkNm"></td>
											               <td><input type="text" disabled="disabled" v-bind:value="index+1" style="height: 24px; width: 24px; background-color:white; border: none;" class="col"></td>
											               <td><input type="text" v-bind:value="row.name" style="height: 24px; width: 100px; border: none;" class="col"></td>
											               <td>{{ row.status_yn }}</td>
											               <td>{{ row.password }}</td>
											               <td>
											               	<select name="user_type">
											               		<option value="S">학생</option>
											               		<option value="T">강사</option>
											               	</select>
											               	</td>
											               <td>{{ row.user_email }}</td>
											               <td><button type="button" name="" onclick="fRegister()">수정</button></td>
											            </tr>  
										            </template>
									</tbody>
								</table>
								</form>
								
								

								<!-- 페이징 처리  -->
								<!-- <div class="paging_area"  id="Pagination"> </div> 페이징 처리  -->
						</div>	
					</div>
					
						<div>
							<p class="conTitle" style=" float: right; border: none;">
								<span>
								<!-- <a class="btnType blue" href="javascript:fRegister();" name="modal"> -->
								<a class="btnType blue" href="javascript:fRegister()" name="modal" style="background: none;">
								  <span>신규등록</span></a>
								  </span>
								  <span>
								<!-- <a class="btnType blue" href="javascript:fRegister();" name="modal"> -->
								<a class="btnType blue" href="javascript:processDataList()" name="modal" style="background: none;">
								  <span>대량 데이터저장(테스트)</span></a>
								  </span>
								  <span>
								<!-- <a class="btnType blue" href="javascript:fRegister();" name="modal"> -->
								<a class="btnType blue" href="javascript:dataProvider.addRow(1);" name="modal" style="background: none;">
								  <span>삭제</span></a>
								  </span>
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
	
	
	
	/*
	if(checkYn == true){
		
	}else{
		
	}
	*/
	$("select[name=user_type]").each(function() {
    	console.log(this);	
	});
	
}



</script>
</html>