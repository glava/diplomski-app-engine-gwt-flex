package goran.com.server;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import goran.com.jdo.Tag;
import goran.com.jdo.ToDo;
import goran.com.jdo.ToDoUser;
import javax.mail.internet.InternetAddress;
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

import org.apache.catalina.core.ApplicationContext;

import com.google.appengine.api.datastore.KeyFactory;
import java.util.logging.Logger;

public class Data {
	
	 private static final Logger log = Logger.getLogger(Data.class.getName());
	
	public void createData(String key, String value) {

		if (true) {
			return;
		}
	}
	public ToDoUser login(String username, String password) {

		Boolean loggedIn = false;
		PersistenceManager pm = PMF.get().getPersistenceManager();

		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class, username);
		pm.close();
		if (newToDoUser != null) {
			if (newToDoUser.password.equals(password)) {
				loggedIn = true;
				return newToDoUser;
			}
		}
		return null;
	}

	public List<ToDoVo> getToDoList(ToDoUserVo toDoUserVo) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class,
				toDoUserVo.username);
		pm.close();
		if (newToDoUser != null) {
			
			return convertToDoList(newToDoUser.toDoTasks);
		}
		return null;
	}
	
	public List<ToDoVo> convertToDoList(List<ToDo> toDoList)
	{
		List<ToDoVo> toDoVoList = new ArrayList<ToDoVo>();
		for(int i=0;i<toDoList.size();i++)
		{
			ToDoVo toDoVo = new ToDoVo();
			toDoVo.date = toDoList.get(i).getDate();
			toDoVo.priority = toDoList.get(i).getPriority();
			toDoVo.toDoMsg = toDoList.get(i).getToDoMsg();
			toDoVo.done = toDoList.get(i).getDone();
			toDoVo.key = toDoList.get(i).getKey().toString();
			toDoVoList.add(toDoVo);
		}
		return toDoVoList;
	}
	
	public Boolean deleteToDo(ToDoUserVo toDoUserVo,ToDoVo toDoVo)
	{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class,
				toDoUserVo.username);
		if (newToDoUser != null) {
			for(int i=0;i<newToDoUser.toDoTasks.size();i++)
			{
				if(newToDoUser.toDoTasks.get(i).getKey().toString().equals(toDoVo.key))
				{
					ToDo newToDO = pm.getObjectById(ToDo.class,newToDoUser.toDoTasks.get(i).getKey());
					pm.deletePersistent(newToDO);
				}
			}
		}
		pm.close();
		
		return true;
	}
	public Boolean updateToDoVo(ToDoUserVo toDoUserVo,ToDoVo toDoVo)
	{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class,
				toDoUserVo.username);
		if (newToDoUser != null) {
			for(int i=0;i<newToDoUser.toDoTasks.size();i++)
			{
				if(newToDoUser.toDoTasks.get(i).getKey().toString().equals(toDoVo.key))
				{
					ToDo newToDO = pm.getObjectById(ToDo.class,newToDoUser.toDoTasks.get(i).getKey());
					newToDO.setDone(toDoVo.done);
				}
			}
		}
		pm.close();
		return true;
	}
	
	public Boolean logOut(ToDoUserVo toDoUserVo)
	{
		return true;
	}
	
	public List<ToDo> getDoneToDoList(ToDoUserVo toDoUserVo) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class,
				toDoUserVo.username);
		if (newToDoUser != null) {
			List<ToDo> doneTasks = new ArrayList<ToDo>();
			for(int i=0;i<newToDoUser.toDoTasks.size();i++)
			{
				if(newToDoUser.toDoTasks.get(i).getDone())
				{
					doneTasks.add(newToDoUser.toDoTasks.get(i));
				}
			}
			pm.close();
			return doneTasks;
		}
		   pm.close();
		return null;
	}

	public boolean createToDo(ToDoUserVo toDoUserVo, ToDoVo toDoVo) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class,
				toDoUserVo.username);
		if (newToDoUser != null) {
			ToDo toDo = new ToDo();
			toDo.setDate(toDoVo.date);
			if(toDo.getDate() == null)
			{
				toDo.setDate(new Date());
			}
			toDo.setDone(false);
			toDo.setPriority(toDoVo.priority);
			toDo.setToDoMsg(toDoVo.toDoMsg);
			toDo.user = newToDoUser;

			newToDoUser.toDoTasks.add(toDo);
		}
		pm.makePersistent(newToDoUser);
		 pm.close();
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
		
		pm.close();
		return returnUser;

	}
	public ToDoUserVo registerUser(ToDoUserVo toDoUserVO) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser newToDoUser = fetchUser(toDoUserVO.username, pm);
		ToDoUserVo returnUser = null;
		if (newToDoUser == null) {
//			creates new ToDoUser and stores it
			newToDoUser = new ToDoUser();
			newToDoUser.password = toDoUserVO.password;
			newToDoUser.username = toDoUserVO.username;
			newToDoUser.setKey(KeyFactory.createKey(ToDoUser.class
					.getSimpleName(), newToDoUser.username));

			pm.currentTransaction().begin();
			try {
				pm.makePersistent(newToDoUser);
				pm.currentTransaction().commit();
			} finally {
				if (pm.currentTransaction().isActive()) {
					pm.currentTransaction().rollback();
				}
			}
			returnUser = toDoUserVO;
		}
		pm.close();
		return returnUser;
		
	}
	
	public ToDoUser fetchUser(String username, PersistenceManager pm) {
		ToDoUser newToDoUser;
		
		try {
			newToDoUser = pm.getObjectById(ToDoUser.class, username);
		} catch (Exception e) {
//			didint find it
			newToDoUser = null;
		}
			return newToDoUser;
	
	}

	public Boolean sendMail(HelpMailVo mailVo) {
			log.info("mai zahtev");
		    Properties props = new Properties();
		    Session mailSession = Session.getDefaultInstance(props, null);    
		    Message msg = new MimeMessage(mailSession);
		    String email = "gojkic@gmail.com";
		  
		    try {
				msg.setFrom(new InternetAddress(email));
			} catch (AddressException e) {
				log.severe("mail greska: admin."+e.getMessage());
				e.printStackTrace();
			} catch (MessagingException e) {
				
				e.printStackTrace();
				log.severe("mail greska: admin."+e.getMessage());
			}
			
		    try {
				msg.addRecipient(Message.RecipientType.TO,
				                 new InternetAddress(mailVo.toMail));
			} catch (AddressException e) {
				
				e.printStackTrace();
				log.severe("mail greska: receipent."+e.getMessage());
			} catch (MessagingException e) {
				
				e.printStackTrace();
				log.severe("mail greska: receipent."+e.getMessage());
			}
		    try {
				msg.setSubject("ToDoLaa Mail");
				msg.setText(mailVo.toDoMsg);
			} catch (MessagingException e) {
				
				log.severe("mail greska: setovanje tekst."+e.getMessage());
			}
		    try {
				Transport.send(msg);
			} catch (MessagingException e) {
				
				e.printStackTrace();
			   log.severe("mail greska: transport."+e.toString());
			}
			 log.info("mai poslat");
		    return true;
	}
}
