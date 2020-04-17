<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script>
var app;
var sListV;
var teacher = '${sessionScope.loginId}';
var sListOneV;

$(function(){
	
	init();
	
	flecList();
	
});

function init(){
	
	
	
	app = new Vue({
		  el: '#list',
		  data: {
		    items:[]
		  },
		  methods : {
			  eventSList:function(item){
				  
				  sListset(item);
				  $("#content2").css("display", "block");
			  }
		  }
		});
	
	
	sListV = new Vue({
			el : '#content2',
			data : {
				items:[]
			},
			methods :{
				showModal:function(item){
					fshowModal(item);
				}
			},
	});
	
	sListOneV = new Vue({
			el : "#layer1",
			data :{
				cns_seq: '',
				cns_date: '',
				cns_place : '',
				cns_cstnt : '',
				cns_cstee : '',
				cns_content : '',
				cns_check : 'N',
				cns_nm : ''
			},
			methods :{
				updateCns:function(){
					fupdateCns();
				}
			},
	});
	
}

//유저 리스트
function sListset(item){

	var param = {
			lec_seq : item.lec_seq				
	}
	var resultCallback = function(data) {
		sListV.items=data.sList;
		
	};

	callAjax("/lss/selectSList.do", "post", "json", true, param, resultCallback);
}
//강의 리스트
function flecList(){
	
	var param = {
		user_id : teacher

	}

	var resultCallback = function(data) {
		app.items=data.list;
	};

	callAjax("/lss/lecList.do", "post", "json", true, param, resultCallback);
}
//모달 띄우기
function fshowModal(item){
	
	var param = {
			user_id : item.user_id,
			lec_nm : item.lec_nm
	}
	
	var resultCallback = function(data){

		for( var k in data.list){
			console.log("k : "+ k + " value : " + data.list[k]);
		}
		
		sListOneV.cns_seq = data.list.cns_seq;
		sListOneV.cns_date = data.list.cns_date;
		sListOneV.cns_place = data.list.cns_place;
		sListOneV.cns_cstnt = data.list.cns_cstnt;
		sListOneV.cns_cstee = data.list.cns_cstee;
		sListOneV.cns_content = data.list.cns_content;
		
		sListOneV.cns_nm = data.list.cns_nm;
		
		gfModalPop("#layer1");
		
	}
	callAjax("/lss/sListOne.do", "post", "json", true, param, resultCallback);
}

function fupdateCns(){
	
	
	
	var resultCallback = function(data) {
		alert(data.msg);
		gfCloseModal();
	};
	
	callAjax("/lss/updateCns.do", "post", "json", true, sListOneV.$data, resultCallback);
}
</script>
</head>
<body>
<div id="mask"></div>
		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb"><jsp:include
							page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3>

						<div class="content">
							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">학습지원</a> <span class="btn_nav bold">수강
									상담 이력 </span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
							<p class="search">
								<select id="searchKey" name="searchKey" style="width: 80px;">
									<option value="lec_nm" id="option1" selected="selected">강의명</option>
									<option value="user_id" id="option2">강사명</option>
								</select> <input type="text" id="searchWord" name="searchWord"
									placeholder="" style="height: 28px;"> <a
									class="btnType blue" href="javascript:fcnsList()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>
							</p>
							<p class="conTitle">
								<span id="">수강 상담 이력</span>
							</p>
							<span style="font-weight: bold; color: gray;">강의목록</span>
							<div class="divlist">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="35%">
										<col width="65%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">강의명</th>
											<th scope="col">기간</th>
										</tr>
									</thead>
									<tbody id="list">
										<tr v-for = "(item,index) in items" v-if = "items.length">
											<td v-on:click="eventSList(item)">{{item.lec_nm}}</td>
											<td>{{item.stDay}} - {{item.edDay}}</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="paging_area" id="listPagiNation"></div>
				
							<div id = "content2" style="display: none;">
							<p class="conTitle mt50">
								<span>학생목록</span><span class="fr">
								</span>
							</p>

							<div class="divCnsUserDtlList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="5%">
										<col width="5%">
										<col width="5%">
										<col width="5%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">과목명</th>
											<th scope="col">이름</th>
											<th scope="col">주소</th>
											<th scope="col">이메일</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="cnsUserDtlList">
										<tr v-for ="(item,index) in items" v-if = "items.length">
											<td>{{item.lec_nm}}</td>
											<td>{{item.user_id}}</td>
											<td>{{item.user_addr}}</td>
											<td>{{item.user_email}}</td>
											<td><a @click.prevent="showModal(item)">수강상담보기</a></td>
										</tr>
									</tbody>
								</table>
							</div>
							
							<div class="paging_area" id="listDtlPagiNation"></div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>수강상담관리</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="*">
							<col width="120px">
							<col width="*">
						</colgroup>

						<tbody>
							<a><span class="font_red">※등록/수정 후 저장을 눌러주세요.</span></a>
							<tr>
								<th scope="row">강의명</th>
								<td>
								<input type="text" class="inputTxt p100" v-model ="cns_nm"
									name="cns_nm" id="cns_nm" readonly="readonly"/></td>
									
									<th scope="row">상담장</th>
								<td colspan="3">
								<input type="text" class="inputTxt p100" v-model ="cns_place"
									name="cns_place" id="cns_place" readonly="readonly"/></td>
							</tr>
							<tr>
								<th scope="row">상담자 <span class="font_red"></span></th>
								<td><input type="text" class="inputTxt p100"
									name="cns_cstnt" id="cns_cstnt" v-model ="cns_cstnt"readonly="readonly"/></td>
								<th scope="row">대상자</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="cns_cstee" id="cns_cstee" v-model ="cns_cstee"readonly="readonly"/></td>
							</tr>
							<tr>
								<th scope="row">상담일자 <span class="font_red"></span></th>
								<td><input type="date" class="inputTxt p100" name="lec_st"
									id="lec_st" v-model ="cns_date"style="font-size: 15px"readonly="readonly" />
									<th scope="row">확인여부 <span class="font_red"></span></th>
								<td>
									<select v-model ="cns_check"> 
										<option value="Y">Y</option>
										<option value="N">N</option>
									</select>
							</tr>
							<tr>
								<th scope="row">상담내용 <span class="font_red"></span></th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="cns_content" id="cns_content" v-model="cns_content"
										readonly="readonly" /></textarea></td>
							</tr>

							<tr>
								
							</tr>
					</table>


					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" @click.prevent="updateCns"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnCloseGrpCod" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
</body>
</html>