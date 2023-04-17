<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!-- 메인 시작-->
<main>
	<div class="col-lg-4 col-md-8 col-12 mx-auto">
		<div class="card z-index-0 fadeIn3 fadeInBottom">
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
				<div
					class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
					<h4 class="text-white font-weight-bolder text-center mt-2 mb-0">Sign
						in</h4>
					<div class="row mt-3">
						<div class="col-2 text-center ms-auto">
							<a class="btn btn-link px-3" href="javascript:;"> <i
								class="fa fa-facebook text-white text-lg" aria-hidden="true"></i>
							</a>
						</div>
						<div class="col-2 text-center px-1">
							<a class="btn btn-link px-3" href="javascript:;"> <i
								class="fa fa-github text-white text-lg" aria-hidden="true"></i>
							</a>
						</div>
						<div class="col-2 text-center me-auto">
							<a class="btn btn-link px-3" href="javascript:;"> <i
								class="fa fa-google text-white text-lg" aria-hidden="true"></i>
							</a>
						</div>
					</div>
				</div>
			</div>
			<div class="card-body">
				<form role="form" class="text-start">
					<div class="input-group input-group-outline my-3">
						<label class="form-label">Email</label> <input type="email"
							class="form-control">
					</div>
					<div class="input-group input-group-outline mb-3">
						<label class="form-label">Password</label> <input type="password"
							class="form-control">
					</div>
					<div
						class="form-check form-switch d-flex align-items-center mb-3 is-filled">
						<input class="form-check-input" type="checkbox" id="rememberMe"
							checked=""> <label class="form-check-label mb-0 ms-3"
							for="rememberMe">Remember me</label>
					</div>
					<div class="text-center">
						<button type="button"
							class="btn bg-gradient-primary w-100 my-4 mb-2">Sign in</button>
					</div>
					<p class="mt-4 text-sm text-center">Don't have an account?</p>
				</form>
			</div>
		</div>
	</div>
</main>

<!-- 메인 끝-->