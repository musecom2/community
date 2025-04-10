<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gowun+Batang&family=Gowun+Dodum&family=IBM+Plex+Sans+KR&display=swap" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet" />
<link rel="stylesheet" href="res/css/bootstrap.min.css" />
<link rel="stylesheet" href="res/css/animate.min.css" />
<link rel="stylesheet" href="res/css/style.css" />
<script src="res/js/jquery.min.js"></script>
<script src="res/js/popper.min.js"></script>
<script src="res/js/bootstrap.min.js"></script>
</head>
<body>
   <tiles:insertAttribute name="header" />
   <div class="container">
      <div class="row">
         <div class="col-md-3 pt-md-5 pt-3"><tiles:insertAttribute name="aside" /></div>
         <div class="col-md-9 pt-md-5 pt-3"><tiles:insertAttribute name="body" /></div>   
      </div>
   </div>
   <tiles:insertAttribute name="footer" />
</body>
</html>