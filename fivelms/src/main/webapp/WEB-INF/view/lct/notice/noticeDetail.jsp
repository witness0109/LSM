<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 공지사항 상세보기 모달팝업 -->
	<form id="detailNotice" action="" >
	<div id="noticeDetailvue" class="layerPop layerType2" style="width: 1100px; hight: 1000px;">
	
		<input type="hidden" name="action" id="daction" value="">
		<input type="hidden" name="nt_seq" id="dnt_seq" value="">
		<dl>
			<dt>
				<strong>공지사항 상세보기 </strong>
			</dt>
			<dd class="content">
			
				<div >
					<table class="row" id="detailtable"><!--  id="detailtable"  -->
					
					
						<caption>caption</caption>
						
						<colgroup>
							<col width="60px">
							<col width="120">
							<col width="120px">
							<col width="120">
							<col width="120px">
							<col width="120">
						</colgroup>
						<!-- <tbody> -->
						
							<tr>
								<th scope="row">제목 </th>
								<td>
								<input type="text" class="inputTxt p100" name="nt_title" id="d_nt_title" v-model="nt_title"/>
								</td>
								<th scope="row">작성자 </th>
								<td><input type="text" class="inputTxt p100" name="enr_user" id="d_enr_user" v-model="enr_user" /> 
								</td>
								<th scope="row">등록일 </th>
								<td><input type="text" class="inputTxt p100" name="enr_date" id="d_enr_date" v-model="enr_date"/>
								</td>
							</tr>
							<tr >
								<th scope="row" >내용<span class="font_red">*</span></th>
								<td colspan="5">
								
								<div   style="width: 100%;"   id="d_nt_contents">
								 <quill-editor
								    ref="quillEditor" class="editor" v-model="nt_contents" :options="editorOption"
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
							
									<div v-if="fileupdateset">
										<div v-if="file_nm !=''  & file_nm != null" id="filearea" @click="DownloadQnaFileEvent" >
											<img src="/images/treeview/file.gif" name="file_nm"id="d_file_nm">
											<span >{{file_nm}}</span>
											<span style="font-size: xx-small;" >  {{file_size}}Byte</span>
											<img v-if="file_nm !='' "src="/images/treeview/minus.gif" @click="minusClickEvent">
										</div>
										
											<input type="file" name="file_nm" id="dfile_nm" @change="setFileName" ></input>
											
										
									</div>
									
								</td>
							</tr>
							
						<!-- </tbody> -->
					</table>
				</div>
					<%-- <jsp:include page="/WEB-INF/view/mss/noticeReply.jsp"></jsp:include> --%>
				<div class="btn_areaC mt30" id="updateoption">
					
						<a v-if="option" 
								href="javascript:fdeleteNotice()" class="btnType blue"><span>삭제</span></a>
								
						<a v-if="option" 
								href="javascript:fupdateNotice()" class="btnType blue"><span>저장</span></a>
						
						<a v-if="'${sessionScope.loginId}'== enr_user & !option"  class="btnType blue" @click.prevent="optionch"><span>수정</span></a>
								
								
						<a href="javascript:cancle()" class="btnType gray" ><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	</form>