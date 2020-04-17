<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


   

<br>
<div  id="replyList" class="replyarea" style=" position:relative;background-color: gainsboro;
    height: 100%;width:100%">
	<div  style="width:100%; background-color: gainsboro">
	<!-- 	<template v-for="(row, index) in rlist" v-if="rlist.length" :style="styleobj(index)" > -->
				<div  @mouseover="activebackground=index"  
					 v-for="(row, index) in rlist" v-if="rlist.length" :style="styleobj(index)" >
					<div v-if="row.action ==='d'" style="color:gray;">
						<div v-if="row.rpy_lvl===0">
							<span  style="margin-left: 20px;  margin-top: 2px; "> {{row.enr_user}} : </span>
							<span  >{{ row.rpy_contents}}</span>
						</div>
						<div v-else >
							<span style="margin-left: 40px;  margin-top: 2px; ">@{{row.enr_user}} : </span>
							<span >     {{ row.rpy_contents}}</span>
						</div>
					</div>
					<div v-else   >
						<div v-if=" row.rpy_lvl===0">
							<span  @click="addreplytag(row)" style="margin-left: 20px;  margin-top: 2px; "> {{row.enr_user}} : </span>
							<span @click="createDelete(row)" >{{ row.rpy_contents}}</span>
						</div>
						<div v-else >
							<span style="margin-left: 40px;  margin-top: 2px; ">@{{row.enr_user}} : </span>
							<span @click="createDelete(row)">     {{ row.rpy_contents}}</span>
						</div>
					</div>
				</div>
	<!-- 	</template> -->
	</div>
	<br>
	<hr style="margin-bottom: 20px;">
	<br>
	<span style="position:absolute;bottom:10px;left:2px;"> ${sessionScope.loginId} : </span>
	<input type="text" @keyup.enter="insertReply" v-model="replyContent" id="replyContent"
			style="width: 82%; height: 30px; position:absolute;bottom:3px;left:70px">
	<a class="btnType blue" @click="insertReply" name="replygo"id="replygo" 
		style="position:absolute;bottom:3px;right:0px;">
	<span>등록</span></a>
	
</div>

   