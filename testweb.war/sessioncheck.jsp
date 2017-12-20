<%
//session.setAttribute("ID","sanghunji");
System.out.println("now session is  : "+session.getAttribute("ID"));
%>
<html>
<head>
  <script language="javascript">
	function aaa() {
		setTimeout ("refresh()",5000);
	}

	function refresh(){
		document.location.href="sessioncheck.jsp"
	}
  </script>
</head>
<body onload="aaa()">
<%out.println(session.getAttribute("ID"));%>
</body>
</html>