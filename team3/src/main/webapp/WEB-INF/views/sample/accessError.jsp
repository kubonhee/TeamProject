<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>2021. 4. 20.오후 12:14:05</title>
</head>
<body>
	<h1>Access Denied Page</h1>
	<%-- <h2>${SPRING_SECURITY_403_EXCEPTION.getMessage()}</h2> --%>
	<h2>${msg}</h2>
</body>
</html>