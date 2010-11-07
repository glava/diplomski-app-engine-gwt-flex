package goran.com.server;

import goran.com.jdo.ToDoUser;
import goran.com.jdo.test.Book;
import goran.com.jdo.test.Chapter;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.management.openmbean.KeyAlreadyExistsException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.appengine.api.datastore.Key;

public class ListBookServlert extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Book b = (Book) pm.getObjectById(Book.class,"JDO 4eva1");
		for(int i=0;i<b.getChapters().size();i++)
		{
			Chapter c = b.getChapters().get(i);
			c.getId();
		}
		if (req.getSession().getAttribute("user") != null) {
			resp.getWriter().println("success");
		} else {
			resp.getWriter().println("failure");
		}
//		pm.currentTransaction().begin();
//		try {
//		    pm.makePersistent(b);
//		    pm.currentTransaction().commit();
//		} finally {
//		    if (pm.currentTransaction().isActive()) {
//		        pm.currentTransaction().rollback();
//		    }
//		}
	}
}
