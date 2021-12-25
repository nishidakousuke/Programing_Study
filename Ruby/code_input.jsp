<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ruby_Input</title>
<style type="text/css">

</style>
<script src="<%= request.getContextPath() %>/js/Ruby/code_input.js"></script>
</head>
<body>

<% String ruby_result = (String)request.getAttribute("ruby_result"); %>
<% String code_contents1 = (String)request.getAttribute("code_contents1"); %>
<% String code_contents2 = (String)request.getAttribute("code_contents2"); %>

<p id="code_contents1" style="display: none;"><% if(code_contents1 != null) { %><%= code_contents1 %><% } %></p>
<p id="code_contents2" style="display: none;"><% if(code_contents1 != null) { %><%= code_contents2 %><% } %></p>

<h3>Rubyのソースコードを書いて実行してみよう!</h3>

<div>
<span id="sample1.rb">★sample1.rb</span>
<span id="sample2.rb">★sample2.rb</span>
</div>

<form action="ruby_execute" method="post" name="ruby_form">
<textarea id="ruby_textarea" rows="30" cols="90" name="code_contents"></textarea><br>
<button id="ruby_exe_button" type="button" onclick="submit();" style="display: none;">実行する</button>
<p id="dummy_button">実行する</p>
</form>

<h3>★実行結果★</h3>
<% if(ruby_result != null) { %>
<%= ruby_result %>
<% } %>

</body>
</html>

