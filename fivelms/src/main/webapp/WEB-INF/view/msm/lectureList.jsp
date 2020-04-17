
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.2/dist/vue.js"></script>
    <script src="https://unpkg.com/vue-router@3.0.1/dist/vue-router.js"></script>
<script type="text/javascript">

var lect;

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
	
	// 강의 리스트
	init();
	lectList();
	
});

function init() {
	lect = new Vue({
		el : '#lecture_box',
		 component : {
			'lectInfo' : lectInfo
		}, 
		data : {
			lectList : [],
			studentList : [],
			search_name : '',
			test : '',
			selected : 'A',
			options : [
				{text : '강의번호', value : 'A'},
				{text : '강의명', value : 'B'},
				{text : '강사아이디', value : 'C'},
				{text : '강사명', value : 'D'},
				{text : '강의실명', value : 'E'}
			           ]
		},
		computed : {
			filtered : function() {
				
				let sname = this.search_name.trim();
				return this.lectList.filter((item) => {
					if(this.selected == 'A') {
						if(item.lec_seq.includes(sname)) {
							return true;
						}
					} else if (this.selected == 'B') {
						if(item.lec_nm.includes(sname)) {
							return true;
						}
					} else if (this.selected == 'C') {
						if(item.loginID.includes(sname)) {
							return true;
						}
					} else if (this.selected == 'D') {
						if(item.name.includes(sname)) {
							return true;
						}
					} else if (this.selected == 'E') {
						if(item.rm_seq.includes(sname)) {
							return true;
						}
					} 
				});
			}
		},
		methods : {
			showPerson: function(index, lec_seq){
				if(this.test == null || this.test == '') {
					 this.test = index+1;
					$('#showPerson_'+index).show();
					personInfo(lec_seq);
				} else if (this.test == index+1 ) {
					this.test = '';
					$('.hide_tr').hide();
				} else {
					this.test = index+1;
					$('.hide_tr').hide();
					$('#showPerson_'+index).show();
					 personInfo(lec_seq);
				}
			}
		}
	});
};

// 강의 전체 목록 조회
function lectList() {
	console.log("여기왔나요? ");
	param='';
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		console.log("여기왔나요? -2 ");
		lectListCallback(data); 
 	}
 	callAjax("/msm/lectListAct.do","post","json", true, param, resultCallback);
	
}

//강의 전체 목록 조회 콜백
function lectListCallback(data){
	//alert(JSON.stringify(data));
	lect.lectList=[];
	lect.lectList=data.lectList;
	
  
}

// 수강중인 학생 조회
function personInfo(lec_seq) {
	console.log("lec_seq? "+lec_seq);
	
	 var param = {
			 lec_seq : lec_seq
		 }
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		personInfoCallback(data); 
 	}
 	callAjax("/msm/lectPeopleInfo.do","post","json", true, param, resultCallback);
	
}

//수강중인 학생 조회 콜백
function personInfoCallback(data){
	//alert(JSON.stringify(data));
	lect.studentList=[];
	lect.studentList=data.lectPeopleInfo;
	
  
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
							<span class="btn_nav bold">수강인원 확인</span> 
							<a href="#"class="btn_set refresh">새로고침</a>
						</p>
					</div>
					<h3 class="hidden">강의실 검색 영역</h3>
				<div id="lecture_box" >
					<div class="lecture_searchbox">
						<div class="lecture_selectbox">
							<select v-model="selected" >
								<option v-for = "option in options" v-bind:value="option.value">
									{{ option.text }}
								</option>
							</select>
						</div>
						<div class="lecture_serch_input">
							<input type="text" name="room_search" v-model="search_name" placeholder="검색 내용을 입력해주세요.">
						</div>
					</div>
					<!-- /.lecture_searchbox -->
					
					<div class="lecture_box" >
						<div class="lecture_tit_box">
							수강인원 확인
						</div>
						<div class="lecture_listbox">
							<table id="lectInfo">
								<thead>
									<tr>
										<th>강의번호</th>
										<th>강의명</th>
										<th>강사아이디</th>
										<th>강사명</th>
										<th>강의실명</th>
										<th>수강인원</th>
										<th>강의시작일</th>
										<th>강의종료일</th>
									</tr>
								</thead>
								<tbody>
								<template v-for="(list, index) in filtered">
								 <tr @click="showPerson(index, list.lec_seq)"  >
								
										<td>{{ list.lec_seq }}</td>
										<td>{{ list.lec_nm }}</td>
										<td>{{ list.loginID }}</td>
										<td>{{ list.name }}</td>
										<td>{{ list.rm_name }}</td>
										<td>{{ list.cnt }}</td>
										<td>{{ list.lec_st }}</td>
										<td>{{ list.lec_ed }}</td>
									</tr>
									<tr  :id="'showPerson_'+index " class="hide_tr" style="display:none" >
										<td colspan="8" >
											<div class="lecturerInfor_box">
												<div class="lecturer_pic">
													 <img alt="" :src="'/images/mpm/'+list.file_nm"> 
												<!--	<img alt="" src="/images/mpm/윤아.jpg">-->
												</div>
												<div class="lecturer_Info">
													<div class="lecturer_name">
														{{ list.name }}
													</div>
													<div class="lecturer_id">
														{{ list.loginID }}
													</div>
													<div class="lecturer_phone">
														Email : {{ list.user_email }}
													</div>
												</div>
											</div>
											<!-- /.lecturerinfor_box -->
											<div class="student_list">
												<table>
													<thead>
														<tr>
															<th>회원아이디</th>
															<th>수강생이름</th>
															<th>이메일 </th>
															<th>수강 진행 여부</th>
														</tr>
													</thead>
													<tbody>
													<template v-for="(Slist, index) in studentList" v-bind:item="Slist" v-bind:index="index">
														<tr>
															<td>{{ Slist.loginID }}</td>
															<td>{{ Slist.name }}</td>
															<td>{{ Slist.user_email }}</td>
															<td>{{ Slist.lec_yon }}</td>
														</tr>
													</template>
													</tbody>
												</table>
											</div>
											<!-- /.student_list -->
										</td>
									</tr>
									</template>
								</tbody>
							</table>
						</div>
					</div>
					<!-- /.lecture_box -->
				</div>	
				</li>
			</ul>
		</div>
	</div>


</body>
</html>