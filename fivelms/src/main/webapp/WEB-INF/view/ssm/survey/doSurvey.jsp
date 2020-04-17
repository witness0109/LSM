<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div id="layer1" class="layerPop layerType2" style="width: 1000px; hight: 1000px;">
			
			<div id="test">
				<radioboxC></radioboxC>
			</div>
			
			<dl>
				<dt>
					<strong>설문조사</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<div id="surveyModal" >
					<table class="row" >
						<caption>caption</caption>
						<colgroup>
							<col width="200px">
							<col width="*">
							<col width="200px">
							<col width="80px">
							<col width="80px">
							<col width="80px">
							<col width="80px">
							<col width="80px">
						</colgroup>
						<thead>
							<tr>
								<th rowspan="2" colspan="3">내용</th>
								<th colspan="5">선택</th>
							</tr>
							<tr>
								<th>1</th>
								<th>2</th>
								<th>3</th>
								<th>4</th>
								<th>5</th>
								
							</tr>
						</thead>
						<!-- <tbody> -->
							<tr is="radioboxC" :rdata="items[0].qst" :pickid="items[0].id"></tr>
							<tr is="radioboxC" :rdata="items[1].qst" :pickid="items[1].id"></tr>
							<tr is="radioboxC" :rdata="items[2].qst" :pickid="items[2].id"></tr>
							<tr is="radioboxC" :rdata="items[3].qst" :pickid="items[3].id"></tr>
							
						
							<tr>
								<td colspan="8">&nbsp;</td>
							</tr>
						
							<tr style="border-top: solid;">
								<td colspan="8"><span>한마디하세요</span></td>
							</tr>
							<tr>
								<td colspan="8">
									<input type="text" style="width:100%; height:100%;" v-model="comment">
								</td>
							</tr>
						<!-- </tbody> -->
					</table>
					
						<div class="btn_areaC mt30">
					
						<a  class="btnType blue" @click.prevent="savesurvey"><span>저장</span></a>
		
						<a href="" class="btnType gray" @click="cancel"><span>취소</span></a>
					</div>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
