(() => {

    let table_name;

    function TableChange(event) {
        // テーブル名の箇所以外がクリックされた場合は、即座にリターンする
        if(!(event.target.id.startsWith("span_table_name"))) {return;};
        let table_change_input = document.getElementById("table_change_input");
        table_change_input.value = event.target.innerHTML;
        document.getElementById("sql_code_input").value = document.getElementById("mysql_textarea").innerHTML;
        document.table_change_form.submit();
    }

    function CurrentTableCheck() {
        let current_table_name = document.getElementById("current_table_name").innerHTML;
        if(current_table_name === "") {return;}
        document.getElementById("mysql_execute_table_name").value = current_table_name;
        let table_count = parseInt(table_name.getAttribute("count"));
        for(let i = 0; i < table_count; i++) {
            let content = document.getElementById("span_table_name" + i);
            if(current_table_name === content.innerHTML) {
                content.style.color = "red";
                break;
            }
        }
    }

    window.addEventListener("DOMContentLoaded", () => {
        table_name = document.getElementById("table_name_box");
        table_name.addEventListener("click", TableChange);
        CurrentTableCheck();
    });
})();
