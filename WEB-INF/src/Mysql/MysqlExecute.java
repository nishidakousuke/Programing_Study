package Mysql;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.*;

@WebServlet(urlPatterns = { "/Mysql/mysql_execute" })
public class MysqlExecute extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        FileWriter fw = new FileWriter(
                "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/mysql_code.txt", false); // ファイルは上書きするためfalseを指定
        File result_file = new File("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/exists_flag.txt");
        Runtime rt = Runtime.getRuntime();
        String mysql_result = "";
        String table_show = "";
        try {
            String code_contents = request.getParameter("code_contents");
            fw.write(code_contents);
            fw.flush();
            fw.close();

            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/mysql_execute.sh");

            // ファイルが存在しなければここでストップ
            while (!(result_file.exists())) {
            }

            FileReader fr1 = new FileReader(
                    "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/mysql_result3.txt");
            int c1 = fr1.read();
            while (c1 != -1) {
                mysql_result = mysql_result + (char) c1;
                c1 = fr1.read();
            }
            fr1.close();

            FileReader fr2 = new FileReader(
                    "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/table_show3.txt");
            int c2 = fr2.read();
            while (c2 != -1) {
                table_show = table_show + (char) c2;
                c2 = fr2.read();
            }
            fr2.close();

            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/mysql_result_clear.sh");

            request.setAttribute("mysql_result", mysql_result);
            request.setAttribute("table_show", table_show);
            request.setAttribute("code_contents", code_contents);
            request.getRequestDispatcher("code_input.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
