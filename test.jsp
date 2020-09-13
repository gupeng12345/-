<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
	
<title>当前文章界面</title>

<h1>当前文章界面</h1>

<% 
	String content = request.getParameter("content");
	if (content != null) {
		out.println(content);
	} else {
		out.println("<p>请输入英文文章后，点击确认按钮。</p>");
	}

%>

<p><a href="./history.jsp">前往历史</a></p>

<form method="post" action="./test.jsp">
	<textarea name="content" rows="20" cols="80">输入文章 ...</textarea>
	<br/>
	<input type="submit" name="confirmation" value="确认" />
</form>


<p>

当前时间:

<%= new java.util.Date() %>

</p>