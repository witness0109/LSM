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


<script src="https://cdn.jsdelivr.net/npm/vue"></script>



<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<script>

var userid="${sessionScope.loginId}";

var LecListVue;
var picks ='';
$(function(){
	
	console.log(" ++ 설문조사 홈");
	init();
	fgetLecList();
});




function init(){

	var eventBus = new Vue();	
	
	
	 Vue.component('radioboxC', { 
			template:
				'<tr style="text-align: -webkit-center;"  >'+
				'	<td colspan="3">{{rdata}} : {{pick}}</td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="1"  checked="checked" @change="sendscore"></td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="2" @change="sendscore"></td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="3" @change="sendscore"></td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="4" @change="sendscore"></td>'+
				'	<td><input type="radio" v-model="pick" :id="pickid" value="5" @change="sendscore"></td>'+
				'</tr>'
			,
			data:function(){
				return {
						pick:''
				}
			},
			props:['rdata','pickid'],
			methods:{
				sendscore:function(){
					
					console.log("target.id : "+event.target.id);
					var id= event.target.id;
					var score =this.pick;
					
					eventBus.$emit('sendeventscore',id,score);
				}
			}
			
		}); 

	



	
	
	LecListVue = new Vue({
		el:'#vuedatatable',
		data:{
			items:[],
			row:[]
		},
		methods:{
			dosurvey:function(row){
				this.row = row;
				qnaWritePopup("#layer1");
			}
		}
	});
	
	
	doSurveyVue = new Vue({
		el:'#surveyModal',
		created :function(){
			eventBus.$on('sendeventscore',function(id,score){
				
				console.log("id : " +id);
				console.log("score : " +score);
				
				if(picks != ''){
					picks=picks.substring(0,picks.lastIndexOf('}'));
					picks +=',"'+id+'":'+score+'}';
				}else{
					picks +='{"'+id+'":'+score+'}';
				}
				
				/* console.log(picks);
				const obj = JSON.parse(picks);
				
				for(var k in obj){
					console.log("k :"+k+" value : " + obj[k]);
				} */
		
			});
		},
		data:{
			items:[
			       {"qst":"시간이 잘 지켜졌습니까?","id":"pick1"},
			       {"qst":"학생들과의 소통을 잘하였습니까?","id":"pick2"},
			       {"qst":"시험의 난이도는 어땠습니까?","id":"pick3"},
			       {"qst":"내용 전달이  잘되었습니까? ","id":"pick4"}
			       ],
			picks:'',
			comment:''
		},
		methods:{
			cancel:function(){
				gfCloseModal();
			},
			savesurvey:function(){
				//alert("저장!");
				fsaveSurvey();
			}
		}
	});
	
}


function fsaveSurvey(){
	var totalScore=0;
	console.log(picks);
	var obj = JSON.parse(picks);
	for(var k in obj){
		console.log("k :"+k+" value : " + obj[k]);
		totalScore+=obj[k];
	}
	//alert(totalScore);
	
	var param={
		lec_seq:LecListVue.row.lec_seq,
		comment:doSurveyVue.comment,
		totalScore:totalScore,
		enr_user:userid
	};

	
	var resultCallback = function(data) {
		alert("저장 "+data.msg);
		doSurveyVue.comment='';
		$("input[type=radio]").prop("checked",false);
		
		gfCloseModal();
		fgetLecList();
		
	};
	
	
	
	callAjax("/survey/savesurvey.do", "post", "json",true, param ,resultCallback);
	
	
	
	
	
	
}


function fgetLecList(){
	var resultCallback = function(data) {
		
		LecListVue.items=data.list;
	};
	var param={
			user_id : userid
	}
	callAjax("/survey/lectureList.do", "post", "json",true, param ,resultCallback);
}

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


</script>


</head>
<body>
	<jsp:include page="/WEB-INF/view/ssm/survey/lecList.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/ssm/survey/doSurvey.jsp"></jsp:include>
</body>
</html>