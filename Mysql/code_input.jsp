<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mysql_Input</title>
<style type="text/css">

#mysql_title {
    color: purple;
    text-align: center;
}

#most_outer {
    width: 100%;
}

#sql_input_box {
    display:inline-block;
    width:35%;
}

#table_display_box {
    display:inline-block;
    width:64%;
    float:right;
}

#sql_exe_result_box {
    overflow: auto;
    background-color: #ffbeda;
    color: #ff0461;
    width: 99%;
    font-size: 16px;
    padding-left: 10px;
    height: 300px;
    border: solid;
    margin: -15px 0 0 0;
}

#mysql_textarea {
    width: 98%;
    background-color: black;
    color: white;
}

#table_show {
    overflow: auto;
    background-color: #bad3ff;
    color: #00008b;
    font-size: 16px;
    padding-left: 10px;
    height: 380px;
    border: solid;
}

</style>
<script src="<%= request.getContextPath() %>/js/Mysql/code_input.js"></script>
</head>
<body>

<% String mysql_result = (String)request.getAttribute("mysql_result"); %>
<% String table_show = (String)request.getAttribute("table_show"); %>
<% String code_contents = (String)request.getAttribute("code_contents"); %>
<% String[] table_names = (String[])request.getAttribute("table_names"); %>
<% String table_name = (String)request.getAttribute("table_name"); %>

<p id="current_table_name" style="display: none;"><% if(table_name != null) { %><%= table_name %><% } %></p>

<h1 id="mysql_title" >MysqlでSQLを実行してみよう!</h3>

<p><a href="../index.jsp">タイトル画面に戻る</a></p>

<div id="most_outer">

<div id="sql_input_box">
<span>sqlを記述する</span>
<form action="mysql_execute" method="post" name="mysql_form">
<textarea id="mysql_textarea" rows="20" name="code_contents"><% if(code_contents != null) { %><%= code_contents %><% } %></textarea><br>
<input id="mysql_execute_table_name" type="text" name="table_name" style="display: none;">
<button id="mysql_exe_button" type="button" onclick="submit();">実行する</button>
</form>
</div>

<div id="table_display_box">
<% if(table_names != null) { %>
<div id="table_name_box" count="<%= table_names.length %>">
<% for(int i = 0; i < table_names.length; i++) { %>
<span id="span_table_name<%= i %>"><%= table_names[i] %></span>
<% } %>
</div>
<% } %>
<form action="forward" method="get" name="table_change_form">
<input id="table_change_input" type="text" name="table_change_name" style="display: none;">
<input id="sql_code_input" type="text" name="code_contents" style="display: none;">
<button id="table_change_button" type="button" onclick="submit();" style="display: none;"></button>
</form>
<div id="table_show">
<pre>
<% if(table_show != null) { %>
<%= table_show %>
<% } %>
</pre>
</div>
</div>

<h3>★実行結果★</h3>
<div id="sql_exe_result_box">
<pre>
<% if(mysql_result != null) { %>
<%= mysql_result %>
<% } %>
</pre>
</div>

</div>

</body>
</html>

