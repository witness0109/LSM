<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


		<div id="lecdoc_write" class="layerPop layerType2"
			style="width: 800px; height: 600px;">

			<!-- 수정시 필요한 num 값을 넘김  -->

			<dl>
				<dt>
					<strong>목록 등록하기 </strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<div id="writevue">
								<input type="hidden" id="action" name="action" value=""  v-model="action"> 
								<input type="hidden" id="ldo_seq" name="ldo_seq"  v-model="ldo_seq">
					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td>
								<input type="text" class="inputTxt p100" name="enr_user"	id="enr_user"  v-model="enr_user"  disabled/></td>
								<th scope="row">강의선택</th>
								<td><select name="lec_seq" id="lec_seq" onchange="lecNmDisplay(this.form)" >

								</select></td>
							</tr>



							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="lec_title" id="lec_title" v-model="lec_title"/></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="ldo_cont" id="ldo_cont"  v-model="ldo_cont" style="overflow-y: scroll;">
								</textarea></td>
							</tr>

							<tr>
								<th scope="row">파일 업로드</th>
								<td colspan="3"><input type="file" class="inputTxt p100"
									name="lss_file" id="lss_file" >
									<div id="dv_lss_file"></div></td>
							</tr>

						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
					</div>
				</dd>

			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
