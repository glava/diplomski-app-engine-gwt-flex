package goran.com.server;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckSession extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		if (req.getSession().getAttribute("user") != null) {
			resp.getWriter().println("Hello, user");
		} else {
			resp.getWriter().println("Hello, non user");
		}
	}

}
