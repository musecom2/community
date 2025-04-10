<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <link rel="stylesheet" href="/community/res/css/skin/diary/evo-calendar.min.css">
    <link rel="stylesheet" href="/community/res/css/skin/diary/style.css">
    <script src="/community/res/js/skin/diary/evo-calendar.js"></script>
    <script>
        $(function () {

            myEvent = [
                {
                    id: "required-id-1",
                    name: "홍길동",
                    badge: "03/25 - 03/27",
                    date: ["March/25/2025", "March/27/2025"],
                    description: "나의 생일 시즌",
                    type: "event",
                    everyYear: false
                }
            ];

            $("#mydiary").evoCalendar({
                language: 'ko',
                format: 'yyyy/mm/dd',
                titleFormat: 'yyyy MM',
                eventHeaderFormat: 'yyyy, MM dd',
                calendarEvents: myEvent
            });
        });

    </script>
</head>


    <div class="container pt-5">
        <h1 class="text-center">다이어리</h1>
        <p class="text-center mb-5 pb-5">jsp + servlet으로 디자인 할 자유 게시판입니다.</p>
        <div class="text-right w-100 mb-4">
            <button type="button" class="btn btn-custom">일정등록</button>
        </div>
        <div id="mydiary"></div>
    </div>

