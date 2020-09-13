<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>

<title>筛选界面</title>
<p><a href="./demo1.jsp">主页</a></p>

<% Class.forName("org.sqlite.JDBC"); %>	

<form method="get" action="./demo4.jsp">
    <p>输入单词</p>
    <textarea name="word" rows="2" cols="10"></textarea>
	   <input type="text" name="word" />
	    <input type="submit" name="submit-button" value="确定"/>
	<br/>
	 <p>输出生疏度</p>
	 <textarea name="output" rows="1" cols="20"></textarea>
	<br/>
	<input type="submit" name="confirmation" value="重新输入单词" />
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


<form method="post" action="./demo4.jsp">
	 <p>筛选生疏度</p>
	<textarea name="shuaixuan" rows="1" cols="20"></textarea>
	<br/>
	 <input type="text" name="number" />
	<input type="submit" name="confirmation" value="筛选" />
	 <p>输出：</p>
	  <p>---单词----------生疏度------</p>
	  <textarea name="word" rows="20" cols="10"></textarea>
	  <textarea name="shengshudu" rows="20" cols="10"></textarea>
	  <br/>
	<input type="submit" name="confirmation" value="重新筛选" />
</form>


<% String p = request.getParameter("number");  
   if (p != null) { %>
   <%= shuaixuan(p) %>
<% } else { %> 
	<p>Everything in the database:</p>
	<%= shuaixuan("") %>
<% } %> 

<%
	if (p == null)   
		out.println("<p>You entered nothing.</p>");
	else if (q.strip().equals("")) 
      	out.println("<p>You entered an empty string.</p>"); 
	else
		out.println(String.format("<p>You entered <b>%s</b>.</p>", q));
%>

<%-- Declare and define the runQuery() method. --%>
<%-- https://docs.oracle.com/cd/A87860_01/doc/java.817/a83726/basics7.htm#1014578 --%>
<%! private String shuaixuan(String number)throws SQLException{
	String s="apple";
	return s;
	}
%>
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
</p>
</body>
</html>