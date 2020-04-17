

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
	classList();
	
});

function init() {
	lect = new Vue({
		el : "#lecturer_box"	,
		component : {
			'classInfo' : classInfo
		},
		data : {
			classList : [],
			className : '',
			selected : 'A',
			options : [
			           {text : '강의명', value : 'A'},
			           {text : '강사명', value : 'B'}
			           ]
			
		},
		computed : {
			filtered : function() {
				
				 let cname = this.className.trim();
				return this.classList.filter((item) => {
					if(this.selected == 'A'){
						if(item.lec_nm.includes(cname)) {
							return true;
					}
					} else if(this.selected == 'B') {
						if(item.name.includes(cname)) {
							return true;
					}
					}
					
				})
			}
		},
		
		methods : {
			showInfo : function(index, lec_seq) {
				$('#showInfo_'+index).toggle();
			}
		,
		signUpFor : function(lec_seq) {
			//alert("lec_seq : " + lec_seq);
			applyForClass(lec_seq);
		},
		onChange : function(event) {
			 console.log(this.selected);
		}
		}
	});
};

// 수강신청 목록 조회
function classList() {
	console.log("여기왔나요? 1");
	var param='';
	
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		console.log("여기왔나요? 2");
		classListCallback(data); 
 	}
 	callAjax("/sss/classtListAct.do","post","json", true, param, resultCallback);
	
}

// 수강 신청 목록 조회 콜백
function classListCallback(data) {
	//alert(JSON.stringify(data));
	lect.classList=[];
	lect.classList=data.classtListAct;
}

// 수강 신청 
function applyForClass(lec_seq) {
	
	var param = {
			lec_seq : lec_seq
		 }
	var resultCallback = function(data){  // 데이터를 이 함수로 넘깁시다. 
		applyForClassCallback(data); 
 	}
 	callAjax("/sss/applyForClass.do","post","json", true, param, resultCallback);
}

// 수강신청 콜백
function applyForClassCallback(data) {
	
	if(data.result == "SUCCESS") {
		alert(data.resultMsg);
	}else {
		//오류 응답 메시지 출력
		alert(data.resultMsg);
	}
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
							<span class="btn_nav bold">수강신청</span> 
							<a href="#"class="btn_set refresh">새로고침</a>
						</p>
					</div>
					<h3 class="hidden">수강신청 검색 영역</h3>
				<div id="lecturer_box" >
					<div class="lecturer_searchbox">
						<div class="lecturer_selectbox">
							<select v-model="selected">
								<option v-for = "option in options" v-bind:value="option.value"  >
									{{ option.text}}
								</option>
							</select>
						</div >
						<div class="lecturer_serch_input">
							<input type="text" name="room_search" v-model="className"  placeholder="검색 내용을 입력해주세요." >
						</div>
					</div>
					<!-- /.lecturer_searchbox -->
					
					<div class="lecturer_box">
						<div class="lecturer_tit_box">
							수강 신청 목록
						</div>
						<div class="lecturer_listbox">
							<table id="classInfo">
								<thead>
									<tr>
										<th width="6%">No.</th>
										<th width="28.3%">강의명</th>
										<th width="28.3%">강사명</th>
										<th width="28.3%">등록일</th>
										<th width="10%">수강신청</th>
									</tr>
								</thead>
								<tbody>
									<template v-for="(list, index) in filtered">
									<tr >
										<td colspan="4" @click="showInfo(index, list.lec_seq)">
											<div class="simple_lecInfo">
												<div class="index_num">
													{{ index+1 }}
												</div>
												<div class="lec_name" >
													{{ list.lec_nm }}
												</div>
												<div class="t_name" >
													{{ list.name }}
												</div>
												<div class="lec_enr" >
													{{ list.lec_enr }}
												</div>
											</div>
										</td>
										<td>
											<button type="button" @click="signUpFor(list.lec_seq)">수강신청</button>
										</td>
									</tr>
									<tr style="display:none" :id="'showInfo_'+index ">
										<td colspan="4">
											<div class="lectureInfo_box">
												<div class="lecture_tit">
													{{ list.lec_nm }}
												</div>
												<div class="lecturer_name">
													<span>강사</span> : {{ list.name }}
												</div>
												<div class="lecture_date">
													<span>강의 기간</span> : {{ list.lec_st }} ~ {{ list.lec_ed }}
												</div>
												<div class="lecture_aim">
													<span>수업목표</span> : {{ list.lec_gl }}
												</div>
												<div class="lecture_plan">
													<span>수업계획</span> : {{ list.lec_pl }}
 												</div>
 												<div class="lecture_cont">
													<span>수업내용</span> : {{ list.lec_contents }}
 												</div>
 												<div class="lecture_curriculum">
 													<span>* 강의 커리큘럼은 다운받아 주시기 바랍니다.</span><br>
 													<a href="#">{{ list.lec_nm }} 커리큘럼</a>
 												</div>
											</div>
											<!-- /.lectureInfo_box -->
										</td>
									</tr>
									</template>
								</tbody>
							</table>
						</div>
					</div>
					<!-- /.lecturer_box -->
					</div>
				</li>
			</ul>
		</div>
	</div>


</body>
</html>