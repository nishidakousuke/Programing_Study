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

#ruby_exe_result_box {
    overflow: auto;
    height: 250px;
    background-color: #BAD3FF;
    color: blue;
}

#ruby_help_box {
    overflow: auto;
    background-color: orange;
    height: 398px;
}

#file_content {
    background-color: pink;
    height: 380px;
}

#ruby_help_ul {
    
}

#c_help_ul {
    display: none;
}

#python3_help_ul {
    display: none;
}

#java_help_ul {
    display: none;
}

</style>
<script src="<%= request.getContextPath() %>/js/Ruby/code_input.js"></script>
</head>
<body>

<% String ruby_result = (String)request.getAttribute("ruby_result"); %>
<% String code_contents1 = (String)request.getAttribute("code_contents1"); %>
<% String code_contents2 = (String)request.getAttribute("code_contents2"); %>
<% String file_content = (String)request.getAttribute("file_content"); %>
<% String program_language = (String)request.getAttribute("program_language"); %>

<textarea id="code_contents1" style="display: none;"><% if(code_contents1 != null) { %><%= code_contents1 %><% } %></textarea>
<textarea id="code_contents2" style="display: none;"><% if(code_contents2 != null) { %><%= code_contents2 %><% } %></textarea>
<p id="program_language" style="display: none;"><% if(program_language != null) { %><%= program_language %><% } %></p>

<h1 id="ruby_title">ソースコードを書いて実行してみよう!</h3>

<p><a href="../index.jsp">タイトル画面に戻る</a></p>

<div>
<div id="exe_form_ruby">
<form action="ruby_execute" method="post" name="ruby_form">
<span id="sample1.rb">★sample1.rb</span>
<span id="sample2.rb">★sample2.rb</span>
<select id="select_program_language" name="program_language">
<option value="ruby">Ruby</option>
<option value="python3">Python</option>
<option value="c">C言語</option>
<option value="java">Java</option>
</select>
<textarea id="ruby_textarea" rows="35" name="code_contents"></textarea><br>
<button id="ruby_exe_button" type="button" onclick="submit();" style="display: none;">実行する</button>
<p id="dummy_button">実行する</p>
</form>
</div>

<div id="exe_result_ruby">
<span>★実行結果★</span>
<div id="ruby_exe_result_box">
<% if(ruby_result != null) { %>
<%= ruby_result %>
<% } %>
</div>
<form action="ruby_help" method="post" name="ruby_help_form">
<span id="help_open">★ヘルプを開く★</span>
<span id="help_all" style="display: none;">★ヘルプ一覧に戻る★</span>
<div id="ruby_help_box">
<ul id="ruby_help_ul">
<li>標準出力</li>
<ul>
<li value="stdout_hello_world">Hello Worldをコンソールに出力する</li>
</ul>
<li>配列</li>
</ul>
<ul id="c_help_ul">
<li>出力関数</li>
<ul>
<li value="printf">printf(3)/fprintf(3)</li>
</ul>
<li>配列</li>
</ul>
<ul id="python3_help_ul">
<li>出力関数</li>
<ul>
<li value="print">print</li>
</ul>
<li>配列</li>
</ul>
<ul id="java_help_ul">
<li>出力関数</li>
<ul>
<li value="system_out_println">System.out.println</li>
</ul>
<li>配列</li>
</ul>
</div>
<div id="file_content" style="display: none;">
<% if(file_content != null) { %>
<pre id="file_content_flag"><%= file_content %></pre>
<% } %>
</div>
<input id="ruby_help_input" type="text" name="ruby_help_content" style="display: none;">
<input id="program_language_help_input" type="text" name="program_language" style="display: none;">
<textarea id="ruby_help_source_save" name="ruby_help_source" style="display: none;"></textarea>
<button id="ruby_help_button" type="button" onclick="submit();" style="display: none;"></button>
</form>
</div>
</div>
</body>
</html>

