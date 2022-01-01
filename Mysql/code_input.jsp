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
    background-color: red;
    width: 100%;
}

#sql_input_box {
    display:inline-block;
    width:50%;
    background-color: yellow;
}

#table_display_box {
    display:inline-block;
    width:50%;
    float:right;
    background-color: blue;
}

#sql_exe_result_box {
    background-color: green;
    width: 100%;
}

#mysql_textarea {
    width: 98%;
}

</style>
<script src="<%= request.getContextPath() %>/js/Mysql/code_input.js"></script>
</head>
<body>

<% String mysql_result = (String)request.getAttribute("mysql_result"); %>
<% String table_show = (String)request.getAttribute("table_show"); %>
<% String code_contents = (String)request.getAttribute("code_contents"); %>

<h1 id="mysql_title" >MysqlでSQLを実行してみよう!</h3>

<div id="most_outer">

<div id="sql_input_box">
<form action="mysql_execute" method="post" name="mysql_form">
<textarea id="mysql_textarea" rows="20" name="code_contents"><% if(code_contents != null) { %><%= code_contents %><% } %></textarea><br>
<button id="mysql_exe_button" type="button" onclick="submit();">実行する</button>
</div>

<div id="table_display_box">
<% if(table_show != null) { %>
<%= table_show %>
<% } %>
</div>

<div id="sql_exe_result_box">
<h3>★実行結果★</h3>
<% if(mysql_result != null) { %>
<%= mysql_result %>
<% } %>
</div>

</div>

</body>
</html>

