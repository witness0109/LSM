<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<table id="vueListtable" class="col2 mb10" style="width: 100%;">
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
