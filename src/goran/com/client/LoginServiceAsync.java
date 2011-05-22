package goran.com.client;

import com.google.gwt.user.client.rpc.AsyncCallback;

public interface LoginServiceAsync {

	void login(String username, String password, AsyncCallback<Boolean> callback);
	void register(String username, String password, AsyncCallback<Boolean> callback);
	void checkLoginStatus(AsyncCallback<Boolean> callback);

}
