<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


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
							class="btn_nav">학습관리</a> <span class="btn_nav bold">공지사항</span> <a
							href="#" class="btn_set refresh">새로고침</a>
					</p>

					<p class="conTitle" id="searcharea">
						<span>공지사항</span> <span class="fr"> <select id="searchkey"
							name="searchkey" style="width: 104px;" v-model="searchkey">
								<option value="nt_title">제목</option>
								<option value="enr_user">작성자</option>
								<option value="nt_contents">내용</option>
						</select> <input type="text" id="searchword" name="searchword"
							placeholder="입력하세요" style="height: 28px;" v-model="searchword"
							@keyup.enter="searchbtn"> <input type="button"
							class="btnType blue" name="search" id="searchBtn"
							@click="searchbtn" value="검색"></a> <!-- a태그에 @click 이벤트 같은걸? 걸어주면 href가 나중에 실행되는듯!!리로드현상해결.  -->
							<!-- <a class="btnType blue" href=""  name="search" id="searchBtn" @click="searchbtn"><span>검색</span></a> -->
						</span>

					</p>
					 <span style="float:left;"> <a class="btnType blue"
								href="javascript:fWriterQna();" name="modal"><span>글쓰기</span></a>
					</span> <br><br>

					<div id="vuetable">
						<div class="bootstrap-table">
							<div class="fixed-table-toolbar">
								<div class="bs-bars pull-left"></div>
								<div class="columns columns-right btn-group pull-right"></div>
							</div>
							<div class="fixed-table-container" style="padding-bottom: 0px;">
								<div class="fixed-table-body">



									<table id="vueListtable" class="col2 mb10"
										style="width: 1000px;">
										<colgroup>
											<col width="50px">
											<col width="*">
											<col width="50px">
											<col width="100px">
											<col width="50px">
										</colgroup>
										<thead>
											<tr>
												<th data-field="no">번호</th>
												<th data-field="nt_title">제목</th>
												<th data-field="enr_user">작성자</th>
												<th data-field="enr_date">작성일</th>
												<th data-field="nt_cnt">조회수</th>

											</tr>
										</thead>
										<!-- vue 적용.  -->
										<tbody>
											<template v-for="(item, index) in items" v-if="items.length">
											<tr @click="showDetail(item)">
												<td class="hidden">{{ item.nt_seq }}</td>
												<td>{{ index + 1}}</td>
												<td>{{ item.nt_title }} <img
													v-if="item.file_nm !='' & item.file_nm != null"
													src="/images/treeview/file.gif">
												</td>
												<td>{{ item.enr_user }}</td>
												<td>{{ item.enr_date }}</td>
												<td>{{ item.nt_cnt }}</td>

											</tr>
											</template>
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
					<div class="paging_area" id="pagingnavi2"></div>
					<br>

				</div>
			</li>
		</ul>

	</div>
</div>

