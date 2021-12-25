<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ruby_Input</title>
<style type="text/css">

#ruby_title {
    color: #cc3333;
    text-align: center;
}

#exe_form_ruby {
    display:inline-block;
    width:50%;
}

#exe_result_ruby {
    display:inline-block;
    width:50%;
    float:right;
}

#ruby_textarea {
    width: 99%;
    background-color: #333333;
    color: white;
}

</style>
<script src="<%= request.getContextPath() %>/js/Ruby/code_input.js"></script>
</head>
<body>

<% String ruby_result = (String)request.getAttribute("ruby_result"); %>
<% String code_contents1 = (String)request.getAttribute("code_contents1"); %>
<% String code_contents2 = (String)request.getAttribute("code_contents2"); %>

<p id="code_contents1" style="display: none;"><% if(code_contents1 != null) { %><%= code_contents1 %><% } %></p>
<p id="code_contents2" style="display: none;"><% if(code_contents1 != null) { %><%= code_contents2 %><% } %></p>

<h1 id="ruby_title">Rubyのソースコードを書いて実行してみよう!</h3>

<div>
<div id="exe_form_ruby">
<span id="sample1.rb">★sample1.rb</span>
<span id="sample2.rb">★sample2.rb</span>
<form action="ruby_execute" method="post" name="ruby_form">
<textarea id="ruby_textarea" rows="35" name="code_contents"></textarea><br>
<button id="ruby_exe_button" type="button" onclick="submit();" style="display: none;">実行する</button>
<p id="dummy_button">実行する</p>
</form>
</div>

<div id="exe_result_ruby">
<span>★実行結果★</span>
<div style="height: 668px; background-color: #BAD3FF;">
<% if(ruby_result != null) { %>
<%= ruby_result %>
<% } %>
</div>
</div>
</div>

</body>
</html>

