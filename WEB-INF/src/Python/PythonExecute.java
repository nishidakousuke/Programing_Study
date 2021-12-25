package Python;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.*;

@WebServlet(urlPatterns = { "/Python/python_execute" })
public class PythonExecute extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        FileWriter fw = new FileWriter(
                "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Python/sample.py", false); // ファイルは上書きするためfalseを指定
        File result_file = new File("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Python/exists_flag.txt");
        Runtime rt = Runtime.getRuntime();
        String python_result = "";
        try {
            String code_contents = request.getParameter("code_contents");
            fw.write(code_contents);
            fw.flush();
            fw.close();

            // pythonにて実行させる
            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Python/python_execute.sh");

            // ファイルが存在しなければここでストップ
            while (!(result_file.exists())) {
            }

            // Thread.sleep(1000);

            // この段階でruby_result2.txtが存在していないといけない。
            FileReader fr = new FileReader(
                    "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Python/python_result2.txt");
            int c = fr.read();
            while (c != -1) {
                python_result = python_result + (char) c;
                c = fr.read();
            }
            fr.close();

            // 実行結果ファイルの内容をクリア
            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Python/python_result_clear.sh");

            request.setAttribute("python_result", python_result);
            request.setAttribute("code_contents", code_contents);
            request.getRequestDispatcher("code_input.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
