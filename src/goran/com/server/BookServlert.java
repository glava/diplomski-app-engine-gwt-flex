package goran.com.server;

import goran.com.jdo.ToDo;
import goran.com.jdo.ToDoUser;
import goran.com.jdo.test.Book;
import goran.com.jdo.test.Chapter;
import goran.com.model.TagVo;
import goran.com.model.ToDoUserVo;
import goran.com.model.ToDoVo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.KeyFactory;

public class BookServlert extends HttpServlet {
	private boolean write = true;
	private boolean read = true;

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		Book b = new Book();
		b.setTitle("JDO 4eva1");
		Chapter c1 = new Chapter();
		c1.setTitle("Intro");
		c1.setNumPages(10);
		b.getChapters().add(c1);
		Chapter c2 = new Chapter();
		c2.setTitle("Configuration");
		c2.setNumPages(9);
		b.getChapters().add(c2);
		b.setId(KeyFactory.createKey(Book.class.getSimpleName(),
				b.getTitle()));
		
//		MOCKING THE ToDoVo
		ToDoVo toDoVo = new ToDoVo();
		toDoVo.date = new Date();
		toDoVo.priority = 1;
		TagVo tag = new TagVo();
		tag.name = "posao";
		TagVo tag1 = new TagVo();
		tag1.name = "kuca";
		toDoVo.tags = new ArrayList<TagVo>();
		toDoVo.tags.add(tag);
		toDoVo.tags.add(tag1);
		toDoVo.toDoMsg = "uradi nešto debilu";
//		MOCKING THE ToUserVo
		ToDoUserVo toDoUserVo = new ToDoUserVo();
		toDoUserVo.username = "goran";
		
		PersistenceManager pm = PMF.get().getPersistenceManager();
		if(write)
		{
			ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class, toDoUserVo.username);
			ToDo toDo = new ToDo();
			toDo.date = toDoVo.date;
			toDo.toDoMsg = toDoVo.toDoMsg;
			toDo.priority = toDoVo.priority;
			toDo.user = newToDoUser;
			newToDoUser.toDoTasks.add(toDo);
			
			
		}
		if(read)
		{
			
		}
		
		
		pm.currentTransaction().begin();
		try {
		    pm.makePersistent(b);
		    pm.currentTransaction().commit();
		} finally {
		    if (pm.currentTransaction().isActive()) {
		        pm.currentTransaction().rollback();
		    }
		}
	}
}
