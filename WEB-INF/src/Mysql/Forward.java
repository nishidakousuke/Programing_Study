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
        try {
            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/table_show.sh");

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

            System.out.println(table_show);

            rt.exec("/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql/mysql_result_clear.sh");

            request.setAttribute("table_show", table_show);
            request.getRequestDispatcher("code_input.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
