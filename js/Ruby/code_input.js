(() => {

    let ruby_textarea;

    function render() {
        // console.log(ruby_textarea.value[1] === '\n');
        // console.log(ruby_textarea.value.substr(ruby_textarea.selectionStart - 2, ruby_textarea.selectionStart - 1));
        console.log(ruby_textarea.selectionStart);
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

    window.addEventListener("DOMContentLoaded", () => {
        ruby_textarea = document.getElementById("ruby_textarea");
        ruby_textarea.addEventListener('keydown', handleKeydown);
        //console.log("abc" + " ".repeat(3) + "def");
    });

})();
