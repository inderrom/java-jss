<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	let width = 1100;
	let height = 800;

	let left = Math.ceil((window.screen.width - width) / 2);
	let top = Math.ceil((window.screen.height - height) / 2);

	window.open('/myPremium/lecturePlay', '강의 재생', 'width=' + width
			+ ',height=' + height + ',left=' + left + ',top=' + top
			+ ',scrollbars=yes');
</script>

<style>
.videoPlay{
	width:100%;
	max-width:100%;
	height:auto;
}
</style>

<div>
	<p><b>${data.lctTitle }</b></p>
</div>
<div class="row">
	<div class="col-md-9 m-5 videoPlay">
				<video src="${attPath}" width="800" height="450" controls></video>
		
		<iframe width="900" height="500"
			src="https://www.youtube.com/embed/lk5-r0Dgs9s"
			title="YouTube video player" frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
			allowfullscreen></iframe>
	</div>

	<div class="col-md-3 m-5"></div>
</div>



${data}
