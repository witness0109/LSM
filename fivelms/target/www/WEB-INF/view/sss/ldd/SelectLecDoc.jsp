<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- 모달팝업 -->
	<form id="SelectSssForm" action="" method="">
	<div id="Sss_Detail" class="layerPop layerType2" style="width: 800px; height: 600px;">
		<input type="hidden" id="action" name="action" value="">
		<input type="hidden" id="ldo_seq" name="ldo_seq" v-model="item.ldo_seq" > 
		<input type="hidden" id="lec_seq" name="lec_seq" v-model="item.lec_seq">
		<!-- 수정시 필요한 num 값을 넘김  -->

		<dl>
			<dt>
				<strong>학습자료</strong>
			</dt>
			<dd class="content">
			<div id = "detailvue">

				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">강사명 </th>
							<td><input type="text"  class="inputTxt p100" name="enr_user"	 id="enr_user"  v-model="item.enr_user" disabled /></td>
							<th scope = "row"> 강의명 </th>
							<td><input type="text"   class="inputTxt p100" name="lec_title"	 id="lec_title"  v-model="item.lec_title" disabled/></td>
						</tr>
		
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="lec_title" id="lec_title"  v-model="item.lec_title" disabled/></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3">
							<textarea  class="inputTxt p100" name="ldo_cont" id="ldo_cont" v-model="item.ldo_cont"style="overflow-y:scroll;" readonly>
								</textarea>
							</td>
						</tr>
						
					<tr>
							<th scope="row">첨부 파일</th>
							<td colspan="5" >
							
							<div v-if="item.lgc_fil_nm != '' & item.lgc_fil_nm != null" id= "filearea" @click = "DownloadLecDoc">
								<img src="/images/treeview/file.gif" name="lgc_fil_nm" id="lgc_fil_nm">
								<span>{{item.lgc_fil_nm}}</span>
								<span style="font-size:xx-small;"> {{item.fil_siz}}Byte</span>
							</div> 
						<div v-else>
								<input type="file" name="file_nm" id="dfile_nm" @change="setFileName"></input>
								<img v-if="lgc_fil_nm !='' "src="/images/treeview/minus.gif" @click="minusClickEvent">
						</div> 

							</td>
						</tr>  

					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
				</div>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>