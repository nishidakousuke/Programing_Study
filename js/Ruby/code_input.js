(() => {

    let ruby_textarea;
    let dummy_button;
    let sample1_contents = "";
    let sample2_contents = "";
    let file_change_flag = 1; // 最初はsample1.rbが開かれる設定
    let sample1;
    let sample2;

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
        if(file_change_flag === 1) {
            sample1_contents = ruby_textarea.value;
        } else if(file_change_flag === 2) {
            sample2_contents = ruby_textarea.value;
        }
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
        // render();
    });

})();
