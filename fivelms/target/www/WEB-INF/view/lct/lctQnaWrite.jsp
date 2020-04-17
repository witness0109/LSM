<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
					<table class="row">
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
								 
								</div>
								</td>
							</tr>
							<tr>
								<th scope="row" >파일<span class="font_red">*</span></th>
								<td colspan="5">
									<!--multiple="multiple" -->
									<input type="file" name="file_nm" id="wfile_nm" @change="setfilenm" ></input>
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
	
