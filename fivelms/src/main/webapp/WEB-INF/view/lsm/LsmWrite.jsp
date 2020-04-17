<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="layer1" class="layerPop layerType2" style="width: 700px; height: 500px;">
		<dl>
			<dt>
				<strong>과제 관리</strong>
			</dt>
			<dd class="content" >
			
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
							<tr>
								<td style="display : none"><input type="hidden" name="task_seq" id="task_seq" ></td>
							</tr>
							<tr>
								<th scope="row"  id="nm"  >강의선택 <span class="font_red">*</span></th>
								<td >
								        <select name="lec_seq" id="lec_seq" onchange ="lecNmDisplay(this.form)" >
					
									    </select>
								</td>
								<th scope="row">강의명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="lec_nm" id="lec_nm" value=""/>
							    </td>
							</tr>
							<tr>
								<th scope="row">과제명</th>
								<td><input type="text" class="inputTxt p100" name="task_nm" id="task_nm" /></td>
								<th scope="row">담당 강사명</th>
								<td>
									<input type="text" name="enr_user"  id="enr_user"  value=""  readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<th scope="row"  rowspan= "3"> 내용 </th>
								<td rowspan="3" colspan="3"><textarea class="inputTxt p100"  name="task_cont" id="task_cont"  style =  "resize : none"></textarea></td>
							</tr>
							<tr></tr>
							<tr></tr>
							<tr>
								<th scope="row">파일첨부</th>
								<td colspan="3">
								<input type="file" class="inputTxt p100" name="lsm_file" id="lsm_file">
								<div id="dv_lsm_file"></div>
								</td>
							</tr>
					
					</tbody>
					
				</table>
		
				<!-- e : 여기에 내용입력 -->
			
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveLsmCod" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDeleteLsmCod" name="btn"><span>삭제</span></a>  
					<a href=""	class="btnType gray"  id="btnCloseLsmCod" name="btn"><span>취소</span></a>
				</div>
					
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

