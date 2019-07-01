<!-- Copyright (c) 1999-2003 by BEA Systems, Inc. All Rights Reserved.-->
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;CHARSET=iso-8859-1">
  <meta name="description" content="BEA WebLogic Server">
  <meta name="keywords" content="BEA WebLogic Server">
  <title>WTC Simpapp JSP</title>
  <LINK REL="stylesheet"
  TYPE="text/css"
  HREF="wls_examples.css"
  TITLE="BEA WebLogic Server">
</head>

<%@ page import="java.io.*";%>
<%@ page import="java.lang.*";%>
<%@ page import="java.util.*";%>
<%@ page import="java.rmi.RemoteException";%>

<%@ page import="javax.servlet.*";%>
<%@ page import="javax.servlet.http.*";%>
<%@ page import="javax.ejb.*";%>
<%@ page import="javax.naming.*";%>
<%@ page import="java.rmi.RemoteException";%>

<%@ page import="weblogic.jndi.*";%>
<%@ page import="weblogic.wtc.jatmi.Reply";%>
<%@ page import="weblogic.wtc.jatmi.TPException";%>
<%@ page import="weblogic.wtc.jatmi.TypedString";%>
<%@ page import="weblogic.wtc.jatmi.TypedBuffer";%>
<%@ page import="weblogic.wtc.jatmi.TuxedoService";%>
<%@ page import="weblogic.wtc.gwt.TuxedoConnection";%>
<%@ page import="weblogic.wtc.jatmi.TPServiceInformation";%>
<%@ page import="weblogic.wtc.gwt.TuxedoConnectionFactory";%>
<%

System.out.println("-------------------------------");
	Context ctx;
	Reply myRtn;
   String chek;
   int result=1;
   TuxedoConnection  myTux=null;
   TuxedoConnectionFactory tcf;
   Environment env = new  Environment();
%>

<!-- EXAMPLE CONTENT -->
<table summary="EXAMPLES_CONTENT" border=0 cellspacing="18" cellpadding="0">
  <tr>
    <td valign="top">
      <h3><p> Starting Invocation  to Tuxedo Domain ... 
<%
  	String TuxString = "HelloWorld";
   TypedString myData = new TypedString(TuxString);

	try
	{
%>

<p> Obtain the Environment InitialContext ....
<%
		ctx = env.getInitialContext();
%>

<p> Obtain TuxedoConnectionFactory ...
<%
		tcf = (TuxedoConnectionFactory) ctx.lookup ("tuxedo.services.TuxedoConnection");
%>
<p> lookup TuxedoConnectionFactory successful ...


<p> Obtain TuxedoConnection ...
<%
		myTux = tcf.getTuxedoConnection();
%>
<p> Connection obtained ... 

<p> Data transmitted is     "<i><font color=red><%= myData.toString()%></font></i>"
<p> Invoking Tuxedo  TOUPPER service...
<%
System.out.println("000");
myRtn = myTux.tpcall("TOUPPER", myData, 0);
System.out.println("111");
%>
<p> tpcall  SUCCESSFULL ...

<p> Get the Reply buffer ...
<%
      myData = (TypedString) myRtn.getReplyBuffer();
   System.out.println("aaa");
%>
<p> Reply buffer recieved ...

<%
		if (myData.toString().equals(TuxString.toUpperCase()) )
		{
			result = 0;
			System.out.println("aaabbb");
		}
		else
		{
			result = 1;
			System.out.println("aacccca");
		}
	}
  	catch (TPException tpe)
   {
%>
<p> ERROR - : TPException  "<i><font color=red><%= tpe.toString()%></font></i>"
<%
         result =1;
   }
   catch (Exception ex)
   {
%>
<p> ERROR -- : Exception  "<i><font color=red><%= ex.toString()%></font></i>"

<%
         result =1;
   }
   finally
   {
         myTux.tpterm();
         if( result == 0)
         {
%>
<h3><p>SUCCESS:  Data Recieved from Tuxedo TOUPPER is    "<i><font color=red><%= myData.toString()%></font></i>"</h3>
<%
         }
         else
         {
%>
<h3><p>FAILURE: Test for Tuxedo "TOUPPER" service through WTC FAILED
<%
         }
	}
%>


      <p>
    </td>
  </tr>
</table>

<br>







</body>
</html>
