<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 모달 배경 -->
<div id="mask"></div>

<div id="wrap_area">
	<h2 class="hidden">컨텐츠 영역</h2>
	<div id="container">
		<ul>
			<li class="lnb">
				<!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				<!--// lnb 영역 -->
			</li>
			<li class="contents">
				<!-- contents -->
				<h3 class="hidden">contents 영역</h3> <!-- content -->
				<div class="content">

					<p class="Location">
						<a href="#" class="btn_set home">메인으로</a> <a href="#"
							class="btn_nav">학습관리</a> <span class="btn_nav bold">Q%A</span> <a
							href="#" class="btn_set refresh">새로고침</a>
					</p>

					<p class="conTitle" id="searcharea">
						<span>설문조사</span> <span class="fr">
					</p>
					<div class="bootstrap-table">
						<div class="fixed-table-toolbar">
							<div class="bs-bars pull-left"></div>
							<div class="columns columns-right btn-group pull-right"></div>
						</div>
						<div class="fixed-table-container" style="padding-bottom: 0px;">
							<div class="fixed-table-body">

								<table id="vuedatatable" class="col2 mb10" style="width:100%;">
									<colgroup>
										<col width="50px">
										<col width="*">
										<col width="100px">
										<col width="100px">
										<col width="100px">
										<col width="100px">
										<col width="60px">
									</colgroup>
									<thead>
										<tr>
											<th data-field="no">번호</th>
											<th data-field="lec_nm">과목명</th>
											<th data-field="enr_user">강사</th>
											<th data-field="lec_st">강의시작일</th>
											<th data-field="lec_ed">강의종료일</th>
											<th data-field="rm_seq">강의실</th>
											
											<th data-field="qna_cnt">설문참여</th>
										</tr>
									</thead>
									
									<tbody v-for="(row, index) in items" v-if="items.length">
										<tr>
											<td>{{ index + 1}}</td>
											<td>{{ row.lec_nm }}</td>
											<td>{{ row.teacher }}</td>
											<td>{{ row.lec_st }}</td>
											<td>{{ row.lec_ed }}</td>
											<td>{{ row.rm_seq }}</td>
											
											<td v-if="row.YY" >완료</td>
											<td v-else ><a type="button" class="btnType blue" @click.prevent="dosurvey(row)">참여</a></td>
										</tr>
									</tbody>
								</table>
								<div>
									<div>
										<div class="clearfix" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</li>
		</ul>

	</div>
</div>






