 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <link rel="stylesheet" href="/community/res/css/skin/gallery/style.css">
    <script src="/community/res/js/skin/gallery/script.js" defer></script>
    <div class="container pt-5">
        <h1 class="text-center">갤러리</h1>
        <p class="text-center mb-5 pb-5">jsp + servlet으로 디자인 할 자유 게시판입니다.</p>

        <!-- design list -->
        <div class="search-box">
            <form name="search-form" method="get" class="d-flex justify-content-center">
                <div class="select-box">
                    <div class="selected">--검색선택-- <i class="ri-arrow-down-s-line"></i> </div>
                    <ul class="options">
                        <li data-value="author">이름검색</li>
                        <li data-value="title">제목검색</li>
                        <li data-value="content">내용검색</li>
                    </ul>
                </div>
                <input type="search" class="search-input" placeholder="검색...">
                <input type="hidden" id="option" name="option">
                <button type="submit" class="btn-search">검색</button>
                <button type="reset" class="btn-search" id="reset">초기화</button>
            </form>
        </div>
        <div class="d-flex justify-content-between pb-2">
            <div class="init-text d-flex">
                <div class="all-text"><i class="ri-file-list-line"></i> 총 글수<span>123</span>건</div>
                <div class="now-text">현재 페이지<span>1/12</span></div>
            </div>
            <div class="sortting">
                <span>페이지당 목록</span>
                <select class="list-ct">
                    <option value="12">12</option>
                    <option value="16">16</option>
                    <option value="20">20</option>
                </select>
            </div>
        </div>

        <div class="row mt-4">
            <!--루프-->
            <div class="col-md-3 mb-4">
                <a href="#" class="gimg">
                    <p class="gtitle">제목입니다.</p>
                </a>
            </div>
            <!--루프-->
        </div>

        <div class="d-flex justify-content-end mt-4">
            <a href="write.html" class="btn">글쓰기</a>
        </div>
        <ul class="paging">
            <li><a href="#" class="first"><i class="ri-arrow-left-double-line"></i></a></li>
            <li><a href="#" class="prev"><i class="ri-arrow-left-s-line"></i></a></li>
            <li><a href="#" class="act">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">5</a></li>
            <li><a href="#" class="next"><i class="ri-arrow-right-s-line"></i></a></li>
            <li><a href="#" class="last"><i class="ri-arrow-right-double-line"></i></a></li>
        </ul>
        <!-- / design list-->
    </div>

