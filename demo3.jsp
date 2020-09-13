<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>英语单词频率统计</title>
</head>
<body>
<a href="./demo1.jsp">主页</a>
<% Class.forName("org.sqlite.JDBC"); %>
<form method="post" action="./demo1.jsp">
    <p>单词-</p> 
	<textarea name="word" rows="2" cols="10"></textarea>
	 <input type="text" name="word" />
	 <input type="submit" name="submit-button" value="确认"/>
	<br/>
</form>
<form method="post" action="./demo1.jsp">
    <p>历史次数-----------本篇次数--</p> 
	<textarea name="historytime" rows="10" cols="13"></textarea>
	<textarea name="bengpiancishu" rows="10" cols="13"></textarea>
	<br/>
</form>

<% String q = request.getParameter("word");  
   if (q != null) { %>
   <%= runQuery(q) %>
<% } else { %> 
	<p>Everything in the database:</p>
	<%= runQuery("") %>
<% } %> 

<%
	if (q == null)   
		out.println("<p>You entered nothing.</p>");
	else if (q.strip().equals("")) 
      	out.println("<p>You entered an empty string.</p>"); 
	else
		out.println(String.format("<p>You entered <b>%s</b>.</p>", q));
%>



<%-- Declare and define the runQuery() method. --%>
<%-- https://docs.oracle.com/cd/A87860_01/doc/java.817/a83726/basics7.htm#1014578 --%>
<%! private String runQuery(String cond) throws SQLException {
     Connection conn = null; 
     Statement stmt = null; 
     ResultSet rset = null; 
     try {
        conn = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\drlan\\Downloads\\Software\\freq.db");
        stmt = conn.createStatement();
        // dynamic query
        rset = stmt.executeQuery (String.format("SELECT * FROM wordcount WHERE content LIKE '%%%s%%' ORDER BY count", cond));
       return (formatResult(rset));
     } catch (SQLException e) { 
         return ("<P> SQL error: <PRE> " + e + " </PRE> </P>\n");
     } finally {
         if (rset!= null) rset.close(); 
         if (stmt!= null) stmt.close();
         if (conn!= null) conn.close();
     }
  }

  private String formatResult(ResultSet rset) throws SQLException {
    StringBuffer sb = new StringBuffer();
    if (!rset.next())
      sb.append("<P> No matching rows.<P>\n");
    else {  sb.append("<UL>"); 
            do {  sb.append("<LI>"  + rset.getInt("id") + " | " + rset.getString("content") + 
                            " | WordCount:" + rset.getInt("count") + " | Level:" + rset.getInt("level") + " | " + String.format("<a href=\"./delete.jsp?deleteID=%d\">DELETE</a>", rset.getInt("id")) +   
                           String.format("<form method=\"post\" action=\"./update-level\"> Difficulty level: <input type=\"hidden\" name=\"updateID\" value=\"%d\"><input type=\"radio\" name=\"rating\" value=\"1\">1 <input type=\"radio\" name=\"rating\" value=\"2\">2 <input type=\"radio\" name=\"rating\" value=\"3\">3 <input type=\"submit\" value=\"Update\"/> </form>" + "</BR></LI>\n", rset.getInt("id")));
            } while (rset.next());
           sb.append("</UL>"); 
    }
    return sb.toString();
  }
%>

<a href="./demo2.jsp">查看生疏度</a>
</body>
</html>