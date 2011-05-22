package goran.com.server.session;

import goran.com.jdo.ToDoUser;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckSession extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		if (req.getSession().getAttribute("user") != null) {
			String toDoUser = ((ToDoUser) req.getSession().getAttribute("user")).username;
			resp.getWriter().println(toDoUser+"%");
		} else {
			resp.getWriter().println("null");
		}
	}

}
