<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html; charset=utf8"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>ホーム｜シアトルライブラリ｜シアトルコンサルティング株式会社</title>
<link href="<c:url value="/resources/css/reset.css" />" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+JP" rel="stylesheet">
<link href="<c:url value="/resources/css/default.css" />" rel="stylesheet" type="text/css">
<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
<link href="<c:url value="/resources/css/home.css" />" rel="stylesheet" type="text/css">
</head>
<body class="wrapper">
    <header>
        <div class="left">
            <img class="mark" src="resources/img/logo.png" />
            <div class="logo">Seattle Library</div>
        </div>
        <div class="right">
            <ul>
                <li><a href="<%=request.getContextPath()%>/home" class="menu">Home</a></li>
                <li><a href="<%=request.getContextPath()%>/">ログアウト</a></li>
            </ul>
        </div>
    </header>
    <main>
        <h1>Home</h1>
        <form action="search" method="get">
            <input type="search" name="search" placeholder="キーワードを入力">
            <button class="button-002">🔍検索</button>
        </form>
        <form action="tagsearch" method="get">
            <div class="bsn">
                <div class="misaki">
                    <div>
                        <label class="selectbox-002"> <select name="tagsearch" value="${bookInfo.tag}">
                                <option value="ーー">ーー</option>
                                <option value="漫画">漫画</option>
                                <option value="小説">小説</option>
                                <option value="雑誌">雑誌</option>
                                <option value="辞典">辞典</option>
                                <option value="絵本">絵本</option>
                        </select>
                        </label>
                    </div>
                    <div class="ruka">
                        <button class="button-043">表示</button>
                    </div>
                </div>
        </form>
        <form action="search_order" method="get">
            <div class="oimo">
                <div class="nasu">
                    <div class="jo">
                        <label class="selectbox-002"> <select name="search_order" value="${bookInfo.bookId}">
                                <option value="orderASC">昇順</option>
                                <option value="orderDESC">降順</option>
                                <option value="book_author">著者名</option>
                                <option value="book_publish_date">出版日</option>
                        </select>
                        </label>
                    </div>
                </div>
                <div class="naga">
                    <button class="button-043">並び替え</button>
                </div>
            </div>
        </form>
        </div>
        <div class="ran">
            <a href="<%=request.getContextPath()%>/addBook" class="btn_add_book">書籍の追加</a> <a href="<%=request.getContextPath()%>/favorite" class="btn_fav_book">お気に入り</a> <a href="<%=request.getContextPath()%>/library" class="btn_lib_book">所蔵図書</a>
        </div>
        <div class="content_body">
            <c:if test="${!empty resultMessage}">
                <div class="error_msg">${resultMessage}</div>
            </c:if>
            <div>
                <div class="booklist">
                    <c:forEach var="bookInfo" items="${bookList}">
                        <div class="books">
                            <form method="get" class="book_thumnail" action="editBook">
                                <a href="javascript:void(0)" onclick="this.parentNode.submit();"> <c:if test="${empty bookInfo.thumbnail}">
                                        <img class="book_noimg" src="resources/img/noImg.png">
                                    </c:if> <c:if test="${!empty bookInfo.thumbnail}">
                                        <img class="book_noimg" src="${bookInfo.thumbnail}">
                                    </c:if>
                                </a> <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                            </form>
                            <ul>
                                <li class="book_title">${bookInfo.title}</li>
                                <li class="book_author">${bookInfo.author}(著)</li>
                                <li class="book_publisher">出版社：${bookInfo.publisher}</li>
                                <li class="book_publish_date">出版日：${bookInfo.publishDate}</li>
                                <li class="book_tag">ジャンル：${bookInfo.tag}</li>
                                <div>
                                    <c:if test="${!(bookInfo.favorite.equals('like'))}">
                                        <form method="get" action="fav" name="favorite">
                                            <p align="justify">
                                                <button class="button-049">♡</button>
                                                <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                            </p>
                                        </form>
                                    </c:if>
                                    <c:if test="${bookInfo.favorite == 'like'}">
                                        <form method="get" action="notfav" name="nofavorite">
                                            <p align="justify">
                                                <button class="button-049">お気に入り登録済み</button>
                                                <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                            </p>
                                        </form>
                                    </c:if>
                                    <%--  <c:if test="${!(bookInfo.favorite.equals('lending'))}">
                                        <form method="get" action="fav" name="lending">
                                            <p align="justify">
                                                <button class="button-049">♡</button>
                                                <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                            </p>
                                        </form>
                                    </c:if>
                                    <c:if test="${bookInfo.favorite == 'lending'}">
                                        <form method="get" action="notfav" name="nofavorite">
                                            <p align="justify">
                                                <button class="button-049">お気に入り登録済み</button>
                                                <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                            </p>
                                            </form>
                                    </c:if> --%>
                                    <c:if test="${bookInfo.library != 'lend'}">
                                        <p>
                                            <input type="radio" name="site${bookInfo.bookId}" value="stock" onchange="radio_func(this.value,${bookInfo.bookId})" checked>在庫あり <input type="radio" name="site${bookInfo.bookId}" value="lend" onchange="radio_func(this.value,${bookInfo.bookId})">貸し出し中
                                        </p>
                                    </c:if>
                                    <c:if test="${bookInfo.library == 'lend'}">
                                        <p>
                                            <input type="radio" name="site${bookInfo.bookId}" value="stock" onchange="radio_func(this.value,${bookInfo.bookId})">在庫あり <input type="radio" name="site${bookInfo.bookId}" value="lend" onchange="radio_func(this.value,${bookInfo.bookId})" checked>貸し出し中
                                        </p>
                                    </c:if>
                                    <script>
                                function radio_func(check,id) {
                                    var library = new XMLHttpRequest();
                                      library.open('POST',"http://localhost:8080/SeattleLibrary/stock?value="+check+"&bookId="+id+"");
                                       library.send();
                               }
                                </script>
                                </div>
                                <%-- <form method="get" class="btn" action="favorite">
                                    <input type="hidden" name="bookId" value="${bookInfo.bookId}">
                                    <button type="submit" class="btn">💟</button>
                                </form> --%>
                            </ul>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>
</body>
</html>