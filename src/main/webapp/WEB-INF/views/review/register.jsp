<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<!-- Board Style Css-->
<link rel="stylesheet" href="/resources/review/css/register.style.css">

<!-- example -->

<section class="bg-image"
	style="background-image: url('/resources/member/photo/background2.jpg');">
	<div class="mask d-flex align-items-center gradient-custom-3">
		<div class="container backGround">
			<div class="register row d-flex justify-content-center align-items-center">
				<div class="card" style="border-radius: 15px;">
					<div class="card-body p-5">
						<h2 class="text-uppercase text-center mb-5">리뷰 작성</h2>

						<form action="/review/register" method="post"	enctype="multipart/form-data">
							<input type="hidden" name="sno" value="${rvo.sno }">
							<div class="form-outline">
								<div class="row">
									<div class="col-md-6 mb-4">
										<select class="form-select" id="rate" name="rate">
											<option value="총점">총점</option>
											<option value="1.0">1.0</option>
											<option value="1.5">1.5</option>
											<option value="2.0">2.0</option>
											<option value="2.5">2.5</option>
											<option value="3.0">3.0</option>
											<option value="3.5">3.5</option>
											<option value="4.0">4.0</option>
											<option value="4.5">4.5</option>
											<option value="5.0">5.0</option>
										</select>
									</div>
									<div class="col-md-6 mb-4">
										<div class="form-outline datepicker">
											<input type="text" class="form-control" id="writer"
												name="writer" value="${ses.nickName}" readOnly />
										</div>
									</div>
								</div>

								<div class="form-outline mb-4">
									<input type="text" class="form-control" name="title" name="title"
										placeholder="제목을 입력해주세요" />
								</div>
								<div class="form-outline mb-4">
									<textarea id="content" name="content" class="form-control"
										rows="17" cols="70" placeholder="내용을 입력해주세요"></textarea>
								</div>
								<div class="form-outline">
									<div class="row">
										<div class="col-md-2">
											<input type="file" class="form-control"
												style="display: none;" id="files" name="fileAttached"
												multiple>
											<div class="d-grid">
												<button type="button" id="attachTrigger"
													class="btn btn-block d-block btnPhoto" data-bs-toggle="tooltip" data-bs-placement="bottom" title="사진을 추가할 수 있어요">
													<i class="fa-regular fa-image fa-2x"></i>
												</button>
											</div>
										</div>
										<div class="col-md-10">
											<div class="d-flex justify-content-center">
											<c:choose>
											 <c:when test="${ses.email ne null && ses.email ne '' }">
												<button type="submit"
													class="btn btn-block btn-lg text-body sbmBtn" id="regBtn">올리기</button>
											 </c:when>
											<c:otherwise>		
												<button type="submit"
													class="btn btn-block btn-lg text-body sbmBtn disabled" id="regBtn">올리기</button>
											</c:otherwise>
											</c:choose>
											</div>
										</div>
									</div>
								</div>
								<div class="form-outline md-4">
									<div class="my-3" id="fileZone"></div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- // END Register Form // -->


<script>
	document.getElementById('attachTrigger').addEventListener('click', () => {
		document.getElementById('files').click();
	});
	// Initialize tooltips
	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
	  return new bootstrap.Tooltip(tooltipTriggerEl)
	});
</script>

<script src="/resources/js/review.register.js"></script>

<jsp:include page="../common/footer.jsp" />