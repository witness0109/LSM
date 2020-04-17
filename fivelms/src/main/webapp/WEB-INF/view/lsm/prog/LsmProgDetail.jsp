<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


		<div id="prog_edit" class="layerPop layerType2"
			style="width: 800px; height: 600px;">

			<!-- 수정시 필요한 num 값을 넘김  -->

			<dl>
				<dt>
					<strong>목록 등록하기 </strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<div id="detailtable">
								<input type="hidden" id="action" name="action" value=""  > 
					<table class="row">
						<caption>caption</caption>

						<tbody>
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td>
								<input type="text" class="inputTxt p100" name="enr_user"	id="enr_user"  readonly="readonly"/></td>
								<th scope="row">강의명</th>
								<td><input name="lec_nm" id="lec_nm" class="inputTxt p100" readonly="readonly" /></td>
							</tr>
							<tr>
								<th> 강의시작날 </th>
								<td> <input type="text" class="inputTxt p100"
								name="lec_st" id="lec_st"  readonly="readonly"/></td>
							
							<th> 강의종료날 </th>
								<td> <input type="text" class="inputTxt p100"
								name="lec_ed" id="lec_ed" /></td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3"><textarea class="inputTxt p100"
										name="ldo_cont" id="ldo_cont"   style="overflow-y: scroll;">
								</textarea></td>
							</tr>

						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnSave" name="btn"><span>수정</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
					</div>
				</dd>

			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
