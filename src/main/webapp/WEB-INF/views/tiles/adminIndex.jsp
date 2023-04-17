<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>잡아줄게 관리자 페이지</title>

<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
<!-- Naver Font: NanumSquareNeo -->
<link href="https://webfontworld.github.io/NanumSquareNeo/NanumSquareNeo.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="/resources/adminlte3/plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Tempusdominus Bootstrap 4 -->
<link rel="stylesheet" href="/resources/adminlte3/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="/resources/adminlte3/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- JQVMap -->
<link rel="stylesheet" href="/resources/adminlte3/plugins/jqvmap/jqvmap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/resources/adminlte3/dist/css/adminlte.min.css">
<!-- overlayScrollbars -->
<link rel="stylesheet" href="/resources/adminlte3/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Material Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">

<!-- 나눔 폰트 -->
<!-- <link rel="stylesheet" type="text/css"	href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@2.0/nanumsquare.css"> -->
<!-- <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet"> -->
<!-- <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-gothic.css" rel="stylesheet"> -->
<!-- <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet"> -->


  <link rel="stylesheet" href="/resources/adminlte3/plugins/daterangepicker/daterangepicker.css">
  <!-- summernote -->
  <link rel="stylesheet" href="/resources/adminlte3/plugins/summernote/summernote-bs4.min.css">

<!-- DataTables -->
<link rel="stylesheet" href="/resources/adminlte3/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="/resources/adminlte3/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<link rel="stylesheet" href="/resources/adminlte3/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

<link rel="stylesheet" type="text/css" href="/resources/css/java/JAVA_font.css">
<!-- 채용공고 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/jobPosting/jobPosting.css">
<!-- 채용공고 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/jobPosting/jobPostingDetail.css">

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<style>
p{
	font-size: smaller;
}
* {
	font-family: 'NanumSquareNeo';
}
.material-icons {
  font-family: 'Material Icons Round';
  font-weight: normal;
  font-style: normal;
  font-size: 20px;
  /* Preferred icon size */
  display: inline-block;
  line-height: 1;
  text-transform: none;
  letter-spacing: normal;
  word-wrap: normal;
  white-space: nowrap;
  direction: ltr;
  /* Support for all WebKit browsers. */
  -webkit-font-smoothing: antialiased;
  /* Support for Safari and Chrome. */
  text-rendering: optimizeLegibility;
  /* Support for Firefox. */
  -moz-osx-font-smoothing: grayscale;
  /* Support for IE. */
  font-feature-settings: 'liga';
}
</style>
<div class="wrapper">
  <!-- ---------------- Navbar header.jsp 시작 ---------------- -->
  <tiles:insertAttribute name="adminHeader" />
  <!-- ---------------- /.navbar header.jsp 끝----------------  -->

  <!-- Main Sidebar Container aside.jsp 시작 -->
  <tiles:insertAttribute name="adminAside" />
  <!-- Main Sidebar Container aside.jsp 끝 -->


  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid" style="background-color: linear-gradient(270deg, rgba(155,122,210,1) 0%, rgba(181,255,240,1) 100%);">
        <!-- -------------------- body 시작 -------------------- -->
        <tiles:insertAttribute name="adminBody" />
        <!-- -------------------- body 끝 -------------------- -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- --------------  footer.jsp 시작 ----------------------- -->
  <tiles:insertAttribute name="adminFooter" />
  <!-- --------------  footer.jsp 끝 ----------------------- -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="/resources/adminlte3/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/resources/adminlte3/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="/resources/adminlte3/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="/resources/adminlte3/plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="/resources/adminlte3/plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="/resources/adminlte3/plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="/resources/adminlte3/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="/resources/adminlte3/plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="/resources/adminlte3/plugins/moment/moment.min.js"></script>
<script src="/resources/adminlte3/plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="/resources/adminlte3/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="/resources/adminlte3/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="/resources/adminlte3/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/adminlte3/dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<!-- <script src="/resources/adminlte3/dist/js/demo.js"></script> -->
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="/resources/adminlte3/dist/js/pages/dashboard.js"></script>
<!-- 머지? -->
<!-- <script src="/resources/adminlte3/dist/js/adminlte.min.js"></script> -->

<!-- DataTables  & Plugins -->
<script src="/resources/adminlte3/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/resources/adminlte3/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="/resources/adminlte3/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="/resources/adminlte3/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="/resources/adminlte3/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="/resources/adminlte3/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="/resources/adminlte3/plugins/jszip/jszip.min.js"></script>
<script src="/resources/adminlte3/plugins/pdfmake/pdfmake.min.js"></script>
<script src="/resources/adminlte3/plugins/pdfmake/vfs_fonts.js"></script>
<script src="/resources/adminlte3/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="/resources/adminlte3/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="/resources/adminlte3/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>

<!-- kit.fontawesome.com/adb5b8f8b5.js" crossorigin="anonymous" 아이콘 css -->
<script src="https://kit.fontawesome.com/adb5b8f8b5.js" crossorigin="anonymous"></script>

</body>
</html>


