(() => {

    let ruby_textarea;
    let dummy_button;
    let sample1_contents = "";
    let sample2_contents = "";
    let file_change_flag = 1; // 最初はsample1.rbが開かれる設定
    let sample1;
    let sample2;
    let ruby_help_box;
    let file_content_flag;
    let help_all;
    let program_select;
    let program_languages = ["ruby", "python3", "c", "java"];

    function render() {
        requestAnimationFrame(render);
    }

    function InitElemGet() {
        ruby_textarea = document.getElementById("ruby_textarea");
        dummy_button = document.getElementById("dummy_button");
        sample1 = document.getElementById("sample1.rb");
        sample2 = document.getElementById('sample2.rb');
        sample1_contents = document.getElementById("code_contents1").value;
        sample2_contents = document.getElementById("code_contents2").value;
        ruby_help_box = document.getElementById("ruby_help_box");
        file_content_flag = document.getElementById("file_content_flag");
        help_all = document.getElementById("help_all");
        program_select = document.getElementById("select_program_language");
    }

    function InitEventRegister() {
        ruby_textarea.addEventListener('keydown', handleKeydown);
        dummy_button.addEventListener('click', ContentsConcatAndDelayTrans);
        sample1.addEventListener('click', Sample1Open);
        sample2.addEventListener('click', Sample2Open);
        ruby_help_box.addEventListener('click', HelpOpen);
        help_all.addEventListener('click', HelpOpenFromDescription);
        program_select.addEventListener('change', ProgramSelect);
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

    // Enterキー押下による送信をキャンセルする
    function handleKeydown(event) {
        let keycode = event.keyCode;
        if(keycode === 13) {
            if(AutoIndent()) {
                event.preventDefault();
            }
        }
    }

    // ソースコードの内容を変数に保存してから、それらを連結した文字列をテキストエリアに設定してデータを送信する
    function ContentsConcatAndDelayTrans() {
        SourceSave();
        ruby_textarea.value = sample1_contents + "qwer" + sample2_contents;
        document.ruby_form.submit();
    }

    // sample1.rbを開いたときに、sample2.rbの内容を変数に保存しておく
    function Sample1Open() {
        if(file_change_flag === 1) {return;}
        sample2_contents = ruby_textarea.value;
        ruby_textarea.value = sample1_contents;
        file_change_flag = 1;
        sample1.style.color = 'red';
        sample2.style.color = 'black';
    }

    // sample2.rbを開いたときに、sample1.rbの内容を変数に保存しておく
    function Sample2Open() {
        if(file_change_flag === 2) {return;}
        sample1_contents = ruby_textarea.value;
        ruby_textarea.value = sample2_contents;
        file_change_flag = 2;
        sample2.style.color = 'red';
        sample1.style.color = 'black';
    }

    // ヘルプの内容を取得し、それをinputエリアに設定してデータを送信する。変数に保存しているソースの内容も同時に送信する
    function HelpOpen(event) {
        let content = event.target.getAttribute("value");
        if(content === null) {return;}
        let ruby_help_input = document.getElementById("ruby_help_input");
        let ruby_help_source_save = document.getElementById("ruby_help_source_save");
        ruby_help_input.value = content;
        SourceSave();
        ruby_help_source_save.value = sample1_contents + "qwer" + sample2_contents;
        document.ruby_help_form.submit();
    }

    // ソースの内容を変数に保存する
    function SourceSave() {
        if(file_change_flag === 1) {
            sample1_contents = ruby_textarea.value;
        } else if(file_change_flag === 2) {
            sample2_contents = ruby_textarea.value;
        }
    }

    // ヘルプ一覧かヘルプ内容のどちらを表示するかを決定する
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

    // ヘルプの内容からヘルプ一覧に戻るときの処理
    function HelpOpenFromDescription() {
        document.getElementById("help_open").style.display = "block";
        help_all.style.display = "none";
        document.getElementById("ruby_help_box").style.display = "block";
        document.getElementById("file_content").style.display = "none";
        document.getElementById("ruby_help_ul").style.display = "none";
        let selected_language = document.getElementById("program_language").innerHTML;
        document.getElementById(`${selected_language}_help_ul`).style.display = "block";
        document.getElementById("program_language_help_input").value = selected_language;
    }

    // 実行したプログラミング言語を実行後に初期値として画面に表示させる
    function ProgrammingLanguageFixed() {
        let program_language = document.getElementById("program_language").innerHTML;
        if(program_language === "") return;
        let select = document.getElementById("select_program_language");
        let option_num = select.children.length;
        for(let i = 0; i < option_num; i++) {
            if(program_language === select.children[i].value) {
                select.children[i].selected = true;
            }
        }
        HelpDisplayChange(program_language, "ruby");
    }

    function TextAreaCodeInsert() {
        ruby_textarea.value = sample1_contents;
        sample1.style.color = 'red';
    }

    function FrameWorkInsert(language) {
        if(language === "java") {
            ruby_textarea.value = `import java.io.*;
import java.util.*;

public class Sample1 {
    public static void main(String[] args) {
        
    }
}`
        } else if(language === "c") {
            ruby_textarea.value = `#include <stdio.h>

int main(int argc, char *argv[]) {
    
}`
        } else {
            ruby_textarea.value = "";
        }
    }

    // 現在映し出されているヘルプ画面がなんの言語なのかを返す
    function CurrentHelpDisplayLanguageCheck() {
        for(let i = 0; i < program_languages.length; i++) {
            let language = program_languages[i];
            let elem = document.getElementById(`${language}_help_ul`);
            if(getComputedStyle(elem).display === "block") {
                return language;
            }
        }
    }

    // 選ばれたプログラミング言語のヘルプ画面に切り替える
    function HelpDisplayChange(selected_language, old_language) {
        document.getElementById(`${old_language}_help_ul`).style.display = "none";
        document.getElementById(`${selected_language}_help_ul`).style.display = "block";
    }

    // プログラミング言語を変更したときに発火する
    function ProgramSelect(event) {
        let selected_language = event.currentTarget.value;
        FrameWorkInsert(selected_language);
        let old_language = CurrentHelpDisplayLanguageCheck();
        HelpDisplayChange(selected_language, old_language);
        document.getElementById("program_language_help_input").value = selected_language;
    }

    window.addEventListener("DOMContentLoaded", () => {
        InitElemGet();
        InitEventRegister();
        TextAreaCodeInsert();
        HelpORDescriptionOpen();
        ProgrammingLanguageFixed();
        // render();
    });

})();
