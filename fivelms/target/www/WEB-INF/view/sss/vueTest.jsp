<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>


<script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<!-- Quill JS Vue -->
<script
	src="https://cdn.jsdelivr.net/npm/vue-quill-editor@3.0.6/dist/vue-quill-editor.js"></script>
<!-- Include stylesheet -->
<link href="https://cdn.quilljs.com/1.3.4/quill.core.css"
	rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.snow.css"
	rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.bubble.css"
	rel="stylesheet">

<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/bootstrap-datepicker.js"></script>


<style>
body {
	text-align: center;
}
</style>


<script type="text/javascript">
	var test;
	var test2;
	$(function() {
		/* 	alert("온로드"); */
		vueInit();

	});
	function vueInit() {
		Vue.use(VueQuillEditor);

		test = new Vue({
			el : '#test',
			data : {
				searchkey : 'nt_title',
				searchword : '',
				pageIndex : 0,
				pageSize : 5,
				file_nm : '',
				items : []
			},
			methods : {
				enterpush : function() {

					aa();
				},
				setFileName : function() {
					this.file_nm = event.target.files[0].name;

				}
			}
		});

		test2 = new Vue({
			el : '#test2',
			data : {
				contents : 'asdfasdf',
				editorOption : {
					theme : 'snow'
				}
			},
			methods : {
				onEditorBlur : function(quill) {
					console.log('editor blur!', quill);
				},
				onEditorFocus : function(quill) {
					console.log('editor focus!', quill);
				},
				onEditorReady : function(quill) {
					console.log('editor ready!', quill);
				},
				whatthe : function() {
					console.log('출력이요');

				}
			},
			computed : {
				editor : function() {
					// alert( this.$refs.quillEditor.quill.getText());
					return this.$refs.quillEditor.quill
				},
				mounted : function() {
					console.log('this is quill instance object', this.editor)
				}
			}
		});
		
		
		
		new Vue({
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
		});		
		
		
		
		
		

	}

	function aa() {

		var param = {

		};

		var resultCallback = function(data) {
			test.items = data.list;

			/* 	for( var key in data.list){
					alert("asdf"+key);
					   console.log("key : "+ key+" ,  value : "+data.list[key]);
				}; */
		};

		callAjax("/sss/TestVueSearch2.do", "post", "json", true, test.$data,
				resultCallback);
	}

	function callAjax(url, method, dataType, async, param, callback) {
		$.ajax({
			url : url,
			type : method,
			dataType : dataType,
			async : async,
			data : param,
			beforeSend : function(xhr) {

			},
			success : function(data) {
				callback(data);
			},
			error : function(xhr, status, err) {

			},
			complete : function(data) {

			}
		});

	}

	function click() {
		alert(test2.contents);
	}
</script>
</head>
<body>

	<div id="test">
		<select v-model="searchkey">
			<option value="nt_title" selected="selected">제목</option>
			<option value="nt_contents">내용</option>
			<option value="enr_user">작성자</option>
		</select> <input type="test" v-model="searchword" @keyup.enter="enterpush"
			placeholder="하이요?"> <input type="button" value="검색"
			@click="enterpush"> <input type="file" name="file_nm"
			id="wfile_nm" @change="setFileName"></input>

		<h1 v-if="searchword != ''">{{searchkey}} 로검색 :{{searchword}}</h1>

		<div v-for="row in items">
			<h1>{{row.nt_title}}</h1>
		</div>

		<h1>{{file_nm}} 갱신2 wscscsc</h1>

	</div>


	<div id="ininin">


		<div id="test2">
			<div>
				<h1>sadfsdfsadf</h1>
				<quill-editor ref="quillEditor" class="editor" v-model="contents"
					:options="editorOption" @blur="onEditorBlur($event)"
					@focus="onEditorFocus($event)" @ready="onEditorReady($event)" />
				<br>

			</div>
			<!-- 	<div class="content ql-editor"  ></div> -->
			<div>
				<h1>나오나 : {{contents}}</h1>
			</div>
		</div>


	</div>



	<a href="javascript:click()">클라ㅣㄱ</a>




	<div id="wrap_area">

		<div id="container">
			<ul>
				
				<li class="contents">
				
					<div class="content">
						<div>
							<template id="searcharea2">
							<div class="input-group date" style="width: 150px;">
								<input id="indate" name="indate" type="text"
									class="form-control" v-model="date" /> <span
									class="input-group-addon"><i class="fa fa-calendar"></i></span>
							</div>
							</template>
						</div>

					
						
					</div>
				</li>
			</ul>

		</div>
	</div>







</body>
</html>