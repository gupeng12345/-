<%@ page language="java" contentType="text/html; charset=UTF-8" import="edu.gu.Frequency"
	pageEncoding="UTF-8"%>
	
<title>英语单词频率统计</title>

<h1>英语单词频率统计</h1>
<% 
	String content = request.getParameter("content");
	if (content != null) {
		Frequency freq = new Frequency(content);
	} else {
		out.println("<p>输入原文</p>");
	}

%>
<form method="post" action="./demo1.jsp">
	<textarea name="content" rows="20" cols="120"></textarea>
	<br/>
	  <input type="text" name="q" />
	<input type="submit" name="confirmation" value="确定" />
</form>

	<form method="post" action="./display">
<p>单词--------------------次数</p> 
	<textarea name="word" rows="10" cols="15"></textarea>
	<textarea name="time" rows="10" cols="15"></textarea>
     <br/>   
	out.println(freq.sortHashMapByValues(freq.getFreq()));	
</form>

<p>

<p><a href="./history.jsp">历史记录</a></p>

</p>