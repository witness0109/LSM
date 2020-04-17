<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
var parent = opener;

$(document).ready(function() {
	var fileNm = parent.$("#fileNm").val();
	$("#imgBox").attr({"src":"/images/mpm/"+fileNm});
})
</script>
<body>
<div>
<img alt="" id="imgBox" style="width: 100%; height: 100%;">
</div>
</body>
</html>