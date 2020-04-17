<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<!-- 모달팝업 -->
	<form id="detailQna" action="" method="">
	<div id="noticevue" class="layerPop layerType2" style="width: 1000px; hight: 1000px;">
		<input type="hidden" name="action" id="action2" value="">
		<input type="hidden" name="qna_seq" id="qna_seq2" value="">
		<!-- 수정시 필요한 num 값을 넘김  -->

		<dl>
			<dt>
				<strong>Q&A 상세보기 </strong>
			</dt>
			<dd class="content">
				<div id="editvue">
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="140px">
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
								<input type="text" class="inputTxt p100" name="qna_title" id="qna_title" v-model="qna_title"/>
								</td>
								<th scope="row">작성자 </th>
								<td><input type="text" class="inputTxt p100" name="enr_user" id="enr_user" v-model="enr_user" />
								</td>
								<th scope="row">등록일 </th>
								<td><input type="text" class="inputTxt p100" name="enr_date" id="enr_date" v-model="enr_date"/>
								</td>
							</tr>
							<tr >
								<th scope="row" >내용<span class="font_red">*</span></th>
								<td colspan="5">
								<!-- <input type="text" style="height: 300px;" class="inputTxt p100" name="qna_contents" id="qna_contents" v-model="qna_contents"/> -->
								<div id="vueapp"  style="width: 900px;"  name="qna_contents" id="qna_contents">
								 
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
							
									
									<div v-if="file_nm !='' && file_nm != null" @click="fDownloadQnaFileEvent" id="filearea">
									<img src="/images/treeview/file.gif" name="file_nm"id="file_nm">
									<span >{{file_nm}}</span>
									<span style="font-size: xx-small;" >  {{file_size}}Byte</span>
									</div>
									<div v-else>
										<input v-if="option" type="file" name="file_nm" id="dfile_nm" @change="setfilename" ></input>
										<img v-if="file_nm !='' && option"src="/images/treeview/minus.gif" @click="minusClickEvent">
									</div>
									
									
								</td>
							</tr>
						</tbody>
					</table>
				</div>
					<jsp:include page="/WEB-INF/view/ssm/qna/qnaReply.jsp"></jsp:include>
				
				<div class="btn_areaC mt30" id="updateOption">
						
						<a v-if="option" href="" class="btnType blue" @click="deleteqna"><span>삭제</span></a>
						<a v-if="option" href="" class="btnType blue" id="btnupdateQna" name="btn"><span>저장</span></a>
						<a v-if="enr_user == '${sessionScope.loginId}' && !option"  class="btnType blue" @click="changeOption"><span>수정</span></a>
						
						<a href="" class="btnType gray" id="btnClose_vue" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	</form>
	