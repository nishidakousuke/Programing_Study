package Mysql;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.*;

@WebServlet(urlPatterns = { "/Mysql/forward" })
public class Forward extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Runtime rt = Runtime.getRuntime();
        File result_file = new File("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/exists_flag.txt");
        String table_show = "";
        String table_contents = "";
        try {
            String table_name = request.getParameter("table_change_name");
            String code_contents = request.getParameter("code_contents");

            // リンクから実行画面に遷移した場合とテーブル名をクリックした場合で条件分岐
            if (table_name == null) {
                rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/table_show.sh");
            } else {
                rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/table_show.sh " + table_name);
            }

            while (!(result_file.exists())) {
            }

            FileReader fr = new FileReader(
                    "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/table_show3.txt");
            int c = fr.read();
            while (c != -1) {
                table_show = table_show + (char) c;
                c = fr.read();
            }
            fr.close();

            FileReader fr2 = new FileReader(
                    "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/table_contents2.txt");
            int c2 = fr2.read();
            while (c2 != -1) {
                table_contents = table_contents + (char) c2;
                c2 = fr2.read();
            }
            fr2.close();

            // テーブル名達を配列に分割する
            String[] table_names = table_contents.split("\n");

            // リンクから飛んだ場合は、最初のテーブル名を設定する
            if (table_name == null) {
                table_name = table_names[0];
            }

            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/mysql_result_clear.sh");

            request.setAttribute("table_show", table_show);
            request.setAttribute("table_names", table_names);
            request.setAttribute("table_name", table_name);
            request.setAttribute("code_contents", code_contents);
            request.getRequestDispatcher("code_input.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
