package Ruby;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.*;

@WebServlet(urlPatterns = { "/Ruby/ruby_help" })
public class RubyHelp extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        String file_content = "";
        try {
            String ruby_help_content = request.getParameter("ruby_help_content");
            String code_contents = request.getParameter("ruby_help_source");
            int delimiter_index = code_contents.indexOf("qwer");
            String code_contents1 = code_contents.substring(0, delimiter_index);
            String code_contents2 = code_contents.substring(delimiter_index + 4, code_contents.length());

            FileReader fr = new FileReader(
                    "/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby/" + ruby_help_content + ".txt");
            int c = fr.read();
            while (c != -1) {
                file_content = file_content + (char) c;
                c = fr.read();
            }
            fr.close();

            request.setAttribute("file_content", file_content);
            request.setAttribute("code_contents1", code_contents1);
            request.setAttribute("code_contents2", code_contents2);
            request.getRequestDispatcher("code_input.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
