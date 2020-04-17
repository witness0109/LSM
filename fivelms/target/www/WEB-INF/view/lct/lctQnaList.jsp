<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<div id="vuetable">
	<div class="bootstrap-table">
		<div class="fixed-table-toolbar">
			<div class="bs-bars pull-left"></div>
			<div class="columns columns-right btn-group pull-right"></div>
		</div>
		<div class="fixed-table-container" style="padding-bottom: 0px;">
			<div class="fixed-table-body">

				<table id="vuedatatable" class="col2 mb10" style="width: 1000px;">
					<colgroup>
						<col width="30px">
						<col width="200px">
						<col width="30px">
						<col width="60px">
						<col width="50px">
					</colgroup>
					<thead>
						<tr>
							<th data-field="no">번호</th>
							<th data-field="qna_title">제목</th>
							<th data-field="enr_user">작성자</th>
							<th data-field="enr_date">작성일</th>
							<th data-field="qna_cnt">조회수</th>

						</tr>
					</thead>
					<!-- vue 적용.  -->
					<tbody>
						<template v-for="(row, index) in items" v-if="items.length">
						<tr onclick="vm.rowClicked(this)">
							<td class="hidden">{{ row.qna_seq }}</td>
							<td>{{ index + 1}}</td>
							<td>{{ row.qna_title }} &nbsp;
							<img v-if="row.file_nm !='' && row.file_nm != null"src="/images/treeview/file.gif">
							</td>
							<td>{{ row.enr_user }}</td>
							<td>{{ row.enr_date }}</td>
							<td>{{ row.qna_cnt }}</td>

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