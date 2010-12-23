package goran.com.server;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import goran.com.jdo.Tag;
import goran.com.jdo.ToDo;
import goran.com.jdo.ToDoUser;
import goran.com.model.HelpMailVo;
import goran.com.model.ToDoUserVo;
import goran.com.model.ToDoVo;

import javax.jdo.PersistenceManager;
import javax.mail.internet.MimeMessage;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

public class Data {
	public void createData(String key, String value) {

		if (true) {
			return;
		}
	}

	public ToDoUser login(String username, String password) {

		Boolean loggedIn = false;
		PersistenceManager pm = PMF.get().getPersistenceManager();

		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class, username);
		if (newToDoUser != null) {
			if (newToDoUser.password.equals(password)) {
				loggedIn = true;
				return newToDoUser;
			}
		}
		return null;
	}

	public List<ToDo> getToDoList(ToDoUserVo toDoUserVo) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class,
				toDoUserVo.username);
		if (newToDoUser != null) {
			return newToDoUser.toDoTasks;
		}
		return null;
	}

	public boolean createToDo(ToDoUserVo toDoUserVo, ToDoVo toDoVo) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class,
				toDoUserVo.username);
		if (newToDoUser != null) {
			ToDo toDo = new ToDo();
			toDo.date = toDoVo.date;
			toDo.priority = toDoVo.priority;
			toDo.toDoMsg = toDoVo.toDoMsg;
			toDo.user = newToDoUser;

			newToDoUser.toDoTasks.add(toDo);
		}
		pm.makePersistent(newToDoUser);
		return true;
	}

	public ToDoUserVo loginUser(ToDoUserVo toDoUserVO) {
		Boolean loggedIn = false;
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUserVo returnUser = null;
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class,
				toDoUserVO.username);
		if (newToDoUser != null) {
			if (newToDoUser.password.equals(toDoUserVO.password)) {
				loggedIn = true;
			}
		}
		if (loggedIn) {
			returnUser = new ToDoUserVo();
			returnUser.username = toDoUserVO.username;
		}

		return returnUser;

	}

	public Boolean sendMail() {
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);

		try {
			Message msg = new MimeMessage(session);
			try {
				msg.setFrom(new InternetAddress("gojkic@gmail.com",
						"Example.com Admin"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
						"goran.ojkic@gmail.com", "Mr. User"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			msg.setSubject("Your Example.com account has been activated");
			msg.setText("gorane ti si legenda");
			Transport.send(msg);

		} catch (AddressException e) {
			// ...
		} catch (MessagingException e) {
			// ...

		}
		return true;
	}
}
