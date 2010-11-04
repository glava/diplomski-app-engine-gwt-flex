package goran.com.server;

import goran.com.jdo.ToDoUser;
import java.io.IOException;
import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.appengine.api.datastore.KeyFactory;

public class SaveUser extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

//		CREATES NEW USER AND PASSWORD FOR TESTING ONLY 
//		ToDoUser newToDoUser = new ToDoUser("goran", "123");
//		PersistenceManager pm = PMF.get().getPersistenceManager();
//		newToDoUser.setKey(KeyFactory.createKey(ToDoUser.class.getSimpleName(),
//				newToDoUser.getUsername()));
//		pm.makePersistent(newToDoUser);
	}
}
