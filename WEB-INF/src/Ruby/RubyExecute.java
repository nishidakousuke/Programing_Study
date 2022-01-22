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
        FileWriter fw1 = new FileWriter(
                "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/sample1", false); // ファイルは上書きするためfalseを指定
        FileWriter fw2 = new FileWriter(
                "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/sample2", false);
        File result_file = new File("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/exists_flag.txt");
        Runtime rt = Runtime.getRuntime();
        String ruby_result = "";
        try {
            String program_language = request.getParameter("program_language");
            String code_contents = request.getParameter("code_contents");
            int delimiter_index = code_contents.indexOf("qwer");
            String code_contents1 = code_contents.substring(0, delimiter_index);
            String code_contents2 = code_contents.substring(delimiter_index + 4, code_contents.length());
            fw1.write(code_contents1);
            fw1.flush();
            fw1.close();
            fw2.write(code_contents2);
            fw2.flush();
            fw2.close();

            // rubyにて実行させる
            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/ruby_execute.sh " + program_language);

            // ファイルが存在しなければここでストップ
            while (!(result_file.exists())) {
            }

            // Thread.sleep(1000);

            // この段階でruby_result3.txtが存在していないといけない。
            FileReader fr = new FileReader(
                    "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/ruby_result3.txt");
            int c = fr.read();
            while (c != -1) {
                ruby_result = ruby_result + (char) c;
                c = fr.read();
            }
            fr.close();

            // 実行結果ファイルの内容をクリア
            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/ruby_result_clear.sh");

            System.out.println(code_contents1);

            request.setAttribute("ruby_result", ruby_result);
            request.setAttribute("code_contents1", code_contents1);
            request.setAttribute("code_contents2", code_contents2);
            request.setAttribute("program_language", program_language);
            request.getRequestDispatcher("code_input.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
