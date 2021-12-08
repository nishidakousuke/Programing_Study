<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>C言語_Input</title>
<style type="text/css">

</style>
<%-- <script src="<%= request.getContextPath() %>/js/Ruby/code_input.js"></script> --%>
</head>
<body>

<% String c_result = (String)request.getAttribute("c_result"); %>
<% String code_contents = (String)request.getAttribute("code_contents"); %>

<h3>C言語のソースコードを書いて実行してみよう!</h3>

<form action="c_execute" method="post">
<textarea rows="30" cols="90" name="code_contents"><% if(code_contents != null) { %><%= code_contents %><% } %></textarea><br>
<button type="button" onclick="submit();">実行する</button>
</form>

<h3>★実行結果★</h3>
<% if(c_result != null) { %>
<%= c_result %>
<% } %>

</body>
</html>

