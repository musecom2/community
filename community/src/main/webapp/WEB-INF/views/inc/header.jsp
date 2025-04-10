<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<header>
   <nav class="navbar navbar-expand-md bg-dark navbar-dark py-md-3">
      <!-- 로고 -->
      <a class="navbar-brand ml-md-5" href="/community">Community</a>
      
      <!-- 모바일용 버튼 -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu">
          <i class="ri-menu-line"></i>
      </button>
      
      <div class="collapse navbar-collapse justify-content-between ml-md-5" id="menu">
         <ul class="navbar-nav">
            <li class="nav-item ml-md-3">
               <a class="nav-link" href="#">공지사항</a>
            </li>
            <li class="nav-item ml-md-3">
               <a class="nav-link" href="#">인기글</a>
            </li>
            <sec:authorize access="!isAuthenticated()">
            <li class="nav-item ml-md-3">
               <a class="nav-link" href="/community/register">회원가입</a>
            </li>
            </sec:authorize>
         </ul>
         <form class="d-flex mr-md-5">
            <input class="form-control mr-2 col-8" type="search" 
                   placeholder="search" aria-label="Search">
            <button class="btn btn-outline-success col-4" type="submit">검색</button>
         </form>
      </div>
   </nav>
</header>


