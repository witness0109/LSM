<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>




<script src="https://cdn.quilljs.com/1.3.4/quill.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
<!-- Quill JS Vue -->
<script src="https://cdn.jsdelivr.net/npm/vue-quill-editor@3.0.6/dist/vue-quill-editor.js"></script>
<!-- Include stylesheet -->
<link href="https://cdn.quilljs.com/1.3.4/quill.core.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.snow.css" rel="stylesheet">
<link href="https://cdn.quilljs.com/1.3.4/quill.bubble.css" rel="stylesheet">




<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<style>
.ql-editor{
	
    height: 300px;
	
}
</style>

<script>
	var pageSize = 5;
	var pageBlockSize = 5;
	
	var sV;
	var nLV;
	var dV;
	var gitem=[];
	
	/** OnLoad event */
	$(function() {
		
		console.log("noticeListHome in ......")
		init();
		fNoticeList();
		
		
	});
	////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	
	function init(){
		
		Vue.use(VueQuillEditor)
		
		dV = new Vue({
			el:'#detailVue',
			data:{
				row:[],
				editorOption: {
	     			theme: 'snow'
	    		}
			},
			methods:{
				onEditorBlur:function(quill) {
	     	    	console.log('editor blur!', quill)
	     	    },
	     	    onEditorFocus:function(quill) {
	     	    	console.log('editor focus!', quill)
	     	    },
	     	    onEditorReady:function(quill) {
	     	    	console.log('editor ready!', quill)
	     	    },
				fDownloadFileEvent:function(nt_seq){
					 if(confirm("다운받으시겠습니까?")){
	     	    		 fDownloadFile(nt_seq);
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
		
		
		nLV = new Vue({
			el:'#listVue',
			data:{
				items:[],
				editorOption: {
	     			theme: 'snow'
	    		}
			},
			methods:{
				itemClickEv:function(item){
					
					setrow(item);
					gfModalPop("#layer1");	
				}
			}
		});
		
		 sV= new Vue({
			el:"#searcharea",
			data:{
				searchkey:'nt_title',
				searchword:''
			},
			methods:{
				searchSend:function(){
					fNoticeList(1,this.searchkey,this.searchword);
				}
			}
		});
		
	}
	function setrow(item){
		alert("set");
		dV.row=item;
	
	}


	
	//공지사항 리스트 조회
	function fNoticeList(currentPage,searchkey,searchword){
	
		currentPage = currentPage || 1;
		searchkey = searchkey || "";
		searchword = searchword || "";
		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			searchkey : searchkey,
			searchword : searchword
		}

		var resultCallback = function(data) {
			
			//fNoticeListResult(data,currentPage);
			nLV.items=data.list;
			
			var paginationHtml = 
				getPaginationHtml(data.currentPageNoticeList, data.totalCountList,
						        data.pageSize, pageBlockSize, 'fNoticeList');

			//alert(paginationHtml);
			$("#noticePagination").empty().append(paginationHtml);

			// 현재 페이지 설정
			$("#currentPageNotice").val(currentPage);
			
		};
		
		callAjax("/sss/noticeList.do", "post", "json", true, param,resultCallback);
		
	};
	

	function closePopup(){
		gfCloseModal();
	};
	
	function fDownloadFile(nt_seq){
		
		 var params = "";
		params += "<input type='hidden' name='nt_seq' value='"+ nt_seq +"' />";
		jQuery("<form action='/sss/downloadFile.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
 
		
		
		
	};
	
	
	
	
	


</script>



</head>
<body>
	<a href="/sss/TestVueSearch.do">VUE test Page</a>
	
	
	

	<!-- <form id="myForm" action="" method="">
		<input type="hidden" id="currentPageNotice" value="1"> 
		<input type="hidden" id="currentPageComnDtlCod" value="1"> 
		<input type="hidden" id="tmpGrpCod" value=""> 
		<input type="hidden" id="tmpGrpCodNm" value=""> 
		<input type="hidden" name="action" id="action" value=""> -->

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
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">

							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a> 
								<a href="#" class="btn_nav">학습지원</a> 
								<span class="btn_nav bold">공지사항</span> 
								<a href="#" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle"  id="searcharea">
								<span>공지 사항</span> 
								<span class="fr">
								
								<select id ="searchkey" name ="searchkey" style="width: 104px;" v-model="searchkey" >
									<option value="nt_title"   >제목</option>
									<option value="enr_user"   >작성자</option>
									<option value="nt_contents">내용</option>
								</select>
								<input type="text" id="searchword" name="searchword" v-model="searchword" @keyup.enter="searchSend"
										placeholder="입력하세요" style="height: 28px;"> 
								<a class="btnType blue" @click="searchSend" ><span>검색</span></a>
								</span>
								
							</p>

							<div class="divComGrpCodList">
								<table class="col" id="listVue">
									<caption>caption</caption>
									<colgroup>
										<col width="6%">
										<col width="*">
										<col width="14%">
										<col width="14%">
										
										<col width="7%">
									</colgroup>

									<thead >
										<tr>
											<th scope="col">번호</th>
											<th scope="col">제목</th>
											<th scope="col">작성자</th>
											<th scope="col">작성일</th>
											
											<th scope="col">조회수</th>
										</tr>
									</thead>
<!-- ////////////////////// -->	<tbody v-for="(item,index) in items" v-if="items.length">
										<tr @click="itemClickEv(item)">
											<td class="hidden">{{ item.nt_seq }}</td>
											<td>{{ index + 1}}</td>
											<td>{{ item.nt_title }}
											<img v-if="item.file_nm !=''"
											 src="/images/treeview/file.gif">
											</td>
											<td>{{ item.enr_user }}</td>
											<td>{{ item.enr_date }}</td>
											<td>{{ item.nt_cnt }}</td>
											
										</tr>
									
									</tbody>
								</table>
							</div>

							<div class="paging_area" id="noticePagination"></div>
							<br>
							<!--
							학생 공지사항이라 필요없음.
							 <span class="fr"> <a class="btnType blue"
								href="javascript:fPopModalNotice();" name="modal"><span>글쓰기</span></a>
							</span> -->

						</div> <!--// content -->



						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 1000px; hight: 1000px;">
			<dl>
				<dt>
					<strong>공지사항</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row" id="detailVue">
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
								<th scope="row">제목 </th>
								<td>
								<input type="text" class="inputTxt p100" name="nt_title" id="nt_title" v-model="row.nt_title" />
								</td>
								<th scope="row">작성자 </th>
								<td><input type="text" class="inputTxt p100" name="enr_user" id="enr_user"v-model="row.enr_user" />
								</td>
								<th scope="row">등록일 </th>
								<td><input type="text" class="inputTxt p100" name="enr_date" id="enr_date" v-model="row.enr_date"/>
								</td>
							</tr>
							<tr >
								<th scope="row" >내용<span class="font_red">*</span></th>
								<td colspan="5">
								
									 <quill-editor
									    ref="quillEditor" class="editor" v-model="row.nt_contents" :options="editorOption"
									    @blur="onEditorBlur($event)"
									    @focus="onEditorFocus($event)"
									    @ready="onEditorReady($event)"
									  />
									  <br>
									
								</td>
							</tr>
							<tr>
								<th scope="row" >파일<span class="font_red">*</span></th>
								<td colspan="5">
							
									<div v-if="row.file_nm !=''" @click="fDownloadFileEvent(row.nt_seq)" >
									<img src="/images/treeview/file.gif" name="file_nm"id="file_nm">
									<span >{{row.file_nm}}</span>
									<span style="font-size: xx-small;" >  {{row.file_size}}Byte</span>
									</div>
									
								</td>
							</tr>
							
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" href="javascript:closePopup()"><span>확인</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

		<!--// 모달팝업 -->

	<!-- </form> -->
	
	
	
</body>
</html>