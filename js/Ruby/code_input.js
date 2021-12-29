(() => {

    let ruby_textarea;
    let dummy_button;
    let sample1_contents = "";
    let sample2_contents = "";
    let file_change_flag = 1; // 最初はsample1.rbが開かれる設定
    let sample1;
    let sample2;
    let ruby_help_ul;
    let file_content_flag;
    let help_all;

    function render() {
        requestAnimationFrame(render);
    }

    // 文字列を逆順にする
    function reverse(s){
        return s.split("").reverse().join("");
    }

    // Enterキー押下にて改行した際、自動でインデントする。
    function AutoIndent() {
        let all_text = ruby_textarea.value;
        let now_corsor_index = ruby_textarea.selectionStart;
        let one_line_str = "";
        let blank_count = 0;
        for(let i = now_corsor_index - 1; i >= 0; i--) {
            if(all_text[i] === '\n') {break;}
            one_line_str += all_text[i];
        }
        one_line_str = reverse(one_line_str);
        // 取り敢えず、defとifのみ実装中
        if(one_line_str.includes("def ") || one_line_str.includes("if ")) {
            // 先頭が空白から始まっている場合は、その数を数えて、その分も連結する。
            if(one_line_str.startsWith(" ")) {
                for(let i = 0; i <= one_line_str.length; i++) {
                    if(one_line_str[i] !== " ") {break;}
                    blank_count++;
                }
                ruby_textarea.value = all_text + "\n    " + " ".repeat(blank_count);
            } else {
                ruby_textarea.value = all_text + "\n    ";
            }
            return true;
        }
    }

    function handleKeydown(event) {
        let keycode = event.keyCode;
        if(keycode === 13) {
            if(AutoIndent()) {
                event.preventDefault();
            }
        }
    }

    function ContentsConcatAndDelayTrans() {
        SourceSave();
        ruby_textarea.value = sample1_contents + "qwer" + sample2_contents;
        document.ruby_form.submit();
    }

    function Sample1Open() {
        if(file_change_flag === 1) {return;}
        sample2_contents = ruby_textarea.value;
        ruby_textarea.value = sample1_contents;
        file_change_flag = 1;
        sample1.style.color = 'red';
        sample2.style.color = 'black';
    }

    function Sample2Open() {
        if(file_change_flag === 2) {return;}
        sample1_contents = ruby_textarea.value;
        ruby_textarea.value = sample2_contents;
        file_change_flag = 2;
        sample2.style.color = 'red';
        sample1.style.color = 'black';
    }

    function HelpOpen(event) {
        let content = event.target.getAttribute("value");
        let ruby_help_input = document.getElementById("ruby_help_input");
        let ruby_help_source_save = document.getElementById("ruby_help_source_save");
        ruby_help_input.value = content;
        SourceSave();
        ruby_help_source_save.value = sample1_contents + "qwer" + sample2_contents;
        document.ruby_help_form.submit();
    }

    function SourceSave() {
        if(file_change_flag === 1) {
            sample1_contents = ruby_textarea.value;
        } else if(file_change_flag === 2) {
            sample2_contents = ruby_textarea.value;
        }
    }

    function HelpORDescriptionOpen() {
        let ruby_help_box = document.getElementById("ruby_help_box");
        let file_content = document.getElementById("file_content");
        let help_open = document.getElementById("help_open");
        if(file_content_flag === null) {
            ruby_help_box.style.display = "block";
            file_content.style.display = "none";
            help_open.style.display = "block";
            help_all.style.display = "none";
        } else {
            ruby_help_box.style.display = "none";
            file_content.style.display = "block";
            help_open.style.display = "none";
            help_all.style.display = "block";
        }
    }

    function HelpOpenFromDescription() {
        let help_open = document.getElementById("help_open");
        help_open.style.display = "block";
        help_all.style.display = "none";
        let ruby_help_box = document.getElementById("ruby_help_box");
        ruby_help_box.style.display = "block";
        let file_content = document.getElementById("file_content");
        file_content.style.display = "none";
    }

    window.addEventListener("DOMContentLoaded", () => {
        ruby_textarea = document.getElementById("ruby_textarea");
        dummy_button = document.getElementById("dummy_button");
        sample1 = document.getElementById("sample1.rb");
        sample2 = document.getElementById('sample2.rb');
        ruby_textarea.addEventListener('keydown', handleKeydown);
        dummy_button.addEventListener('click', ContentsConcatAndDelayTrans);
        sample1.addEventListener('click', Sample1Open);
        sample2.addEventListener('click', Sample2Open);
        sample1_contents = document.getElementById("code_contents1").innerHTML;
        sample2_contents = document.getElementById("code_contents2").innerHTML;
        ruby_textarea.value = sample1_contents;
        sample1.style.color = 'red';
        ruby_help_ul = document.getElementById("ruby_help_ul");
        ruby_help_ul.addEventListener('click', HelpOpen);
        file_content_flag = document.getElementById("file_content_flag");
        help_all = document.getElementById("help_all");
        help_all.addEventListener('click', HelpOpenFromDescription);
        HelpORDescriptionOpen();
        // render();
    });

})();
