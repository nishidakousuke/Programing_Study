package C;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.*;

@WebServlet(urlPatterns = { "/C/c_execute" })
public class C_Execute extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        FileWriter fw = new FileWriter(
                "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/C/c_source-code.c", false); // ファイルは上書きするためfalseを指定
        File result_file = new File("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/C/exists_flag.txt");
        Runtime rt = Runtime.getRuntime();
        String c_result = "";
        try {
            String code_contents = request.getParameter("code_contents");
            fw.write(code_contents);
            fw.flush();
            fw.close();

            // C言語のソースコードをコンパイルして実行させる
            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/C/c_compile_execute.sh");

            // ファイルが存在しなければここでストップ
            while(!(result_file.exists())) {
            }

            //Thread.sleep(1000);

            // この段階でc_result1.txtが存在していないといけない。
            FileReader fr = new FileReader("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/C/c_result1.txt");
            int c = fr.read();
            while(c != -1) {
                c_result = c_result + (char)c;
                c = fr.read();
            }
            fr.close();

            // 実行結果ファイルの内容をクリア
            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/C/c_result_clear.sh");

            request.setAttribute("c_result", c_result);
            request.setAttribute("code_contents", code_contents);
            request.getRequestDispatcher("code_input.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
