<%@ page  contentType="text/html;charset=UTF-8"%>

<%@ page import="java.util.*" %>
<html>
<head>
<title>세션 예제</title>
</head>
<body>

<%
 Integer count = (Integer)session.getAttribute("count");
System.out.println(" count : " + count);
System.out.println("============== 1111111111111111 ");
 if(count == null){
System.out.println(" in if : 22222222222222222 ");
  count = new Integer(1);
 } else{
System.out.println(" in else : 33333333333333333 ");
  count = new Integer(count.intValue() + 1);
 }
System.out.println(" before setAttribute() ");
 session.setAttribute("count", count);
System.out.println(" after setAttribute() ");
 
 out.println("방문 횟수: " + count + "<br>");
 out.println("도메인 명: " + System.getProperty("domain.name") + "<br>");
 out.println("<p>");
 out.println("<h3>세션 정보 : </h3>");
 
 Enumeration names = session.getAttributeNames();
 
 
 out.println("세션 ID: " + session.getId() + "<br>");
 out.println("세션 생성: " + session.isNew() + "<br>");
 out.println("생성 시간: " + session.getCreationTime());
 out.println("<i>(" + new Date(session.getCreationTime()) + ")</i><br>");
 out.println("마지막 참조 시간: " + session.getLastAccessedTime());
 out.println("<i>(" + new Date(session.getLastAccessedTime()) + "></i><br>");
 out.println("세션 요청 여부(쿠키): " + request.isRequestedSessionIdFromCookie() + "<br>");
 out.println("세션 유효 여부: " + request.isRequestedSessionIdValid() + "<br>");
%>

<%
 out.println("Cookie 값들 "+"<br>");
String cookieName = "username";
Cookie cookies [] = request.getCookies ();
Cookie myCookie = null;
if (cookies != null)
{
 for (int i = 0; i < cookies.length; i++)
  {
    out.println (cookies [i].getName()+"=");
    out.println (cookies [i].getValue());
  }
}
%>


</body>
</html>
