<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Python_Input</title>
<style type="text/css">

</style>
<script src="<%= request.getContextPath() %>/js/Python/code_input.js"></script>
</head>
<body>

<% String python_result = (String)request.getAttribute("python_result"); %>
<% String code_contents = (String)request.getAttribute("code_contents"); %>

<h3>Pythonのソースコードを書いて実行してみよう!</h3>

<form action="python_execute" method="post" name="python_form">
<textarea id="python_textarea" rows="30" cols="90" name="code_contents"><% if(code_contents != null) { %><%= code_contents %><% } %></textarea><br>
<button id="python_exe_button" type="button" onclick="submit();">実行する</button>
</form>

<h3>★実行結果★</h3>
<% if(python_result != null) { %>
<%= python_result %>
<% } %>

</body>
</html>

