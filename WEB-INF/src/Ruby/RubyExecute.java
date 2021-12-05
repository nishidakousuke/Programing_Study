package Ruby;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.*;

@WebServlet(urlPatterns = { "/Ruby/ruby_execute" })
public class RubyExecute extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        FileWriter fw = new FileWriter(
                "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/ruby_source-code.sh", false); // ファイルは上書きするためfalseを指定
        File result_file = new File("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/exists_flag.txt");
        Runtime rt = Runtime.getRuntime();
        String ruby_result = "";
        try {
            String code_contents = request.getParameter("code_contents");
            fw.write(code_contents);
            fw.flush();
            fw.close();

            // rubyにて実行させる
            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/ruby_execute.sh");

            // ファイルが存在しなければここでストップ
            while(!(result_file.exists())) {
            }

            //Thread.sleep(1000);

            // この段階でruby_result2.txtが存在していないといけない。
            FileReader fr = new FileReader("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/ruby_result2.txt");
            int c = fr.read();
            while(c != -1) {
                ruby_result = ruby_result + (char)c;
                c = fr.read();
            }
            fr.close();

            // 実行結果ファイルの内容をクリア
            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/ruby_result_clear.sh");

            request.setAttribute("ruby_result", ruby_result);
            request.setAttribute("code_contents", code_contents);
            request.getRequestDispatcher("code_input.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
