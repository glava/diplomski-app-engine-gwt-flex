package goran.com.jdo;

import java.util.ArrayList;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class ToDoUser {
	   
	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key key;
	
	@Persistent
	private String username;
	@Persistent
	private String password;
	 @Persistent
	private ArrayList<String> favoriteFoods;
	
	 public ToDoUser(String username, String pasword){
		this.username = username;
		this.password = pasword;
	}

	public void setKey(Key key) {
		this.key = key;
	}

	public Key getKey() {
		return key;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsername() {
		return username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}

	public void setFavoriteFoods(ArrayList<String> favoriteFoods) {
		this.favoriteFoods = favoriteFoods;
	}

	public ArrayList<String> getFavoriteFoods() {
		return favoriteFoods;
	}
	
}