<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/nav.jsp"/>
<!-- list Style CSS-->
<link rel="stylesheet" href="/resources/store/css/list.style.css">


<!-- TOP button -->
 <link href="/resources/mylist/css/topbutton.css" rel="stylesheet"> 
 <script src="/resources/mylist/js/topbutton.js"></script> 
	<img id="movetopbtn" 
	src='/resources/board/photo/top.png'
	href="#" >


	<!-- today  -->
	<c:set var="now" value="<%=new java.util.Date() %>"></c:set>
<fmt:formatDate value="${now}" pattern="E" var="today" />
	<c:set var="now_today" value="${today }요일"></c:set>
	

	<!-- //today  -->
	
    <div id="search" style="margin-top:-50px;"></div>
    <section class="slider d-flex align-items-center" style="background-image: url('/resources/common/photo/background2.jpg');">

    <div class="container" >
   <div class="row d-flex justify-content-center"role="group">
   <div class="col-md-10">
   		<form class="form-wrap mt-4" action="/store/list" method="get">
			<input type="hidden" name="pageNo" value="${pgn.pgvo.pageNo }">
			<input type="hidden" name="qty" value="9">
				<div class="input-group">
				<c:set value="${pgn.pgvo.type }" var="typed"/>
					<select class="form-select optionStart" name="type">
						<option value="nl" ${typed eq null ? 'selected' : '' }>전체 검색</option>
						<option value="n" ${typed eq 'n' ? 'selected' : '' }>식당 이름</option>
						<option value="l" ${typed eq 'l' ? 'selected' : '' }>지역</option>
					</select>
					<input class="form-control me-2" type="search" id="store_start"
						placeholder="지역, 식당 또는 음식을 검색해보세요" aria-label="Search" name="kw" value="${pgn.pgvo.kw }">
					<button class="btn-form searchBtn" type="submit">
						<span class="search-icon" style="letter-spacing: 0.8rem; font-size: 20px;"> 검색</span><i class="pe-7s-angle-right"></i> 
					</button>
				</div>
			</form>	
			</div>
   </div>
   </div>
   </section>
   <section class="main-one light-bg">
        <div class="container">
            <div class="row">
                    <div class="headingTitle mb-4">
                        <h4>믿고 보는 맛집 리스트</h4>
                    </div>
            </div>
            <div class="row" id="list_zone">
            <c:choose>
            	<c:when test="${list ne null }">
            	
            	<c:if test="${pgn.totalCount eq 0 }">
            		<div class="row justify-content-center">
            		
            		<h3 class="text-dark text-center ">검색 결과가 없습니다.</h3>
            		<c:choose>
            <c:when test="${ses.email ne null && ses.email ne '' }">
            <div class="justify-content-center">
                <div class="col-md-4">
                    <div class="featured-btn-wrap">
                        <a href="/store/myregister" class="btn btn-danger"><span class="ti-plus"></span>맛집등록</a>
                    </div>
                </div>
            </div>
            </c:when>
            <c:otherwise>
            	<div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="featured-btn-wrap">
                        <a href="/store/myregister" class="btn btn-danger disabled"><span class="ti-plus"></span>맛집등록</a>
                    </div>
                </div>
            </div>
            </c:otherwise>
            </c:choose>
            		</div>
            	</c:if>
            <c:forEach items="${list }" var ="list">
            <%-- <c:if test="${list.svo.approve ne 0  }"> --%>
                <div class="col-md-4 featured-responsive">
                    <div class="featured-contents-wrap">
                        <a href="/store/detail?sno=${list.svo.sno }">
                        <c:choose>
                        	<c:when test="${list.fileList[0].saveDir ne null }">
                        	<c:forEach items="${list.fileList }" var="fvo">
                  
                            	<img src="/upload/${fn:replace(fvo.saveDir, '\\','/')}/${fvo.uuid}_${fvo.fileName}" class="img-fluid">
                            
                        	</c:forEach>
                        		
                        	</c:when>
                        	<c:otherwise>
                        			<img src="../../resources/mylist/photo/사진없음.png" class="img-fluid" style="height:300px">
                        	</c:otherwise>
                        </c:choose>
                            <div class="featured-title-section">
                            	<div class="titleSec">
                                <fmt:parseNumber var="rate" value="${list.svo.rateAvg }" integerOnly="true"/>
                                <c:choose>
                                	<c:when test="${rate == 0 }">
                                		<p><span style="margin-bottom:0;">$$$$$</span></p>
                                	</c:when>
                                	<c:when test="${rate == 1 }">
                                		<p><span style="color: #ffbf00; margin-bottom:0;">$</span>$$$$</p>
                                	</c:when>
                                	<c:when test="${rate == 2 }">
                                		<p><span style="color: #ffbf00; margin-bottom:0;">$$</span>$$$</p>
                                	</c:when>
                                	<c:when test="${rate == 3 }">
                                		<p><span style="color: #ffbf00; margin-bottom:0;">$$$</span>$$</p>
                                	</c:when>
                                	<c:when test="${rate == 4 }">
                                		<p><span style="color: #ffbf00; margin-bottom:0;">$$$$</span>$</p>
                                	</c:when>
                                	<c:when test="${rate == 5 }">
                                		<p><span style="color: #ffbf00; margin-bottom:0;">$$$$$</span></p>
                                	</c:when>
                                </c:choose>
                                <h6>${list.svo.sname }</h6>
	                            <c:choose>
	                            	<c:when test="${list.svo.rateAvg <= 2.0 }">
	                            		<span class="ratingNum">${Math.round(list.svo.rateAvg*10)/10.0 }</span>	
	                            	</c:when>
	                            	<c:when test="${list.svo.rateAvg > 2.0 && list.svo.rateAvg < 4.0}">
	                            		<span class="ratingNum_gre">${Math.round(list.svo.rateAvg*10)/10.0 }</span>
	                            	</c:when>
	                            	<c:when test="${list.svo.rateAvg >= 4.0}">
	                            		<span class="ratingNum_ora">${Math.round(list.svo.rateAvg*10)/10.0 }</span>
	                            	</c:when>
	                            </c:choose>
                                <span class="categ"> - ${list.svo.category } </span>
	                            </div>
                                <ul>
                                    <li class="store_list_locate">
                                    <div>
                                        <p style="overflow: hidden;text-overflow: ellipsis;">${list.svo.locate }</p></div>
                                    </li>
                                </ul>
                            </div>
                        </a>
                    </div>
                </div>
                
                </c:forEach>
                
            <%-- </c:if> --%>
            </c:when>
            
            <c:otherwise>
            	<h2 class="text-center">게시글이 없습니다 내용을 추가해주세요</h2>
            <c:choose>
            <c:when test="${ses.email ne null && ses.email ne '' }">
            <div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="featured-btn-wrap">
                        <a href="/store/myregister" class="btn btn-danger"><span class="ti-plus"></span> New Store</a>
                    </div>
                </div>
            </div>
            </c:when>
            <c:otherwise>
            	<div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="featured-btn-wrap">
                        <a href="/store/myregister" class="btn btn-danger disabled"><span class="ti-plus"></span> New Store</a>
                    </div>
                </div>
            </div>
            </c:otherwise>
            </c:choose>
            </c:otherwise>
        </c:choose> 
            
            
        </div>
        </div>
        
        <c:if test="${pgn.totalCount > 0 && pgn.totalCount > 10}">
        
        <div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="featured-btn-wrap" id="store_end">
                        <a href="/store/list?pageNo=${pgn.startPage }&qty=${pgn.pgvo.qty+9}&kw=${pgn.pgvo.kw}" class="btn btn-danger" id="view_all">더보기 &nbsp;<i class="fa-solid fa-chevron-down"></i></a>
                    </div>
                </div>
            </div>
            </c:if>
    </section>
   

<!--// SLIDER -->


<!-- <script src="/resources/js/store.list.js"></script> 만들고나니 쓸 때가 없네  -->
<jsp:include page="../common/footer.jsp"/>
