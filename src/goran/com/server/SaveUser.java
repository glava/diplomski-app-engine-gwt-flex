package goran.com.server;

import goran.com.jdo.Tag;
import goran.com.jdo.ToDo;
import goran.com.jdo.ToDoUser;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.appengine.api.datastore.KeyFactory;

public class SaveUser extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		// CREATES NEW USER AND PASSWORD FOR TESTING ONLY
		ToDoUser newToDoUser = new ToDoUser();
		newToDoUser.username = "goran2";
		newToDoUser.password = "123";

		
		PersistenceManager pm = PMF.get().getPersistenceManager();
		newToDoUser.setKey(KeyFactory.createKey(ToDoUser.class.getSimpleName(),
				newToDoUser.username));

		pm.currentTransaction().begin();
		try {
			pm.makePersistent(newToDoUser);
			pm.currentTransaction().commit();
		} finally {
			if (pm.currentTransaction().isActive()) {
				pm.currentTransaction().rollback();
			}
		}
	}
}

// // newToDo.tag = new ArrayList<Tag>();
// Tag tag = new Tag();
// tag.name = "posao";
// // newToDo.tag.add(tag);