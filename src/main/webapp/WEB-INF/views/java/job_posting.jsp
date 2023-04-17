<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<header>
    <div class="page-header min-vh-50" style="background-image: url('https://images.unsplash.com/photo-1501446529957-6226bd447c46?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&amp;ixlib=rb-1.2.1&amp;auto=format&amp;fit=crop&amp;w=2378&amp;q=80');" loading="lazy">
      <span class="mask bg-gradient-dark opacity-4"></span>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto text-white text-center">
          
          <!-- 광고 슬라이드 예정 -->
           <div class="slide slide_wrap">
			    <div class="slide_item" style="left: -1005px">5</div><div class="slide_item" style="left: -1005px">1</div>
			    <div class="slide_item" style="left: -1005px">3</div>
			    <div class="slide_item" style="left: -1005px">4</div>
			    <div class="slide_item" style="left: -1005px">5</div><div class="slide_item" style="left: -1005px">1</div>
			    <div class="slide_prev_button slide_button">◀</div>
			    <div class="slide_next_button slide_button">▶</div>
			    <ul class="slide_pagination"><li class="active">•</li><li>•</li><li>•</li><li>•</li></ul>
			  </div>
          </div>
        </div>
      </div>
    </div>
  </header>

<!-- 메인 시작-->
<main class="job_posting_main">

	<div class="card card-body blur shadow-blur mx-3 mx-md-4 mt-n6 overflow-hidden">
    <div class="container">
      <div class="row border-radius-md pb-4 p-3 mx-sm-0 mx-1 position-relative">
        <div class="col-lg-3 mt-lg-n2 mt-2">
          <label class="ms-0">Leave From</label>
          <div class="choices" data-type="select-one" tabindex="0" role="listbox" aria-haspopup="true" aria-expanded="false"><div class="choices__inner"><select class="form-control choices__input" name="choices-button" id="choices-button" hidden="" tabindex="-1" data-choice="active"><option value="Choice 1">Brazil</option></select><div class="choices__list choices__list--single"><div class="choices__item choices__item--selectable" data-item="" data-id="1" data-value="Choice 1" data-custom-properties="null" aria-selected="true">Brazil</div></div></div><div class="choices__list choices__list--dropdown" aria-expanded="false"><div class="choices__list" role="listbox"><div id="choices--choices-button-item-choice-1" class="choices__item choices__item--choice is-selected choices__item--selectable is-highlighted" role="option" data-choice="" data-id="1" data-value="Choice 1" data-select-text="Press to select" data-choice-selectable="" aria-selected="true">Brazil</div><div id="choices--choices-button-item-choice-2" class="choices__item choices__item--choice choices__item--selectable" role="option" data-choice="" data-id="2" data-value="Choice 2" data-select-text="Press to select" data-choice-selectable="">Bucharest</div><div id="choices--choices-button-item-choice-3" class="choices__item choices__item--choice choices__item--selectable" role="option" data-choice="" data-id="3" data-value="Choice 3" data-select-text="Press to select" data-choice-selectable="">London</div><div id="choices--choices-button-item-choice-4" class="choices__item choices__item--choice choices__item--selectable" role="option" data-choice="" data-id="4" data-value="Choice 4" data-select-text="Press to select" data-choice-selectable="">USA</div></div></div></div>
        </div>
        <div class="col-lg-3 mt-lg-n2 mt-2">
          <label class="ms-0">To</label>
          <div class="choices" data-type="select-one" tabindex="0" role="listbox" aria-haspopup="true" aria-expanded="false"><div class="choices__inner"><select class="form-control choices__input" name="choices-remove-button" id="choices-remove-button" hidden="" tabindex="-1" data-choice="active"><option value="Choice 1">Italy</option></select><div class="choices__list choices__list--single"><div class="choices__item choices__item--selectable" data-item="" data-id="1" data-value="Choice 1" data-custom-properties="null" aria-selected="true">Italy</div></div></div><div class="choices__list choices__list--dropdown" aria-expanded="false"><div class="choices__list" role="listbox"><div id="choices--choices-remove-button-item-choice-1" class="choices__item choices__item--choice choices__item--selectable is-highlighted" role="option" data-choice="" data-id="1" data-value="Choice 3" data-select-text="Press to select" data-choice-selectable="" aria-selected="true">Denmark</div><div id="choices--choices-remove-button-item-choice-2" class="choices__item choices__item--choice is-selected choices__item--selectable" role="option" data-choice="" data-id="2" data-value="Choice 1" data-select-text="Press to select" data-choice-selectable="">Italy</div><div id="choices--choices-remove-button-item-choice-3" class="choices__item choices__item--choice choices__item--selectable" role="option" data-choice="" data-id="3" data-value="Choice 4" data-select-text="Press to select" data-choice-selectable="">Poland</div><div id="choices--choices-remove-button-item-choice-4" class="choices__item choices__item--choice choices__item--selectable" role="option" data-choice="" data-id="4" data-value="Choice 2" data-select-text="Press to select" data-choice-selectable="">Spain</div></div></div></div>
        </div>
        <div class="col-lg-3 mt-lg-n2 mt-2">
          <label class="ms-0">Depart</label>
          <div class="input-group input-group-static">
            <span class="input-group-text"><i class="fas fa-calendar" aria-hidden="true"></i></span>
            <input class="form-control datepicker flatpickr-input" placeholder="Please select date" type="text" readonly="readonly">
          </div>
        </div>
        <div class="col-lg-3 mt-lg-n2 mt-2">
          <label>&nbsp;</label>
          <button type="button" class="btn bg-gradient-primary w-100 mb-0">Search</button>
        </div>
      </div>
    </div> 
    <section class="pt-7 pb-0">
      <div class="container">
        <div class="row">
          <div class="col-lg-4 col-md-6">
            <div class="card mt-5 mt-md-0">
              <div class="card-header p-0 mx-3 mt-n4 position-relative z-index-2">
                <a class="d-block blur-shadow-image">
                  <img src="/resources/images/kakao.jpg" alt="img-blur-shadow" class="img-fluid border-radius-lg" loading="lazy">
                </a>
              <div class="colored-shadow" style="background-image: url(&quot;/resources/images/kakao.jpg&quot;);"></div></div>
              <div class="card-body pt-3">
                <p class="text-dark mb-2 text-sm">2023-02-27 ~ 2023-04-13</p>
                <a href="javascript:;">
                  <h5>
                    카카오
                  </h5>
                </a>
                <p>
                  카카오에 가실분 java 2명 구합니다
                </p>
                <button type="button" class="btn btn-outline-primary btn-sm mb-0">From / Night</button>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="card mt-5 mt-md-0">
              <div class="card-header p-0 mx-3 mt-n4 position-relative z-index-2">
                <a class="d-block blur-shadow-image">
                  <img src="/resources/images/naver.png" alt="img-blur-shadow" class="img-fluid border-radius-lg" loading="lazy">
                </a>
              <div class="colored-shadow" style="background-image: url(&quot;/resources/images/naver.png&quot;);"></div></div>
              <div class="card-body pt-3">
                <p class="text-dark mb-2 text-sm">2023-02-27 ~ 2023-04-13</p>
                <a href="javascript:;">
                  <h5>
                    네이버
                  </h5>
                </a>
                <p>
                 네이버 구합니다
                </p>
                <button type="button" class="btn btn-outline-primary btn-sm mb-0">From / Night</button>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="card mt-5 mt-lg-0">
              <div class="card-header p-0 mx-3 mt-n4 position-relative z-index-2">
                <a class="d-block blur-shadow-image">
                  <img src="/resources/images/toss.jpg" alt="img-blur-shadow" class="img-fluid border-radius-lg" loading="lazy">
                </a>
              <div class="colored-shadow" style="background-image: url(&quot;/resources/images/toss.jpg&quot;);"></div></div>
              <div class="card-body pt-3">
                <p class="text-dark mb-2 text-sm">2023-02-27 ~ 2023-04-13</p>
                <a href="javascript:;">
                  <h5>
                   토스
                  </h5>
                </a>
                <p>
                  프로토스 말고 toss 구합니다
                </p>
                <button type="button" class="btn btn-outline-primary btn-sm mb-0">From / Night</button>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="card mt-5">
              <div class="card-header p-0 mx-3 mt-n4 position-relative z-index-2">
                <a class="d-block blur-shadow-image">
                  <img src="/resources/images/daangn.png" alt="img-blur-shadow" class="img-fluid border-radius-lg" loading="lazy">
                </a>
              <div class="colored-shadow" style="background-image: url(&quot;/resources/images/daangn.png&quot;);"></div></div>
              <div class="card-body pt-3">
                <p class="text-dark mb-2 text-sm">2023-02-27 ~ 2023-04-13</p>
                <a href="javascript:;">
                  <h5>
                    당근마켓
                  </h5>
                </a>
                <p>
                당근 구합니다
                </p>
                <button type="button" class="btn btn-outline-primary btn-sm mb-0">From / Night</button>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="card mt-5">
              <div class="card-header p-0 mx-3 mt-n4 position-relative z-index-2">
                <a class="d-block blur-shadow-image">
                  <img src="/resources/images/hyundai.jpg" alt="img-blur-shadow" class="img-fluid border-radius-lg" loading="lazy">
                </a>
              <div class="colored-shadow" style="background-image: url(&quot;/resources/images/hyundai.jpg&quot;);"></div></div>
              <div class="card-body pt-3">
                <p class="text-dark mb-2 text-sm">2023-02-27 ~ 2023-04-13</p>
                <a href="javascript:;">
                  <h5>
                    현대
                  </h5>
                </a>
                <p>
                  현대 가실분
                </p>
                <button type="button" class="btn btn-outline-primary btn-sm mb-0">From / Night</button>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="card mt-5">
              <div class="card-header p-0 mx-3 mt-n4 position-relative z-index-2">
                <a class="d-block blur-shadow-image">
                  <img src="/resources/images/Samsung.png" alt="img-blur-shadow" class="img-fluid border-radius-lg" loading="lazy">
                </a>
              <div class="colored-shadow" style="background-image: url(&quot;/resources/images/Samsung.png&quot;);"></div></div>
              <div class="card-body pt-3">
                <p class="text-dark mb-2 text-sm">2023-02-27 ~ 2023-04-13</p>
                <a href="javascript:;">
                  <h5>
                    삼성 
                  </h5>
                </a>
                <p>
                 삼성 가실분
                </p>
                <button type="button" class="btn btn-outline-primary btn-sm mb-0">From / Night</button>
              </div>
            </div>
          </div>
          <div class="col-sm-7 ms-auto text-end">
            <ul class="pagination pagination-primary mt-4">
              <li class="page-item ms-auto">
                <a class="page-link" href="javascript:;" aria-label="Previous">
                  <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                </a>
              </li>
              <li class="page-item active">
                <a class="page-link" href="javascript:;">1</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="javascript:;">2</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="javascript:;">3</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="javascript:;">4</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="javascript:;">5</a>
              </li>
              <li class="page-item">
                <a class="page-link" href="javascript:;" aria-label="Next">
                  <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>



  </div>

</main>

  <!-- 메인 끝-->