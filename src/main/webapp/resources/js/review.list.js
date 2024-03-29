async function spread_review_sno(sno) {
    try {
        const resp = await fetch('/review/' + sno);
        const result = await resp.json();
        return await result;
    } catch (error) {
        console.log(error);
    }
}

async function member_img(email){
    try {
        const resp = await fetch('/member/' + email);
        const result = await resp.json();
        return await result;
    } catch (error) {
        console.log(error);
    }
}


function get_review_list() {

    let sno = document.getElementById('sno').value;
    let email = document.getElementById('email').value
    
    spread_review_sno(sno).then(result => {
        
        if (result != null) {
            for (const list of result) {
                member_img(list.rvo.writer).then(dto => {

                console.log(dto.fvo);
                let review_list = document.getElementById('review_list');
                let review_inner = '';
                review_inner += `<div class="customer-review_wrap">`;
                review_inner += `<div class="customer-img">`;
                
                var path = window.location.pathname
                
                let dir = dto.fvo.saveDir.toString();
                let saveDir = dir.replace("/\\/g",'/');
                review_inner +=`<img src="/upload/${saveDir}/${dto.fvo.uuid}_${dto.fvo.fileName}" class="img-fluid" style="width:70px; height:70px; margin: 18px 0 10px 5px;">`;
               
                review_inner += `<br>`;
                review_inner += `<p>${dto.mvo.nickName}</p>`;
                let rate = Math.floor(list.rvo.rate);
                console.log(rate);
                for (let i = 1; i <= 5; i++) {          
                    if(rate<2 && rate >= i){
                        review_inner += `<i class="fa-solid fa-star" id="rate_yes"></i>`;
                    } else if (rate<4 && rate >= i){
                        review_inner += `<i class="fa-solid fa-star" id="rate_yes"></i>`;
                    } else if (rate >=4 && rate >= i){
                        review_inner += `<i class="fa-solid fa-star" id="rate_yes"></i>`;
                    } else {
                        review_inner += `<i class="fa-solid fa-star" id="rate_none"></i>`;
                    }
                }
                review_inner += `</div>`;
                review_inner += `<div class="customer-content-wrap">`;
                review_inner += `<div class="customer-content">`;
                review_inner += `<div class="customer-review" style="width:80%;">`;
                if(list.rvo.title == null){
                    review_inner += `<h6>제목 없음</h6>`;
                    review_inner += `<br>`;
                } else {
                    review_inner += `<a style="inherited:no; border:0px;" href="/review/mydetail?rno=${list.rvo.rno}"><h6>${list.rvo.title}</h6></a>`;
                }
                
                
                review_inner += `<p class="modAt">${list.rvo.modAt}</p>`;
                review_inner += `</div>`;
                if (list.rvo.rate < 2) {
                    review_inner += `<div class="customer-rating bg-white text-center"><img src="../../../resources/mylist/photo/restaurant_not_recommend_active_face.png"  style=" display:block;"><br><p style="position: relative;right:4px;color:orange;">별로</p></div>`;
                    
                } else if (list.rvo.rate >= 2 || list.rvo.rate < 4) {
                    review_inner += `<div class="customer-rating bg-white text-center"><img src="../../../resources/mylist/photo/restaurant_ok_active_face.png"  style=" display:block;"><br><p style="position: relative;right:4px;color:orange;">괜찮다</p></div>`;
                } else {
                    review_inner += `<div class="customer-rating bg-white text-center"><img src="../../../resources/mylist/photo/restaurant_recommend_active_face.png"  style=" display:block;"><br><p style="position: relative;right:4px;color:orange;">맛있다</p></div>`;
                }
                review_inner += `</div>`;
                review_inner += `<p class="customer-text">${list.rvo.content}`;
                review_inner += `</p>`;
                review_inner += `<ul>`;
                if (list.fileList != null) {
                    for (const fvo of list.fileList) { 
                        let dir = fvo.saveDir.toString();
                        let saveDir = dir.replace("/\\/g",'/');
                        review_inner += `<li><img src="/upload/${saveDir}/${fvo.uuid}_${fvo.fileName}" class="img-fluid" alt="#" style="width:160px; height:120px; margin-top:-10px; border-radius:5px;"></li>`;

                    }

                }
                review_inner += `</ul>`;
                
                console.log(list.rvo.writer == email);
                console.log(list.rvo.writer);
                console.log(email);
                if(list.rvo.writer == email){
                    review_inner += `<form action = "/review/mymodify" method="get" style="display:inline-block;">`;
                    review_inner += `<input type="hidden" value="${list.rvo.rno}" name="rno">`;
                    review_inner += `<input type="hidden" value="${list.rvo.sno}" name="sno">`;
                    review_inner += `<button type="submit" class="btn btn-warning"><a id="report" style="border:0px;"><span class="icon-note"></span>리뷰 수정</a></button>`;
                    review_inner += `</form>`;
                    review_inner += `<form action = "/review/remove" method="post" style="display:inline-block;">`;
                    review_inner += `<input type="hidden" value="${list.rvo.rno}" name="rno">`;
                    review_inner += `<input type="hidden" value="${list.rvo.sno}" name="sno">`;
                    review_inner += `<button type="submit" class="btn btn-danger"><a id="report" style="border:0px;"><span class="icon-trash"></span>리뷰 삭제</a></button>`;
                    review_inner += `</form>`;
                    
                }
                if(email != ''){
                    
                    review_inner += `<form action = "/review/report" method="post" style="display:inline-block;">`;
                    review_inner += `<input type="hidden" value="${list.rvo.rno}" name="rno">`;
                    review_inner += `<input type="hidden" value="${list.rvo.sno}" name="sno">`;
                    review_inner += `<button type="submit" class="btn btn-outline-danger"><a id="report" style="border:0px;"><span class="icon-ban" ></span>신고하기</a></button>`;
                    review_inner += `</form>`;
                }
                review_inner += `</div>`;
                review_inner += ` </div>`;
                review_inner += `<hr>`;
                review_list.innerHTML += review_inner;
                })
            }
        }
    }
    );
}

